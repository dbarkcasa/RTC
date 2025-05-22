const express = require('express');
const app = express();

app.use((req, res, next) => {
    //get user agent from request headers
    const userAgent = req.get('user-agent');

    //if the user agent contains 'curl', block the request
    if (userAgent && userAgent.includes('curl')) {
        res.status(403).send('Access denied - CLI tools are not allowed');
    }

    //if request is from a browser, allow it
    next();

});

//a test route that sends a simple response

app.get('/', (req, res) => {
    res.send('Welcome to the secure server for CYA250!');
});

//start the server on port 3000
app.listen(3000, () => {
    console.log('Server is running at http://localhost:3000');
});
