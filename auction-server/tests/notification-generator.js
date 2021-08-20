const vehicleModel = require('../../models/Vehicle');
const notificationModel = require('../server/models/Notification');
try{
    const date = new Date();
    vehicleModel.find({end_date: {"$lt": date.toISOString()}}).lean().then((vehicle)=>{
        console.log(vehicles);
        vehicle.forEach(element => {
            SetNotification(element);
        });
    });

    
}catch(error){
    console.log(error);
}
function SetNotification(vehicle){
    try{
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
}