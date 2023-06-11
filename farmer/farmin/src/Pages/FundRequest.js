import * as React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Toolbar from '@mui/material/Toolbar';
import Paper from '@mui/material/Paper';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Button from '@mui/material/Button';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import SearchableDropdown from '../Components/SearchableDropDown';
import DateSelector from '../Components/DatePicker';
import { useNavigate } from 'react-router-dom';
import SuccessDialog from '../Components/Dialog';
import Config from '../Config';







export default function CheckOut() {

  const navigate = useNavigate()

  const [statingDate,setStartingDate]=React.useState()
  const [endingDate,setEndingDate]=React.useState()
  const [totalAmount,setTotalAmount]=React.useState()
  const [availAmount,setavailamount]=React.useState()
  const [cropName,setcropname]=React.useState()
  const [farmland,setFarmland]=React.useState()
  const [area,setArea]=React.useState()

  const [success,setSuccess]= React.useState(false)

  const [cropOptions,setCropOptions]=React.useState([])
  const [farmlandOptions,setfarmlandOptions]=React.useState([])


  React.useEffect(()=>{
    const data={
      method: 'POST',
      headers:{'Content-Type': 'application/json'},
      body: JSON.stringify({
        token:localStorage.getItem('token')
      })}
      fetch(`${Config.SERVER}/farmer/getcrops`,data).then(res=>res.json()).then(res=>{
        setCropOptions(res)
      })
      fetch(`${Config.SERVER}/farmer/getfarmland`,data).then(res=>res.json()).then(res=>{
        setfarmlandOptions(res)
      })
  },[])


  const mysqlDate=(date) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }



  const handleSubmit = () => {
    // Create an object with the data from state variables


    const requestData = {
     statingDate:mysqlDate(statingDate), endingDate:mysqlDate(endingDate), totalAmount, availAmount,cropName, farmland, area,
     token:localStorage.getItem('token')
    };
  
    // Send the data as JSON to the "/addnew" endpoint
    fetch(`${Config.SERVER}/farmer/new_funding`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(requestData)
    })
      .then(response => response.json())
      .then(data => {
        if(data.status){
          setSuccess(true)
        }
      })
      .catch(error => {
        // Handle any errors that occur during the request
        console.error(error);
      });
  };
  
  const defaultTheme = createTheme();

  
  return (
    <ThemeProvider theme={defaultTheme}>
    <CssBaseline />
    <AppBar
      position="absolute"
      sx={{
        position: 'fixed',
        borderBottom: (t) => `1px solid ${t.palette.divider}`,
      }}
    >
      <Toolbar>
        <Typography variant="h6" color="inherit" noWrap>
          FarmIn
        </Typography>
      </Toolbar>
    </AppBar>
    <Container component="main" maxWidth="sm" sx={{ mb: 4 ,marginTop:"80px"}}>
    <SuccessDialog open={success} text="Request send successfully" onClose={()=>{
      navigate("/")

    }}/>
      <Paper variant="outlined" sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
        <Typography component="h1" variant="h4" align="center">
         New Funding Request
        </Typography>
      
    <React.Fragment>
      <Typography variant="h6" gutterBottom>
        Funding details
      </Typography>
      <Grid container spacing={3}>
        <Grid item xs={12} >
          <TextField
            required
            id="amount"
            name="amount"
            label="Total amount"
            fullWidth
            autoComplete="amount"
            type='number'
            variant="standard"
            value={totalAmount}
            onChange={(e)=>setTotalAmount(e.target.value)}
          />
        </Grid>
        <Grid item xs={12} >
          <TextField
            required
            id="availamount"
            name="availamount"
            label="Avilable amount"
            fullWidth
            autoComplete="amount"
            type='number'
            variant="standard"
            value={availAmount}
            onChange={(e)=>setavailamount(e.target.value)}
          />
        </Grid>
       
        <Grid item xs={12}>
         <SearchableDropdown label="Select crop"   options ={cropOptions}  selectedOption={cropName}  handleOptionChange={(e,val)=>setcropname(val)}  />
        </Grid>
        <Grid item xs={12}  sm={6} >
        <DateSelector onChanged={(date)=>{setStartingDate(date);}}  label="Stating date" />
       </Grid>
        <Grid item xs={12}  sm={6}>

        <DateSelector  onChanged={(date)=>setEndingDate(date)} label="Ending date" />

        </Grid>
        <Grid item xs={12}>
         <SearchableDropdown label="Select Farmland" selectedOption={farmland}  handleOptionChange={(e,val)=>setFarmland(val)}   options ={farmlandOptions}/>
        </Grid>
        <Grid item xs={12}>
          <TextField
            id="area"
            name="area"
            label="Area(in acers)"
            fullWidth
            variant="standard"
            type='number'
            value={area}
            onChange={(e)=>setArea(e.target.value)}
          />
        </Grid>
        <Grid item xs={12} sx={{display:'flex',justifyContent:'end'}}>
          <Button onClick={handleSubmit} variant='contained' >Send Request</Button>
        </Grid>
       
  
      </Grid>
    </React.Fragment>
    </Paper>
     
     </Container>
   </ThemeProvider>
  );
}


