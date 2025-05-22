//import express library
const express = require('express');

//create an instance of express app
const app = express();

//middleware to attach a timestamp to the request object
app.use((req, res, next) => {
    req.requestTime = new Date().toISOString();
    next();
});

app.get('/', (req, res) => {
    res.send(`Hello, Professor Anne! The request was made at: ${req.requestTime}`);
});
//start the server on port 3000
app.listen(3000, () => {
    console.log('Server is running at http://localhost:3000');
});
