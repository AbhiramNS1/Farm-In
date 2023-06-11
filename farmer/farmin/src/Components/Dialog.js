import React from 'react';
import { Dialog, DialogTitle, DialogContent, DialogContentText,Button, Container } from '@mui/material';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';

const SuccessDialog = ({ open, onClose ,text}) => {
  return (
    <Dialog open={open} onClose={onClose}>
      <DialogTitle sx={{display:'flex',justifyContent:'center'}}>
        <CheckCircleIcon sx={{ fontSize: 70, color: 'green' }} />
      </DialogTitle>
      <DialogContent>
        <DialogContentText>
          {text}
        </DialogContentText>
        <Container sx={{display:'flex',justifyContent:'center',marginTop:"20px",padding:'0px'}}>
        <Button onClick={onClose} color="success" variant="outlined" >
        ok
      </Button>
        </Container>
      </DialogContent>
    </Dialog>
  );
};

export default SuccessDialog;
