const scheduler = require('node-schedule');
const notificationModel = require('../models/Notification');
const vehicleModel = require('../models/Vehicle');
let jobs = [];
function scheduleEnd(date, v_id){
    const job = scheduler.scheduleJob(data, async function(){
        try{
            const vehicle = await vehicleModel.findOne({_id: v_id}).lean();
            if(vehicle == null){
                return console.log('no post');
            }else if(vehicle.bid == null){
                const {u_id} = vehicle;
                let newNotification = new notificationModel({type: 'Fail', message:'Sorry no one bidded on your vehicle', u_id, v_id});
                newNotification.save();
                return;
            }else{
                const {u_id:seller_id} = vehicle;
                const{u_id:buyer_id} = vehicle.bid;
                let buyerNotification = new notificationModel({type: 'Bought', message: `You have bought ${vehicle.type} for ${vehicle.bid.price}`, u_id: buyer_id, v_id });
                buyerNotification.save();
                let sellerNotification = new notificationModel({type: 'Sold', message: `You have sold ${vehicle.type} fro ${vehicle.bid.price}`, u_id: seller_id, v_id});
                sellerNotification.save();
            }
        }catch(e){
            console.log(error);
        }
    });
    jobs.push(job);
}

module.exports = {
    scheduleEnd
}