const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;

// Serve all static files from the current directory
app.use(express.static(__dirname));

// Default route to serve the landing page
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Start the server on 0.0.0.0 to allow external access in Replit
app.listen(port, '0.0.0.0', () => {
  console.log(`SubSmart MVP server running at http://0.0.0.0:${port}`);
});