import  express from 'express'
import userRouter from './routes/user.js'
import picksRouter from './routes/picks.js'
import farmerRouter from './routes/farmer.js'
import cors from 'cors'



const app = express()
app.use(cors())


app.use(express.json())
app.use(express.urlencoded({extended:true}))

app.use(express.static(`D:/Others/Android/mini project/Farm-In/server/dist/public`));


app.use((req,res,next)=>{
    console.log("Request recived ")
    console.dir(req.body)
    next()
})
app.use("/farmer",farmerRouter)
app.use("/users",userRouter)
app.use("/picks",picksRouter)








const port = process.env.PORT || 5000
app.listen(port ,()=>{
    console.log(`Server starte d in prt ${port}`)
})