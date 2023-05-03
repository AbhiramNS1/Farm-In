import express from 'express'
import DataBase from '../db/database.js'

const router = express.Router()

router.get("/",(req,res)=>{
    DataBase.getInstance().isVaildUser("XXXXX","admin").then(data=>{}).catch(err=>{})
    res.send("index")
})

router.get("/new",(req,res)=>{
    res.send("new")
})

export default router