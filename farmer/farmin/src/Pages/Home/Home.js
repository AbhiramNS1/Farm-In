


import * as React from 'react';
import { styled, createTheme, ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import MuiDrawer from '@mui/material/Drawer';
import Box from '@mui/material/Box';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import Badge from '@mui/material/Badge';
import Container from '@mui/material/Container';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Link from '@mui/material/Link';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import NotificationsIcon from '@mui/icons-material/Notifications';
import {Check,Cancel} from '@mui/icons-material';
import { Button, colors } from '@mui/material';
import AddCircleOutlineIcon from '@mui/icons-material/AddCircleOutline';

import { useTheme } from '@mui/material/styles';
import { LineChart, Line, XAxis, YAxis, Label, ResponsiveContainer } from 'recharts';


import PropTypes from 'prop-types';









import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import ListSubheader from '@mui/material/ListSubheader';
import DashboardIcon from '@mui/icons-material/Dashboard';
import { useNavigate } from 'react-router-dom';
import AddFarmLand from '../AddNewFarmLand';
import Config from '../../Config';
import LandscapeIcon from '@mui/icons-material/Landscape'

import AccessTimeIcon from '@mui/icons-material/AccessTime';

import SettingsIcon from '@mui/icons-material/Settings';


import RequestQuoteIcon from '@mui/icons-material/RequestQuote';

import DeleteIcon from '@mui/icons-material/Delete';




  
  export const secondaryListItems = (
    <React.Fragment>
      <ListSubheader component="div" inset>
        FarmIn
      </ListSubheader>
     
    </React.Fragment>
  );















const drawerWidth = 240;

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})(({ theme, open }) => ({
  zIndex: theme.zIndex.drawer + 1,
  transition: theme.transitions.create(['width', 'margin'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const Drawer = styled(MuiDrawer, { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme, open }) => ({
    '& .MuiDrawer-paper': {
      position: 'relative',
      whiteSpace: 'nowrap',
      width: drawerWidth,
      transition: theme.transitions.create('width', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.enteringScreen,
      }),
      boxSizing: 'border-box',
      ...(!open && {
        overflowX: 'hidden',
        transition: theme.transitions.create('width', {
          easing: theme.transitions.easing.sharp,
          duration: theme.transitions.duration.leavingScreen,
        }),
        width: theme.spacing(7),
        [theme.breakpoints.up('sm')]: {
          width: theme.spacing(9),
        },
      }),
    },
  }),
);




// TODO remove, this demo shouldn't need to reset the theme.
const defaultTheme = createTheme();

export default function Dashboard() {
  const [open, setOpen] = React.useState(false);
  const [pos,setPos]=React.useState(0);
  const toggleDrawer = () => {
    setOpen(!open);
  };

  const navigate =useNavigate()


 const mainListItems = (
    <React.Fragment>
      <ListItemButton onClick={()=>setPos(0)}>
        <ListItemIcon  >
          <DashboardIcon />
        </ListItemIcon>
        <ListItemText primary="Dashboard" />
      </ListItemButton>
      <ListItemButton  onClick={()=>setPos(1)}>
        <ListItemIcon>
        <RequestQuoteIcon color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Pending Requests" />
      </ListItemButton>
      <ListItemButton onClick={()=>setPos(2)}>
        <ListItemIcon>
        <LandscapeIcon color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Farmlands" />
      </ListItemButton>
      <ListItemButton onClick={()=>setPos(3)}>
        <ListItemIcon>
         <SettingsIcon color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Settings" />
      </ListItemButton>
    </React.Fragment>
  );

  return (
    <ThemeProvider theme={defaultTheme}>
      <Box sx={{ display: 'flex' }}>
        <CssBaseline />
        <AppBar position="absolute" open={open}>
          <Toolbar
            sx={{
              pr: '24px', // keep right padding when drawer closed
            }}
          >
            <IconButton
              edge="start"
              color="inherit"
              aria-label="open drawer"
              onClick={toggleDrawer}
              sx={{
                marginRight: '36px',
                ...(open && { display: 'none' }),
              }}
            >
              <MenuIcon />
            </IconButton>
            <Typography
              component="h1"
              variant="h6"
              color="inherit"
              noWrap
              sx={{ flexGrow: 1 }}
            >
              FarmIn - For Farmers
            </Typography>
           
          </Toolbar>
        </AppBar>
        <Drawer variant="permanent" open={open}>
          <Toolbar
            sx={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'flex-end',
              px: [1],
            }}
          >
            <IconButton onClick={toggleDrawer}>
              <ChevronLeftIcon />
            </IconButton>
          </Toolbar>
          <Divider />
          <List component="nav">
            {mainListItems}
            <Divider sx={{ my: 1 }} />
            {secondaryListItems}
          </List>
        </Drawer>
        <Box
          component="main"
          sx={{
            backgroundColor: (theme) =>
              theme.palette.mode === 'light'
                ? theme.palette.grey[100]
                : theme.palette.grey[900],
            flexGrow: 1,
            height: '100vh',
            overflow: 'auto',
          }}
        >
        <Toolbar />
          {pos==0?<HomeScreen/>:pos==1?<FundingRequests/>:pos==2?<MyFarmLands/>:(
            <>
            <Container sx={{margin:'50vh'}}>
            <Button variant='contained' onClick={()=>{
              localStorage.clear()
              navigate("/")
            }}>Log out</Button>
            </Container>
            </>
          )}
        </Box>
      </Box>
    </ThemeProvider>
  );
}


function HomeScreen(){

  const navigate= useNavigate()
  const [requests,setRequests] = React.useState([])
  const [farmlands,setFarmLands] = React.useState([])

  React.useEffect(() =>{
    const payload ={
      method:'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({token:localStorage.getItem('token')})
    }
      fetch(`${Config.SERVER}/farmer/getRequests`,payload).then((response) =>response.json()).then((response) =>{
        setRequests(response)
      })
      fetch(`${Config.SERVER}/farmer/getfarmland`,payload).then((response) =>response.json()).then((response) =>{
        setFarmLands(response)
      })
  },[])


  return  <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
  <Grid container spacing={3}>
    <Grid item xs={12} md={8} lg={9}>
      <Paper
        sx={{
          p: 2,
          display: 'flex',
          flexDirection: 'column',
          
        }}
      >
        <Typography fontSize={18} fontWeight='bold' sx={{padding:"10px"}}>
        Funding Requests
        </Typography>
       
        {(requests?.length ==0)?"No Requests Yet":"" }
      {requests.map(e=>{
        return <div key={e.id} style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div>
      <b> Total amount</b> : <i> {e.total_amount}</i>
       <br/>
       <b>  Avilable amount </b>: <i>{e.avilable_amount}</i>
       <br/>
       <b> Farmland Address </b>:<i> {e.address}</i>
       </div>
       <div style={{display:'flex' ,justifyContent:'center'}}>
        {(e.state=='pending')?<>
        <b>Status : pending</b>
            <AccessTimeIcon color="warning" />
        </>:
        (e.state=='rejected')?
        <>
        <b>Status : rejected</b>
            <Cancel color="error" />
        </>:
        <>
        <b>Status :Approved</b>
            <Check color="success" />
        </>}
          
       </div>
      
          </div>
      })}
      </Paper>
    </Grid>

    <Grid item xs={12} md={4} lg={3}>
      <Paper
        sx={{
          p: 2,
          display: 'flex',
          flexDirection: 'column',
          height: 240,
          display: 'flex',
          justifyContent:'flex-start',
        }}
      >
       <Button
          sx={{
              textOverflow: 'ellipsis',
              marginBottom:'10px',
              display: 'flex',
              justifyContent:'flex-start',
          }}
          onClick={()=>navigate("/fund_request")}
          variant="contained"
          startIcon={<AddCircleOutlineIcon />}
        >
          New Fund Request
        </Button>
        <Button
        onClick={()=>navigate("/add_farmland")}
          sx={{
            textOverflow: 'ellipsis',
            marginBottom:'10px',
            display: 'flex',
            justifyContent:'flex-start',
          }}
          variant="contained"
          startIcon={<AddCircleOutlineIcon />}
        >
          Add new Farmland
        </Button>
        <Button
          sx={{
            display: 'flex',
            justifyContent:'flex-start',
            textOverflow: 'ellipsis',
            marginBottom:'10px',
          }}
          onClick={()=>navigate("/add_crop")}
          variant="contained"
          startIcon={<AddCircleOutlineIcon />}>
          Add a crop
        </Button>
        <img
          draggable={false}
            src="/icon.png"
            alt="FarmIn logo"
            style={{
              alignSelf:'center',
              height:"100px",
              width:"100px",
            }}
          />
      </Paper>
    </Grid>
    
    <Grid item xs={12}>
      <Paper sx={{ p: 2, display: 'flex', flexDirection: 'column' }}>
      <Typography variant='h5'>
        My FarmLands
        </Typography>
        {(requests.length ==0)?"No Requests Yet":"" }
      {farmlands.map(e=>{
        return <div key={e.id}  style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',
        borderRadius:'5px',
        padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div>
      <b>Address</b> : <i> {e.address}</i>
       <br/>
       <b>Total Area</b>: <i>{e.area}</i>
       <br/>
       <b>location</b>:<i> {`lat:${e.latitude} long:${e.longitude}`}</i>
       </div>
      
          </div>
      })}
      </Paper>
    </Grid>
  </Grid>
</Container>
}




function FundingRequests(){

  const [requests,setRequests] = React.useState([])
 

  const updateRequests =() =>{
    const payload ={
      method:'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({token:localStorage.getItem('token')})
    }
      fetch(`${Config.SERVER}/farmer/getRequests`,payload).then((response) =>response.json()).then((response) =>{
        setRequests(response)
      })
  }


  React.useEffect(updateRequests,[])


  return  <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
  <Grid container spacing={3}>
    <Grid item xs={12} md={8} lg={9}>
      <Paper
        sx={{
          p: 2,
          display: 'flex',
          flexDirection: 'column',
        }}
      >
        <Typography fontSize={20} fontWeight='bold' sx={{padding:"20px"}}>
        Your Funding Requests
        </Typography>
       
        {(requests.length ==0)?"No Requests Yet":"" }
      {requests.map(e=>{
        if(e.state=="approved") return 
        return <div key={e.id} style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div>
      <b> Total amount</b> : <i> {e.total_amount}</i>
       <br/>
       <b>  Avilable amount </b>: <i>{e.avilable_amount}</i>
       <br/>
       <b> Farmland Address </b>:<i> {e.address}</i>
       </div>
       <div style={{display:'flex' ,justifyContent:'center'}}>
         <div> <b>{e.state}  </b>
           
            </div>
            <Button onClick={()=>{
              fetch(`${Config.SERVER}/farmer/deletePendingRequest`,{
                method:'POST',
                headers: {'Content-Type':'application/json'},
                body: JSON.stringify({token:localStorage.getItem('token'),id:e.id})
              }).then(resp=>resp.json()).then(res=>{
                updateRequests()
              })
            }} variant='contained' sx={{marginLeft:'10px',backgroundColor:'red'}} >
            <DeleteIcon/>
            </Button>
       </div>
      
          </div>
      })}
      </Paper>
    </Grid>
  </Grid>
</Container>
}

function MyFarmLands(){
  const [farmlands,setFarmLands] = React.useState([])

  React.useEffect(() =>{
    const payload ={
      method:'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({token:localStorage.getItem('token')})
    }
      fetch(`${Config.SERVER}/farmer/getfarmland`,payload).then((response) =>response.json()).then((response) =>{
        setFarmLands(response)
      })
  },[])


  return  <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
  <Grid container spacing={3}>
    <Grid item xs={12} md={8} lg={9}>
      <Paper
        sx={{
          p: 2,
          display: 'flex',
          flexDirection: 'column',
          
        }}
      >
        <Typography fontSize={18} fontWeight='bold' sx={{padding:"10px"}}>
        My Farmlands
        </Typography>
       
    
      </Paper>
    </Grid>
    <Grid item xs={12}>
      <Paper sx={{ p: 2, display: 'flex', flexDirection: 'column' }}>
      <Typography variant='h5'>
        My FarmLands
        </Typography>
      {farmlands.map(e=>{
        return <div key={e.id}  style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',
        borderRadius:'5px',
        padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div>
      <b>Address</b> : <i> {e.label}</i>
       <br/>
       <b>Total Area</b>: <i>{e.area}</i>
       <br/>
       <b>location</b>:<i> {`lat:${e.latitude} long:${e.longitude}`}</i>
       </div>
      
          </div>
      })}
      </Paper>
    </Grid>
  </Grid>
</Container>
}
