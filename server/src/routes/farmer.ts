import express from "express"
import { Request} from "express";
import db from '../libs/database.js'
import { Security } from '../libs/security.js'
import multer from 'multer';
import { ObjectStorage } from "../libs/objectstorage.js";
const farmerRouter = express.Router()


farmerRouter.post("/login",async (req,res)=>{
    const {username,password}=req.body
    const result = await db.ValidateFarmer(username,password)
    res.json(result)
})

const upload = multer({ storage:multer.memoryStorage() });

farmerRouter.post("/signup",upload.any() ,async (req,res)=>{
    console.log(req.body)
    await db.AddNewFarmer(req)
    const result = await db.ValidateFarmer(req.body.email,req.body.password)
    res.json({status:true,result})
})


farmerRouter.post("/new_farmland",upload.single('file'),Security.AuthenticateUser,ObjectStorage.connection.uploadImage,async (req,res)=>{
    console.log(req.body)
     await db.AddNewFarmLand(req)
    res.json({status:true})
})

farmerRouter.use(Security.AuthenticateUser)

farmerRouter.post("/getcrops",async (req:Request,res)=>{
    res.json(await db.getCrops())
})
farmerRouter.post("/getfarmland",async (req:Request,res)=>{
    res.json(await db.getFarmLand(req.user))
})
farmerRouter.post("/getRequests",async (req:Request,res)=>{
    res.json(await db.getRequests(req.user))
})
farmerRouter.post("/deletePendingRequest",async (req:Request,res)=>{
    res.json(await db.deleteRequests(req.body.id))
})

farmerRouter.post("/new_funding",async (req,res)=>{
    console.log(req.body)
    const result =await db.AddNewFundingRequest(req)
    res.json({status:true,result})
})

farmerRouter.post("/auth",async (req:Request,res)=>{
    res.send(req.user) 
})

farmerRouter.post("/userdetails")

export default farmerRouter
