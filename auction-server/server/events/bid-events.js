const vehicleModel = require('../models/Vehicle');
const notificationModel = require('../models/Notification');
const changePrice = async ({user, price}) =>  {
    let vehicle = await vehicleModel.findOne({_id: user.v_id});
    console.log(vehicle);
    // if vehicle exist
    if(vehicle){
        // if no previous bid exists
        if(vehicle.bid){ oldPrice = vehicle.bid.price}
        else{ oldPrice = vehicle.initial_price}
            // check if the new price is greater than the current bid
            if(price > oldPrice){
                vehicle.bid = {
                    price,
                    u_id: user.decode._id
                }
                try{
                    const newNotification = new notificationModel({message: "Bid on product "+price, u_id: vehicle.u_id, type: 'Bid'});
                    const result = await vehicle.save();
                    const resultNotification = newNotification.save();
                    return 'changed';
                }catch(error){
                    return 'Some thing went wrong'
                }
            }else{
                return 'Bid Higer';
            }        
    }else{
        return 'Bid higher'
    }
}

module.exports = {
    changePrice
}