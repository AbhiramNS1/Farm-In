import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Config from '../Config'
import SuccessDialog from '../Components/Dialog';

const defaultTheme = createTheme();

export default function SignIn({emp}) {

  const [errorMsg,setErrorMsg]=React.useState(null)


  const handleSubmit = async (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const res=await fetch(`${Config.SERVER}${emp?"/admin/login":"/farmer/login"}`, {
      method:'POST',
      headers: { 'Content-Type': 'application/json' },
      body :JSON.stringify({
        "username":data.get('email'),
        "password":data.get('password')
      })
    })
    const result= await res.json();
    console.log(result.token)
    if(result!=null ){
      if(result.token!=null){
        localStorage.setItem("token",result.token)
        localStorage.setItem("id",result.id)
        localStorage.setItem("isEmployee",true)
        localStorage.setItem("isLogedIn",true)
        emp?window.location.replace("/employee"):window.location.reload()}
      else if(result.error){
          setErrorMsg(result.error)
      }
    }
  };

  return (
    <ThemeProvider theme={defaultTheme}>
     
      <Container component="main" maxWidth="xs">
        <CssBaseline />
        <SuccessDialog open={errorMsg!=null} text={errorMsg}  onClose={()=>{
                setErrorMsg(null)
        }} />
        <Box
          sx={{
            marginTop: 8,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
          }}
        >
          <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
            <LockOutlinedIcon />
          </Avatar>
          <Typography component="h1" variant="h5">
            {(emp)?"Admin":"Farmer"} - Sign in
          </Typography>
          <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
            <TextField
              margin="normal"
              required
              fullWidth
              id="email"
              label="Email Address"
              name="email"
              autoComplete="email"
              autoFocus
            />
            <TextField
              margin="normal"
              required
              fullWidth
              name="password"
              label="Password"
              type="password"
              id="password"
              autoComplete="current-password"
            />
            <FormControlLabel
              control={<Checkbox value="remember" color="primary" />}
              label="Remember me"
            />
            <Button
              type="submit"
              fullWidth
              variant="contained"
              sx={{ mt: 3, mb: 2 }}
            >
              Sign In
            </Button>
            <Grid container>
              <Grid item>
                <Link href="/signup" variant="body2">
                  {(emp)?"":"Don't have an account? Sign Up"}
                </Link>
              </Grid>
            </Grid>
          </Box>
        </Box>
       
      </Container>
    </ThemeProvider>
  );
}