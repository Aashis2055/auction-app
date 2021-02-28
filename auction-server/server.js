// node modules 
const express = require('express');
const bodyParser =  require('body-parser');
const mongoose = require('mongoose');
const winston = require('winston');
const fileUpload = require('express-fileupload');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const { transport } = require('winston');

// 
const app = express();
const PORT = process.env.PORT || 5000;
const databaseURL = "localhost";
const limit = 50 * 1024 * 1024; // image size limit
const rateLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per mindowMs
});

// app set up
app.use(express.static('public'));
app.use(fileUpload({
    limits: { fileSize: limit}
}))
app.use(bodyParser.urlencoded({extended: true}));
app.use(rateLimiter);
app.use(helmet);

// logger setup
logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    defaultMeta: {},
    transports:[
        new winston.transports.File({ filename: 'log/error.log', level: 'error'}),
        new winston.transports.File({ filename: 'log/warn.log', level: 'warn'}),
        new winston.transports.File({filename: 'log/info.log', level: 'info'}),
        new winston.transports.File({ filename: 'log/combined.log'})
    ]
});

// database 
mongoose.connect(`mongodb://${databaseURL}/vehicle-auction`, {
    useUnifiedTopology: true,
    useNewUrlParser: true
}).then(()=>{
    console.log('Database Connected');
}).catch(()=>{
    console.log("DataBase Connection Error");
    logger.error('Database connection error');
})

// server start
app.listen(PORT, ()=>{
    logger.log('info', 'Server started');
    console.log("Port started at: "+PORT);
});