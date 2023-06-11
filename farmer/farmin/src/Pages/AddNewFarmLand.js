import React, { useState } from 'react';
import { Button, TextField, Grid, Container, Typography, Alert, AlertTitle, Popover, Dialog } from '@mui/material';
import Config from '../Config';
import SuccessDialog from '../Components/Dialog';
import { redirect, useNavigate } from 'react-router-dom';

import CloudUploadIcon from '@mui/icons-material/CloudUpload';




const AddFarmLand = () => {

    const navigate=useNavigate()
  const [address,setAddress] = useState('');
  const [area,setArea] = useState('');
  const [pre,setPre] = useState('');
  const [tem,setTem] = useState('');
  const [hum,setHum] = useState();
  const [lat,setLat] = useState('');
  const [long,setLong] = useState();

  const [error,setError] = useState(false);
  const [sucess,setSuccess] = useState(false);

  const [selectedFile, setSelectedFile] = useState(null);
 



  const handleSubmit = async (e) => {

    e.preventDefault();
    const data = new FormData();
    data.append('file',selectedFile)
    data.append('address',address)
    data.append('area',area)
    data.append('pre',pre)
    data.append('hum',hum)
    data.append('tem',tem)
    data.append('lat',lat)
    data.append('long',long)
    data.append('token',localStorage.getItem('token'))
    
    const response= await fetch(`${Config.SERVER}/farmer/new_farmland`, {
           
            method:'POST',
            body :data
    })
    if(response.status==200){
        if((await response.json()).status){
         setSuccess(true)
        }
       }
    
  };

  return (
   
    <Container maxWidth="600px"  sx={{marginTop:"40px"}}>
        <SuccessDialog open={sucess} text="Farmland added successfully"  onClose={()=>{
                setSuccess(false)
                navigate("/")
        }} />
        <Typography fontSize={30} sx={{margin:"20px"}}>
            Add a new Crop
        </Typography>
       
    <form onSubmit={handleSubmit}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <TextField
            label="Address"
            value={address}
            autoComplete='address'
            onChange={(e) => setAddress(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Area"
            value={area}
            onChange={(e) => setArea(e.target.value)}
            fullWidth
          />
        </Grid>
     
        <Grid item xs={12}>
          <TextField
            label="Average pressure"
            value={pre}
            onChange={(e) => setPre(e.target.value)}
            fullWidth
            type='number'
          />
        </Grid>

        <Grid item xs={12}>
          <TextField
            label="Average temperature"
            value={tem}
            type='number'
            onChange={(e)=> setTem(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Average humidity"
            value={hum}
            type='number'
            onChange={(e)=> setHum(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            label="latitude"
            value={lat}
            type='number'
            onChange={(e)=> setLat(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12} sm={6}>
          <TextField
            label="longitude"
            value={long}
            type='number'
            onChange={(e)=> setLong(e.target.value)}
            fullWidth
          />
        </Grid>
        <FileUpload text={selectedFile==null?"No file selected":selectedFile.name} onFileChanged={(e)=>setSelectedFile(e.target.files[0])} buttonText="upload document"/>
    
        
        <Grid item xs={12}>
        {error?(
            <Alert severity="error" style={{marginBottom:"20px"}}> 
            <AlertTitle>Fill all fields</AlertTitle>
            Please fill all nessasary fields bedore submitting
          </Alert>
        ):""}
          <Button type="submit" variant="contained" color="primary"
          onClick={handleSubmit}
          >
            Add Farmland
          </Button>
        </Grid>
      </Grid>
    </form>
    </Container>
  );
};

export default AddFarmLand;



const FileUpload = ({onFileChanged,buttonText,text}) => {

    // data.append('file', selectedFile);
  
    // <FileUpload  
    // text={(selectedFile==null)?"No file selected":selectedFile.name} 
    // buttonText="Upload Aadhar" 
    // onFileChanged={handleFileChange}
    // />
   
  
    return (
      <Container sx={{ display: 'flex', justifyContent: 'space-between',marginTop:'20px' }}>
        <Typography variant="h6" display="inline">
      {text}
      </Typography>
        <input
          type="file"
          id="upload-file"
          style={{ display: 'none' }}
          onChange={onFileChanged}
        />
        <label htmlFor="upload-file">
          <Button
            variant="outlined"
            component="span"
            startIcon={<CloudUploadIcon />}
          >
           {buttonText}
          </Button>
        </label>
      </Container>
    );
  };