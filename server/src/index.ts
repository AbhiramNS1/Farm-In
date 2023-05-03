import  express from 'express'
import router from './routes/user.js'
import Database from './db/database.js'
import jwt, { JwtPayload } from 'jsonwebtoken';
import mysql from 'mysql2'

const app = express()

app.use(express.json())
app.use(express.urlencoded({extended:true}))





interface Token {
  token: string;
}

interface User {
  id: number;
  name: string;
  email: string;
  password: string;
}

const pool=mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: 'FarmIn',
    connectionLimit: 10,
});


function generateToken(user: User): Token {
    const payload: JwtPayload = {
      id: user.id,
      name: user.name,
      email: user.email
    };
  
    const token = jwt.sign(payload, process.env.JWT_SECRET);
  
    return { token };
  }
  


  function verifyToken(token: string): JwtPayload {
    return jwt.verify(token, process.env.JWT_SECRET) as JwtPayload;
  }
  


app.get("/",(req,res)=>{
   Database.getInstance()
   .isVaildUser("user@farmin.com","pooruser")
   .then((res)=>{
        if(res){
            console.log("valid user")
        }else{
            console.log("invalid user")
        }
   })
   res.send("index")
})



function executeQuery<T>(query: string, params: any[] = []): Promise<T[]> {
  return new Promise((resolve, reject) => {
    pool.getConnection((err, connection) => {
      if (err) {
        return reject(err);
      }
      
      connection.query(query, params, (error, results) => {
        connection.release();

        if (error) {
          return reject(error);
        }
        resolve(results);
      });
    });
  });
}



app.get("/login",(req,res)=>{
    
    
})

app.use("/users",router)

const port = process.env.PORT || 5000
app.listen(port ,()=>{
    console.log(`Server starte d in prt ${port}`)
})