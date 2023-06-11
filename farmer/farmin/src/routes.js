import React from 'react';
import SignIn from './Pages/Login';
import SignUp from './Pages/SignUp';
import Home from './Pages/Home/Home';
import { Route, Routes} from 'react-router-dom';
import Checkout from './Pages/FundRequest';
import AddCropPage from './Pages/AddCrop';
import AddFarmLand from './Pages/AddNewFarmLand';


export const AppRoutes = () => {
    return (
      <div>
        <Routes>
          <Route path="/" element={(localStorage.getItem("isLogedIn")) ?<Home/>:<SignIn/>} />
          <Route  path="/signup" element={<SignUp/>} />
          {(localStorage.getItem("isLogedIn")?(
          <>
            <Route  path="/fund_request" element={<Checkout/>}/>
            <Route  path="/add_crop" element={<AddCropPage/>}/>
            <Route  path="/add_farmland" element={<AddFarmLand/>}/>
            
          </>
          ):"")}
        </Routes>
      </div>
    );
  };