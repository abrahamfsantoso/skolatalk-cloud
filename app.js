const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Health check endpoint for ECS
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

// Main endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from ECS Fargate! v3.0',
    container: process.env.HOSTNAME,
    region: process.env.AWS_REGION || 'not-set'
  });
});

// Load testing endpoint
app.get('/load', (req, res) => {
  const startTime = Date.now();
  let result = 0;
  
  // Simulate some CPU work
  for (let i = 0; i < 1000000; i++) {
    result += Math.sqrt(i);
  }
  
  res.json({
    message: 'Load test completed',
    duration: `${Date.now() - startTime}ms`,
    result: result
  });
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
