import React, { useState } from 'react';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';

import { LocalizationProvider,DatePicker } from '@mui/x-date-pickers'
import TextField from '@mui/material/TextField';

const DateSelector = ({selectedDate,label,onChanged}) => {
 

  return (
    <LocalizationProvider dateAdapter={AdapterDateFns}>
      <DatePicker
        label={label}
        value={selectedDate}
        onChange={onChanged}
        renderInput={(params) => <TextField {...params} />}
      />
    </LocalizationProvider>
  );
};

export default DateSelector;
