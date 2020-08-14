const express = require('express');
const dotenv = require('dotenv');

//Load our environment variables, specifies where our environment variables are located
dotenv.config({path: './config/config.env' });

//Create an instance of express, stored as the application variable
const app = express();

//Specify the port, if our default isnt available we'll listen on 5000
const PORT = process.env.PORT || 5000;

app.listen(PORT, console.log(`Server is running in ${process.env.NODE_ENV} environment on port: ${PORT}`));