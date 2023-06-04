import  express from 'express'
import userRouter from './routes/user.js'
import picksRouter from './routes/picks.js'
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


const app = express()

app.use(express.json())
app.use(express.urlencoded({extended:true}))


app.use((req,res,next)=>{
    console.log("Request recived ")
    console.dir(req.body)
    next()
})

app.use('/static', express.static(`${__dirname}/public`));

app.use("/users",userRouter)
app.use("/picks",picksRouter)




const port = process.env.PORT || 5000
app.listen(port ,()=>{
    console.log(`Server starte d in prt ${port}`)
})