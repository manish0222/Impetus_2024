// const express = require('express');
// const cors = require('cors');
// const body_parser=require('body-parser');
// const userRouter=require('./routes/user.route');
// const app = express(cors());
// app.use(body_parser.json());
// app.use('/',userRouter);
// module.exports = app;
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const userRouter = require('./routes/user.route');

const app = express(); // Create an Express application instance

// Enable CORS for all routes
app.use(cors());

// Parse JSON bodies for incoming requests
app.use(bodyParser.json());

// Mount userRouter for routes starting from '/'
app.use('/', userRouter);

module.exports = app; // Export the Express application instance
