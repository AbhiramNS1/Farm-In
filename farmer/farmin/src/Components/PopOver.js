import React, { useState } from 'react';
import { Button, Popover, Typography } from '@mui/material';

const MyPopoverDialog = () => {
  const [anchorEl, setAnchorEl] = useState(null);

  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  const open = Boolean(anchorEl);
  const popoverId = open ? 'popover-dialog' : undefined;

  return (
    <div>
      <Button onClick={handleClick}>Open Popover</Button>
      <Popover
        id={popoverId}
        open={open}
        anchorEl={anchorEl}
        onClose={handleClose}
        anchorOrigin={{
          vertical: 'bottom',
          horizontal: 'center',
        }}
        transformOrigin={{
          vertical: 'top',
          horizontal: 'center',
        }}
      >
        <Typography variant="h6">Popover Dialog Content</Typography>
        <Typography>This is a popover dialog example.</Typography>
        <Button onClick={handleClose}>Close</Button>
      </Popover>
    </div>
  );
};

export default MyPopoverDialog;
