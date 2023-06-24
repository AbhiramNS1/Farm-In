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
                port:3307,
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

   public async ValidateEmp(useremail:string,password:string ):Promise<{error?:String,token?:String,id?:number}>{
            if(!(useremail && password)){
                return {error:"username or password is missing"}
            }
            else if(password.length<8){
                return {error:"Invalid password length"}
            }
            
            const result = await this.executeQuery<User>("select id,name,email from Admin where email = ? and password_hash = ? limit 1",[useremail,password])
        
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

// select * from Holdings join CropEquity on Holdings.crop_equity=CropEquity.id 
// join FundingRequests on  CropEquity.request_id=FundingRequests.id  
// join Crops   on  FundingRequests.crop_id=Crops.id 
// where Holdings.investor_id=17;

   public async doesUserExist(user:User){
        const result = await this.executeQuery<User>("select count(*) from Investors where email = ? and id=? and name = ? limit 1",[user.email,user.id,user.name])
        if(!result || result.length==0) return false
        return true
   }
  
   public async getPicks(){
        const result = await this.executeQuery("select CropEquity.id as id ,name,category,CropEquity.price as price from CropEquity  join FundingRequests on FundingRequests.id=CropEquity.request_id join Crops on FundingRequests.crop_id=Crops.id")
        return result
   }
   public async getMyHoldings(inverstorId : number){
        const result = await this.executeQuery("select CropEquity.id as id,Crops.time_span as time_peroid,Holdings.id as h_id,CropEquity.price as market_price ,name,Holdings.qty as qty,price,category from Holdings join CropEquity join FundingRequests join Crops  on Holdings.crop_equity=CropEquity.id and CropEquity.request_id=FundingRequests.id and FundingRequests.crop_id=Crops.id where Holdings.investor_id=?",[inverstorId])
        return result
   }

   public async getSummary(pick_id : number){
        const result = await this.executeQuery("select address,CropEquity.qty as total_qty ,FundingRequests.area as area,avg_temp,avg_humidity,avg_pressure,latitude,longitude,name as farmer,total_amount,FarmLands.farmer_id as farmer_id,qty from CropEquity join FundingRequests on CropEquity.request_id=FundingRequests.id join Crops on FundingRequests.crop_id = Crops.id join FarmLands on FundingRequests.farmland_id =FarmLands.id where CropEquity.id=?",[pick_id])
        result.push(await this.executeQuery("select * from Crops limit 5"));
        return result
   }

   public async buy(req:Request,qty:number,crop_id:number){
    const result = await this.executeQuery("INSERT INTO Holdings (investor_id,qty,  crop_equity,date_of_buy) Values(?,?,?,?)",[req.user.id,qty,crop_id,new Date().toISOString().split('T')[0]])
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
        const result = await this.executeQuery("select FundingRequests.id as id,FundingRequests.state,total_amount ,avilable_amount, FundingRequests.area,address from  FundingRequests left join FarmLands on FarmLands.id=FundingRequests.farmland_id where FundingRequests.farmer_id = ?",[user.id])
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
    public async getPendingRequest(){
        const result = await this.executeQuery("select FundingRequests.id as id,total_amount ,avilable_amount, FundingRequests.area,FarmLands.address,Farmers.adhar_no as adhar from  FundingRequests left join FarmLands  on FarmLands.id=FundingRequests.farmland_id right join Farmers on Farmers.id=FundingRequests.farmer_id  where state = 'pending'");
        return result
    }
    public async approveRequest(id:number,qty:number,price:number){
        const result = await this.executeQuery("update FundingRequests set state = 'approved' where id =?",[id]);
        await this.executeQuery("insert into CropEquity(request_id,qty,price) values(?,?,?)",[id,qty,price]);
        return result
    }
    public async rejectRequest(id:number){
        const result = await this.executeQuery("update FundingRequests set state = 'rejected' where id =?",[id]);
        return result
    }
    public async getApprovedRequests(){
        const result = await this.executeQuery("select * from FundingRequests where state = 'approved'");
        return result
    }
    public async getRejectedRequests(){
        const result = await this.executeQuery("select * from FundingRequests where state = 'rejected'");
        return result
    }
}
const db = DataBase.getInstance()
export {DataBase}
export default db;