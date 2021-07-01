const mongoose = require('mongoose');
const databaseURL = process.env.DB_URL;

module.exports = function(){
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
};