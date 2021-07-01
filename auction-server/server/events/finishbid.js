const schedule = require('node-schedule');
const date = new Date(2021, 05, 18, 5, 30, 0);

const job = schedule.scheduleJob(date, ()=>{
    console.log('scheduled console');
})