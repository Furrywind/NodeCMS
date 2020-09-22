require('dotenv').config();

const express = require('express');
const logger = require('morgan');
const path = require('path');
const cors = require('cors');
const history = require('connect-history-api-fallback');

const indexRouter = require('./routes/index');
const adminRouter = require('./routes/admin');

const app = express();

app.use(logger('dev'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use('/api', indexRouter);
app.use('/api/admin', adminRouter);

app.use(history());
app.use(express.static(path.join(__dirname, 'public')));

module.exports = app;
