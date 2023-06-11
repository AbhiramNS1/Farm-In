import jwt,{ JwtPayload } from "jsonwebtoken";
import { Request,Response,NextFunction } from "express";
import { DataBase } from "./database.js";


interface User {
    id: number;
    name: string;
    email: string;
}

class Security{
    public static  generateToken(user:User): string {
        const payload: JwtPayload = {
          id: user.id,
          name: user.name,
          email: user.email
        };
        const token = jwt.sign(payload, process.env.JWT_SECRET);
        return token
    }
      
    // Middlewere for validating usertokens
    public static async AuthenticateUser(req:Request,res:Response,next:NextFunction){
        try{
            req.user = jwt.verify(req.body.token, process.env.JWT_SECRET) as User
            // if(DataBase.getInstance().doesUserExist(req.user))
                next()
            // else res.send({error:"UnAutherised access"})
        }catch(err){
            res.send({error:"UnAutherised access"})
            return
        }
    }
  
}

export {Security,User}
  