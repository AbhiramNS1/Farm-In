import express from "express"
import { Request} from "express";
import db from '../libs/database.js'
import { Security } from '../libs/security.js'
import multer from 'multer';
import { ObjectStorage } from "../libs/objectstorage.js";
const userRouter = express.Router()


userRouter.post("/login",async (req,res)=>{
    const {username,password}=req.body
    const result = await db.ValidateUser(username,password)
    console.log(result)
    res.json(result)
})


const upload = multer({ storage:multer.memoryStorage() });

userRouter.post("/signup",upload.single('file'), ObjectStorage.connection.uploadImage,async (req,res)=>{
    console.log(req.body)
    await db.AddNewUser(req)
    const result = await db.ValidateUser(req.body.email,req.body.password)
    res.json({status:true,result})
})


userRouter.use(Security.AuthenticateUser)

userRouter.post("/auth",async (req:Request,res)=>{
    res.send(req.user) 
})

userRouter.post("/userdetails")

export default userRouter