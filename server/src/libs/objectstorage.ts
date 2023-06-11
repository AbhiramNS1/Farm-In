import { NextFunction, Request, Response } from 'express';
import * as uuid from 'uuid';
import dotenv from 'dotenv';
import { S3Client, PutObjectCommand, DeleteObjectCommand } from "@aws-sdk/client-s3";

dotenv.config()


class ObjectStorage{
  private static instance:ObjectStorage;
  
  private s3Client=new S3Client({
    region: process.env.BUCKET_ACCESS_REGION, 
    endpoint: process.env.BUCKET_ENDPOINT,
    credentials: {
          accessKeyId: process.env.BUCKET_ACCESS_ID!,
          secretAccessKey: process.env.BUCKET_ACCESS_KEY!,
    }});
  private ObjectStorage(){


    this.s3Client = new S3Client({
      region: process.env.BUCKET_REGION, 
      endpoint: process.env.BUCKET_ENDPOINT,
      credentials: {
            accessKeyId: process.env.BUCKET_ACCESS_ID!,
            secretAccessKey: process.env.BUCKET_ACCESS_KEY!,
      },
});
  }
  public static get connection(){
    if(!ObjectStorage.instance){
     
      ObjectStorage.instance=new ObjectStorage()
  };

    
    return ObjectStorage.instance
    
  }

  public async uploadImage(req: Request, res: Response,next: NextFunction) {
    const file= req.file;
    
    if(!file){
      return res.json({message:'No file Provided'});
    }
    const extension = file.originalname.match(/\.(.*)/)?.[0]
    if(!extension){
      return res.json({message:'Invalid file extension'});
    }
    console.log(extension)
    if (!['.jpg', '.jpeg', '.png', '.webp'].includes(extension)) {
      res.status(400).send('Invalid file type');
      return;
    }

    console.log("File recived ////...")
    req.body.filename=`${uuid.v4()}_pan.jpg`
    const path=`pancards/${req.body.filename}`
    const command = new PutObjectCommand({
      Bucket:"farmin",
      Key: path, 
      Body: file.buffer,
    });
    
    try {
      console.log("trying to send file recived ////...")
        const response = await ObjectStorage.connection.s3Client.send(command);
        console.log(response);
        next();
    }
     catch (err) {
      console.log("unable to send file ////...")
      res.json({message:'File Upload Failed'});
      console.error(err);
   
    }

  }


  public async deleteImage(req: Request, res: Response){
    const params = {
      Bucket: process.env.BUCKET_NAME,
      Key: req.body.img
    };

    try {
      const result = await this.s3Client.send(new DeleteObjectCommand(params));
      console.log(result);
      
    } catch (error) {
      console.log(error);
    }
  
  }

}


export {ObjectStorage}


