import * as mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { Security, User } from './security.js';
import { Request } from 'express';
dotenv.config()


class DataBase {
    
    private static instance: DataBase;
    private pool: mysql.Pool;
    public static getInstance(): DataBase {
        if (!DataBase.instance) {
            DataBase.instance = new DataBase();
            DataBase.instance.pool= mysql.createPool({
                host: process.env.MYSQL_HOST,
                user: process.env.MYSQL_USER,
                password: process.env.MYSQL_PASSWORD,
                database: 'FarmIn',
                connectionLimit: 10,
            });
        }
        return DataBase.instance;
    }

    private async executeQuery<T>(query: string, params?: any[]): Promise<T[] | null> {
        try {
            const connection = await this.pool.getConnection();
            let result = await connection.query(query, params);
            connection.release();
            console.log(result[0]);
            return result[0] as T[];
        }
        catch (err) {
            console.log(err);
            return null;
        }
    }
    

   public async ValidateUser(useremail:string,password:string ):Promise<{error?:String,token?:String,id?:number}>{
        if(!(useremail && password)){
            return {error:"username or password is missing"}
        }
        else if(password.length<8){
            return {error:"Invalid password length"}
        }
        
        const result = await this.executeQuery<User>("select id,name,email from Investors where email = ? and password_hash = ? limit 1",[useremail,password])
      
        if(!result || result.length==0) return {error:"Invalid username or password"}
        const token = Security.generateToken({id:result[0].id,name:result[0].name,email:useremail} as User)
      
        return {token,id:result[0].id}
   }

   public async ValidateFarmer(useremail:string,password:string ):Promise<{error?:String,token?:String,id?:number}>{
    if(!(useremail && password)){
        return {error:"username or password is missing"}
    }
    else if(password.length<8){
        return {error:"Invalid password length"}
    }
    
    const result = await this.executeQuery<User>("select id,name,email from Farmers where email = ? and password_hash = ? limit 1",[useremail,password])
  
    if(!result || result.length==0) return {error:"Invalid username or password"}
    const token = Security.generateToken({id:result[0].id,name:result[0].name,email:useremail} as User)
  
    return {token,id:result[0].id}
}

   public async doesUserExist(user:User){
        const result = await this.executeQuery<User>("select count(*) from Investors where email = ? and id=? and name = ? limit 1",[user.email,user.id,user.name])
        if(!result || result.length==0) return false
        return true
   }
  
   public async getPicks(){
        const result = await this.executeQuery("select * from Picks order by todays_change desc")
        return result
   }

   public async getMyHoldings(inverstorId : number){
        const result = await this.executeQuery("select * from Assets left join Picks on Picks.id=Assets.pick_id where investor_id=?",[inverstorId])
        return result
   }

   public async getSummary(pick_id : number){
        const result = await this.executeQuery("select address,area,avg_temp,avg_humidity,avg_pressure,avg_windspeed,latitude,longitude,name as farmer,total_amount,farmer_id,total_qty from  Requests natural join Farmers natural join FarmLands where Requests.pick_id = ?",[pick_id])
        result.push(await this.executeQuery("select * from Picks limit 5"));
        return result
   }

   public async buy(req:Request,pick_id:number,qty:number){
    const result = await this.executeQuery("INSERT INTO Assets (investor_id, pick_id, contract_address,profit,qty) Values(?,?,?,?,?)",[req.user.id,pick_id,"0x8938932898",0,qty])
    return {status:(result!=null)};
   }

   public async getDetails(pick_id : number){
    const result = await this.executeQuery("select * from  Requests where Requests.pick_id = ?",[pick_id])
    result.push(await this.executeQuery("select * from Picks limit 5"));
    return result

   }

   public async AddNewUser(req:Request){
    const result = await this.executeQuery("INSERT INTO Investors (name, email, password_hash, pan_card,adhar_no,address) Values(?,?,?,?,?,?)",[req.body.name,req.body.email,req.body.password,req.body.filename,req.body.adhar ,req.body.address]);
    return {status:(result!=null)};
   }


   public async AddNewFarmer(req:Request){
    const result = await this.executeQuery("INSERT INTO Farmers (name, email, password_hash,adhar_no,address) Values(?,?,?,?,?)",[req.body.name,req.body.email,req.body.password,req.body.adhar,req.body.address]);
    return {status:(result!=null)};
   }

   public async AddPicks(req:Request){
    const {cropName,category,description,variety,marketprice,timespan,season}=req.body
    const result = await this.executeQuery("INSERT INTO Crops (name,category,description,verity,market_price,time_span,season) Values(?,?,?,?,?,?,?)",[cropName,category,description,variety,marketprice,timespan,season]);
    return {status:(result!=null)};
   }

   public async  AddNewFundingRequest(req:Request){
    const { statingDate, endingDate, totalAmount, availAmount,cropName, farmland, area,}=req.body
    const result = await this.executeQuery("insert into FundingRequests (farmer_id, farmland_id, crop_id, total_amount,avilable_amount,starting_date,ending_date,area) Values(?,?,?,?,?,?,?,?)",[req.user.id, farmland.value,cropName.value, totalAmount, availAmount,statingDate, endingDate,area]);
    return {status:(result!=null)};
   }

   public async getCrops(){
        const result = await this.executeQuery("select name as label ,id as value from  Crops")
        return result
   }
   public async getFarmLand(user:User){
        const result = await this.executeQuery("select address as label ,id as value,area,latitude,longitude from  FarmLands where farmer_id = ?",[user.id])
        return result
    }
    public async getRequests(user:User){
        const result = await this.executeQuery("select FundingRequests.id as id,total_amount ,avilable_amount, FundingRequests.area,address from  FundingRequests left join FarmLands on FarmLands.id=FundingRequests.farmland_id where FundingRequests.farmer_id = ?",[user.id])
        return result
    }
    public async deleteRequests(id:number){
        const result = await this.executeQuery("delete  from  FundingRequests  where FundingRequests.id = ?",[id])
        return result
    }
    public async AddNewFarmLand(req:Request){
        const {address,area,pre,hum,tem,lat,long,filename}=req.body
        const result = await this.executeQuery("INSERT INTO FarmLands (address, farmer_id,area, avg_temp, avg_humidity, avg_pressure, latitude, longitude,document) values(?,?,?,?,?,?,?,?,?)",[address,req.user.id,area,tem,hum,pre,lat,long,filename]);
    }
}
const db = DataBase.getInstance()
export {DataBase}
export default db;