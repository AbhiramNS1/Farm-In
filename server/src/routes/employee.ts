import express from "express"
import { Request} from "express";
import db from '../libs/database.js'
import { Security } from '../libs/security.js'
const empRouter = express.Router()


empRouter.post("/login",async (req,res)=>{
    const {username,password}=req.body
    const result = await db.ValidateEmp(username,password)
    res.json(result)
})

empRouter.use(Security.AuthenticateUser)

empRouter.post("/getPendingRequests",async (req,res)=>{
    const result = await db.getPendingRequest()
    res.json(result)
})
empRouter.post("/approve",async (req,res)=>{
    const result = await db.approveRequest(req.body.id,req.body.qty,req.body.price)
    res.json(result)
})

empRouter.post("/reject",async (req,res)=>{
    const result = await db.rejectRequest(req.body.id)
    res.json(result)
})
empRouter.post("/getApprovedRequests",async (req,res)=>{
    const result = await db.getApprovedRequests()
    res.json(result)
})
empRouter.post("/getRejectedRequests",async (req,res)=>{
    const result = await db.getRejectedRequests()
    res.json(result)
})
export default empRouter

