// node modules 
const path = require('path');
const express = require('express');
const bodyParser =  require('body-parser');
const winston = require('winston');
const fileUpload = require('express-fileupload');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config({path: './config/.env'});
const cors = require('cors');
const jwt = require('jsonwebtoken');
const exphbs = require('express-handlebars');
// const { transport } = require('winston');
//routes
const adminRoutes = require('./server/routes/admin-routes');
const userRoutes = require('./server/routes/user-routes');
const vehicleRoutes = require('./server/routes/vehicle-routes');
const adminVehicleRoutes = require('./server/routes/admin-vehicle');
// controlls
const {getPost, getPosts} = require('./server/controllers/user-account');
const {bidPrice} = require('./server/controllers/bid-controller');
const setupDB = require('./config/database');
// variables setup
const app = express();
const PORT = process.env.PORT || 5000;
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

app.use(fileUpload({}))
setupDB(); 
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

app.use('/admin-api',adminRoutes);
app.use('/admin-api', adminVehicleRoutes);
app.use('/user-api', userRoutes);
app.use('/user-api', vehicleRoutes);
// handlebars
let hbs = exphbs.create({});
app.engine('handlebars', hbs.engine);
app.set('view engine', 'handlebars');
app.get('/vehicle/:id', getPost);
app.get('/vehicles', getPosts);
// logger setup
global.logger = winston.createLogger({
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



const http = require('http').Server(app);
const io = require('socket.io')(http);
io.on('connection', (socket)=>{
    console.log('A user connected');
    socket.on('bidPrice', ({token,price, v_id})=>{
        try {
            const USER_KEY = process.env.USER_KEY;
            let decode = jwt.verify(token, USER_KEY);
            const status = bidPrice(decode, price, v_id);
            if(status){
                socket.emit('changePrice', {price, id:5});
            }
            
        } catch (error) {
            console.log(error);
            res.status(401).json({
                msg: 'Unauthorized'
            })
        }
    });
    socket.on('disconnect', ()=>{
        console.log('a user disconnected')
    });
});

// server start
http.listen(PORT, ()=>{
    console.log("Port started at: "+PORT);
});
