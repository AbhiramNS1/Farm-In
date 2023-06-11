import express from "express"
import { Request} from "express";
import db from '../libs/database.js'
import { Security } from '../libs/security.js'


const picksRouter = express.Router()

picksRouter.use(Security.AuthenticateUser)

picksRouter.post("/home_page_picks",async (req,res)=>{
    res.send(await db.getPicks())
})

picksRouter.post("/my_holdings",async (req:Request,res)=>{
    res.send(await db.getMyHoldings(req.user.id))
})

picksRouter.post("/summary",async (req,res)=>{
    const pick_id = req.body.pick_id
    res.send(await db.getSummary(pick_id))
})

picksRouter.post("/other_similar",async (req,res)=>{
    res.send(await db.getPicks())
})

picksRouter.post("/buy",async (req:Request,res)=>{
    res.json(await db.buy(req,req.body.pick_id,req.body.qty))
})
picksRouter.post("/details",async (req,res)=>{
    res.json(await db.getDetails(req.body.pick_id))
})

picksRouter.post("/add_crop",async (req,res)=>{
    res.json(await db.AddPicks(req))
})

export default picksRouter
