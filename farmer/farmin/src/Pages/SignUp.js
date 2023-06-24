import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import  { useState } from 'react';
import {  Container } from '@mui/material';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Config from '../Config'
import { useNavigate } from 'react-router-dom';

const defaultTheme = createTheme();

export default function SignUp() {

  const navigate = useNavigate()

  const [selectedFile, setSelectedFile] = useState(null);

  const handleFileChange = (event) => {
    setSelectedFile(event.target.files[0]);
    console.log(event.target.files[0])
  };

 


  const handleSubmit = async (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const res= await fetch(`${Config.SERVER}/farmer/signup`, {
      // headers:{'Content-Type': `multipart/form-data`},
      method:'POST',
      body :data
    })
    console.log()
    const result = await res.json();
    if(result.status){
        navigate("/")
    }

  };

  return (
    <ThemeProvider theme={defaultTheme}>
      <Container component="main" maxWidth="xs">
        <CssBaseline />
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
            Farmer - Sign Up
          </Typography>
          <Box  component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
          <TextField
              margin="normal"
              required
              fullWidth
              id="name"
              label="User name"
              name="name"
              autoComplete="name"
              autoFocus
            />
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
            <TextField
              margin="normal"
              required
              fullWidth
              id="address"
              label="Address"
              name="address"
              autoComplete="address"
              autoFocus
            />
             <TextField
              margin="normal"
              required
              fullWidth
              id="adhar"
              label="Aadhar"
              name="adhar"
              type='number'
              autoComplete="adhar"
              autoFocus
            />
           
            <Button
              type="submit"
              fullWidth
              variant="contained"
              sx={{ mt: 3, mb: 2 }}
            >
              Sign Up
            </Button>
            <Grid container>
              <Grid item>
                <Link href="/" variant="body2">
                  {"Already have an account? Sign in"}
                </Link>
              </Grid>
            </Grid>
          </Box>
        </Box>
       
      </Container>
    </ThemeProvider>
  );
}




