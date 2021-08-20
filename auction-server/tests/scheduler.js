const scheduler = require('node-schedule');
let currentDate = Date.now();
const date = new Date(currentDate + 160000);
console.log(date);
const job = scheduler.scheduleJob(date, function(){
    console.log('The job has been completed');
})