import express, { Application } from 'express';
const router = require('./classes/router')

require('dotenv').config();

const app: Application = express();
const port: number = 3000;

app.use('/', router);

// todo @ebr revuild with bun.js

app.listen(port, () => {
    console.log(`app listening on port http://localhost:${port}`);
});