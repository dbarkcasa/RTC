// server.js

const express = require('express');
const app = express();

// Middleware to add timestamp to the request
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  next();
});

// Middleware to block command-line tools like curl
app.use((req, res, next) => {
  const userAgent = req.get('User-Agent') || '';
  if (userAgent.toLowerCase().includes('curl')) {
    return res.status(403).send('Access denied: command-line tools not allowed');
  }
  next();
});

// Test route
app.get('/', (req, res) => {
  res.send(`Welcome to the secure server. Request received at: ${req.requestTime}`);
});

// Start the server
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});