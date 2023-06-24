import  express from 'express'
import userRouter from './routes/user.js'
import picksRouter from './routes/picks.js'
import farmerRouter from './routes/farmer.js'
import cors from 'cors'
import empRouter from './routes/employee.js'
import db from './libs/database.js'



const app = express()
app.use(cors())


app.use(express.json())
app.use(express.urlencoded({extended:true}))

app.use((req,res,next)=>{
    console.log("Request recived ")
    console.dir(req.body)
    next()
})
app.use("/farmer",farmerRouter)
app.use("/users",userRouter)
app.use("/picks",picksRouter)
app.use("/admin",empRouter)




const port = 5000
app.listen(5000 ,()=>{
    db.getCrops()
    console.log(`Server starte d in prt ${port}`)
})