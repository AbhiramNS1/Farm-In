import express from "express"
import { Request} from "express";
import db from '../libs/database.js'
import { Security } from '../libs/security.js'

const userRouter = express.Router()


userRouter.post("/login",async (req,res)=>{
    const {username,password}=req.body
    const result = await db.ValidateUser(username,password)
    res.json(result)
})

userRouter.use(Security.AuthenticateUser)

userRouter.post("/auth",async (req:Request,res)=>{
    res.send(req.user) 
})


userRouter.post("/userdetails")

export default userRouter