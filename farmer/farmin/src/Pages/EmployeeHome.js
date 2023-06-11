


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
import { Button, Checkbox, TextField, colors } from '@mui/material';

import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import ListSubheader from '@mui/material/ListSubheader';

import { useNavigate } from 'react-router-dom';
import Config from '../Config';

import AccessTimeIcon from '@mui/icons-material/AccessTime';

import Logout from '@mui/icons-material/Logout';
import PendingActions from '@mui/icons-material/PendingActions';
import Approval from '@mui/icons-material/Approval';
import CancelRounded from '@mui/icons-material/CancelRounded';
import Check from '@mui/icons-material/Check';
import DeleteIcon from '@mui/icons-material/Delete';
import { Dialog, DialogTitle, DialogContent, DialogContentText } from '@mui/material';




  
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

export default function EmployeeHome() {
  const [open, setOpen] = React.useState(false);
  const [pos,setPos]=React.useState(0);
  const toggleDrawer = () => {
    setOpen(!open);
  };

  const navigate =useNavigate()


 const mainListItems = (
    <React.Fragment>
      <ListItemButton onClick={()=>{
        setPos(0)
      }}>
        <ListItemIcon>
         <PendingActions color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Settings" />
      </ListItemButton>
      <ListItemButton onClick={()=>{
        setPos(1)
      }}>
        <ListItemIcon>
         <Approval color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Settings" />
      </ListItemButton>
      <ListItemButton onClick={()=>{
        setPos(2)
      }}>
        <ListItemIcon>
         <CancelRounded color="inherit" />
        </ListItemIcon>
        <ListItemText primary="Settings" />
      </ListItemButton>
      <ListItemButton onClick={()=>{
        localStorage.clear()
        window.location.reload()
      }}>
        <ListItemIcon>
         <Logout color="inherit" />
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
              FarmIn - Admin
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
          {pos==0?<HomeScreen/>:pos==1?<ApprovedRequests/>:pos==2?<RejectedRequest/>:(
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

    const payload ={
        method:'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({token:localStorage.getItem('token')})
      }

  const [requests,setRequests] = React.useState([])
  const [req,setReq]=React.useState(null)
    const [qty,setqty]=React.useState(0)

  React.useEffect(() =>{
      fetch(`${Config.SERVER}/admin/getPendingRequests`,payload).then((response) =>response.json()).then((response) =>{
        setRequests(response)
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

<Dialog open={req!=null} >
      <DialogTitle sx={{display:'flex',justifyContent:'center'}}>
      </DialogTitle>
      <DialogContent>
        <Typography variant='h5' sx={{paddingBottom:'20px'}}>Funding Request Approval</Typography>
        <DialogContentText>
          <div style={{display:'flex',alignItems:'start',flexDirection:'column'}}>
          <div> <b> Farmer's Adhar :</b>  <i> {req?.adhar}</i></div>
            <div> <b> Total amount :</b>  <i> {req?.total_amount}</i></div>
            <div> <b> Total Area for cultivation :</b>  <i> {req?.area}</i></div>
            <div><b>  Avilable amount : </b> <i>{req?.avilable_amount}</i></div>
            <div> <b> Farmland Address : </b><i> {req?.address}</i></div>
            <TextField value={qty} onChange={(e)=>setqty(e.target.value)} label="Quantity" type='number' sx={{marginTop:"20px"}}/>
       </div>
        </DialogContentText>
        <Container sx={{display:'flex',justifyContent:'center',marginTop:"20px",padding:'0px'}}>
        <Button onClick={()=>{
             fetch(`${Config.SERVER}/admin/approve`, {
                method:'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({token:localStorage.getItem('token'),
                id:req?.id,
                qty,
                price:parseInt(req.total_amount/qty)
            })})
             .then((response) =>response.json())
             .then((response) =>{
                setReq(null)
                fetch(`${Config.SERVER}/admin/getPendingRequests`,payload).then((response) =>response.json()).then((response) =>{
                    setRequests(response)
                  })
              })
        }} color="success" variant="contained" >
        Approve
      </Button>
      <Container sx={{width:'10px'}}/>
      <Button onClick={()=>{
             fetch(`${Config.SERVER}/admin/reject`, {
                method:'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({token:localStorage.getItem('token'),
                id:req?.id
            })
              })
             .then((response) =>response.json())
             .then((response) =>{
                setReq(null)
                fetch(`${Config.SERVER}/admin/getPendingRequests`,payload).then((response) =>response.json()).then((response) =>{
                    setRequests(response)
                  })
              })
        }}  color="error"  variant="contained" >
        Reject
      </Button>
        </Container>
      </DialogContent>
    </Dialog>





        <Typography fontSize={18} fontWeight='bold' sx={{padding:"10px"}}>
            Pending Fund Requests
        </Typography>
       
        {(requests?.length ==0)?"No Requests Yet":"" }
      {requests.map(e=>{
        return <Button onClick={()=>setReq(e)} key={e.id} style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div style={{display:'flex',alignItems:'start',flexDirection:'column'}}>
     <div> <b> Total amount :</b>  <i> {e.total_amount}</i></div>
      
      <div><b>  Avilable amount : </b> <i>{e.avilable_amount}</i></div>

      <div> <b> Farmland Address : </b><i> {e.address}</i></div>
       </div>
     
      
          </Button>
      })}
      </Paper>
    </Grid>
    
  </Grid>
</Container>
}




function ApprovedRequests(){

    const [requests,setRequests]=React.useState([])

  const updateRequests =() =>{
    const payload ={
      method:'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({token:localStorage.getItem('token')})
    }
      fetch(`${Config.SERVER}/admin/getApprovedRequests`,payload).then((response) =>response.json()).then((response) =>{
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
        Approved Funding Requests
        </Typography>
       
        {(requests.length ==0)?"No Requests Approved Yet":"" }
      {requests.map(e=>{
        return <Button key={e.id} style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div style={{display:'flex',alignItems:'start',flexDirection:'column'}}>
     <div> <b> Total amount :</b>  <i> {e.total_amount}</i></div>
      
      <div><b>  Avilable amount : </b> <i>{e.avilable_amount}</i></div>

      <div> <b> Farmland Address : </b><i> {e.address}</i></div>
       </div>
     
      
          </Button>
      })}
      </Paper>
    </Grid>
  </Grid>
</Container>
}

function RejectedRequest(){

    const payload ={
        method:'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({token:localStorage.getItem('token')})
      }

  const [requests,setRequests] = React.useState([])
  

  React.useEffect(() =>{
      fetch(`${Config.SERVER}/admin/getRejectedRequests`,payload).then((response) =>response.json()).then((response) =>{
        setRequests(response)
      })
 
  },[])





  return  <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
  <Grid container spacing={3}>
  
    <Grid item xs={12}>
      <Paper sx={{ p: 2, display: 'flex', flexDirection: 'column' }}>
      <Typography variant='h5'>
       Rejected Requests 
        </Typography>
        {(requests.length ==0)?"No Requests Rejected Yet":"" }
      {requests.map(e=>{
        return <Button  key={e.id} style={{boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.3)',padding:'10px',display:'flex',justifyContent:'space-between',alignItems:'center',margin:'5px'}}>
          <div style={{display:'flex',alignItems:'start',flexDirection:'column'}}>
     <div> <b> Total amount :</b>  <i> {e.total_amount}</i></div>
      
      <div><b>  Avilable amount : </b> <i>{e.avilable_amount}</i></div>

      <div> <b> Farmland Address : </b><i> {e.address}</i></div>
       </div>
     
      
          </Button>
      })}
      </Paper>
    </Grid>
  </Grid>
</Container>
}
