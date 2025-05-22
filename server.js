// server.js
const http = require('http');

const server = http.createServer((req, res) => {    
   res.statusCode = 200; // Set the status code to 200 (OK)
   res.setHeader('Content-Type', 'text/plain');   
   res.end('Hello, Professor Anne!\n'); // Send the response
});

server.listen(3000, () => {
   console.log('Server is running at http://localhost:3000');
});
