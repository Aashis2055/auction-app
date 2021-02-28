//
const express = require('express');
const bodyParser =  require('body-parser');
const mongoose = require('mongoose');

// 
const app = express();
const PORT = process.env.PORT || 5000;
const databaseURL = "localhost";
const limit = 50 * 1024 * 1024; // image size limit

// app set up
app.use(express.static('public'));
app.use(bodyParser.urlencoded({extended: true}));


// database 
mongoose.connect(`mongodb://${databaseURL}/vehicle-auction`, {
    useUnifiedTopology: true,
    useNewUrlParser: true
}).then(()=>{
    console.log('Database Connected');
}).catch(()=>{
    console.log("DataBase Connection Error");
})

// server start
app.listen(PORT, console.log("Port started at: "+PORT));