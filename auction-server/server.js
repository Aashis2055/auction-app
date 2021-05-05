// node modules 
const path = require('path');
const express = require('express');
const bodyParser =  require('body-parser');
const mongoose = require('mongoose');
const winston = require('winston');
const fileUpload = require('express-fileupload');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config({path: './server/config/.env'});
const cors = require('cors');
const exphbs = require('express-handlebars');
// const { transport } = require('winston');
//
const adminRoutes = require('./server/routes/admin-routes');
const userRoutes = require('./server/routes/user-routes');
const vehicleRoutes = require('./server/routes/vehicle-routes');
const adminVehicleRoutes = require('./server/routes/admin-vehicle');
// 
const app = express();
const PORT = process.env.PORT || 5000;
const databaseURL = process.env.DB_URL;
const limit = 50 * 1024 * 1024; // image size limit
const rateLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per mindowMs
});
// var hbs = exphbs.create({});
global.appRoot = __dirname;

// app set up
    // TODO remove in production

    const morgan = require('morgan');
    app.use(morgan("dev"));

app.use(fileUpload({
    
}))
app.use(express.static('public'));
app.use(cors());
// app.use(fileUpload({
//     limits: { fileSize: limit}
// }));
// app.get('/vehicle/:id', getPost );
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(rateLimiter);
app.use(helmet());
app.set('views', path.join(__dirname, 'view') );
app.engine('.hbs', exphbs({defaultLayout: 'main', extname: '.hbs'}));
app.set('view wngine', 'handlebars');
app.use('/admin-api',adminRoutes);
app.use('/admin-api', adminVehicleRoutes);
app.use('/user-api', userRoutes);
app.use('/user-api', vehicleRoutes);
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
    useNewUrlParser: true,
    useFindAndModify: false
}).then(()=>{
    console.log('Database Connected');
}).catch(()=>{
    console.log("DataBase Connection Error");
    logger.error('Database connection error');
})

const http = require('http').Server(app);
const io = require('socket.io')(http);
io.on('connection', (socket)=>{
    console.log('A user connected');
    socket.on('disconnect', ()=>{
        console.log('a user disconnected')
    })
});

// server start
http.listen(PORT, ()=>{
    console.log("Port started at: "+PORT);
});
