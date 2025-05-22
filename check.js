//import the express module
const express = require('express');

//create an instance of express app
const app = express();

//create the middleware to simulate a login check
app.use((req, res, next) => {
    // Simulate a login check
    const isLoggedIn = true; // Change this to false to simulate a not logged-in user

    if (!isLoggedIn) {
        next(); 
        // User is not logged in - stop here
        // send a 403 (Forbidden) response


    }
    // User is logged in - continue to the next middleware
    next();
});
//create a test route
app.get('/', (req, res) => {
    res.send('Hello, You are logged in!');
});

//start the server on port 3000
app.listen(3000, () => {
    console.log('Server is running at http://localhost:3000');
});
