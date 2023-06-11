import React, { useState } from 'react';
import { Button, TextField, Grid, Container, Typography, Alert, AlertTitle, Popover, Dialog } from '@mui/material';
import Config from '../Config';
import SuccessDialog from '../Components/Dialog';

const AddCropPage = () => {

  const [cropName, setCropName] = useState('');
  const [category, setCategory] = useState('');
  const [description, setDescription] = useState('');
  const [variety, setVariety] = useState('');
  const [marketprice,setMarketPrice] = useState();
  const [timespan,setTimeSpan] = useState();
  const [error,setError] = useState(false);
  const [sucess,setSuccess] = useState(false);
  const [season,setSeason] = useState('');


  const handleSubmit = async (e) => {
    e.preventDefault();
    if(cropName=='' || marketprice=="" || category=='' || description=='' ||  variety=='' || timespan=='' || season==""){
        setError(true)
        setTimeout(()=>{
            setError(false)
        },2500)
        return 
    }

    try {
      const response = await fetch(`${Config.SERVER}/picks/add_crop`, {
        method: 'POST',
        headers:{"Content-type": "application/json"},
        body: JSON.stringify({
            cropName,category,description,variety,marketprice,timespan,season,token:localStorage.getItem('token')
        }),
      });

      if(response.status==200){
        
       if((await response.json()).status){
        setSuccess(true)
       }
      }
      // Handle the response
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
   
    <Container maxWidth="600px"  sx={{marginTop:"40px"}}>
        <SuccessDialog open={sucess} text="Crop added successfully"  onClose={()=>{
                setSuccess(false)
                setCategory('')
                setCropName('')
                setDescription('')
                setTimeSpan('')
                setMarketPrice('')
                setVariety('')
                setSeason('')
        }} />
        <Typography fontSize={30} sx={{margin:"20px"}}>
            Add a new Crop
        </Typography>
       
    <form onSubmit={handleSubmit}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <TextField
            label="Crop Name"
            value={cropName}
            onChange={(e) => setCropName(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Category"
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            fullWidth
            multiline
            rows={4}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Variety"
            value={variety}
            onChange={(e) => setVariety(e.target.value)}
            fullWidth
          />
        </Grid>

        <Grid item xs={12}>
          <TextField
            label="Market Price"
            value={marketprice}
            type='number'
            onChange={(e)=> setMarketPrice(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Time span( in months )"
            value={timespan}
            type='number'
            onChange={(e)=> setTimeSpan(e.target.value)}
            fullWidth
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            label="Season"
            value={season}
       
            onChange={(e)=> setSeason(e.target.value)}
            fullWidth
          />
        </Grid>
        
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
            Add Crop
          </Button>
        </Grid>
      </Grid>
    </form>
    </Container>
  );
};

export default AddCropPage;
