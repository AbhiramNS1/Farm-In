import React, { useState } from 'react';
import { Autocomplete, TextField } from '@mui/material';

const SearchableDropdown = ({label,options,handleOptionChange,selectedOption}) => {

  return (
    <Autocomplete
      options={options}
      getOptionLabel={(option) => option.label}
      value={selectedOption}
      onChange={handleOptionChange}
      renderInput={(params) => (
        <TextField
          {...params}
          label={label}
          variant="outlined"
        />
      )}
    />
  );
};

export default SearchableDropdown;
