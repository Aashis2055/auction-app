const vehicleModel = require('../models/Vehicle');
const changePrice = async ({user, price}) =>  {
    let vehicle = await vehicleModel.findOne({_id: user.v_id});
    console.log(vehicle);
    // if vehicle exist
    if(vehicle){
        // if no previous bid exists
        if(vehicle.bid){
            console.log(price, vehicle.bid.price);
            // check if the new price is greater than the current bid
            if(price > vehicle.bid.price){
                vehicle.bid = {
                    price,
                    u_id: user.decode._id
                }
                try{
                    const result = await vehicle.save();
                    return 'changed';
                }catch(error){
                    return 'Some thing went wrong'
                }
            }else{
                return 'Bid Higer';
            }
        }else{
            console.log('first bid');
            // check if the price is greater than the initial price
            if(price > vehicle.initial_price){
                console.log('price is higher')
                vehicle.bid = {
                    price, 
                    u_id: user.decode._id
                }
                
            }
            // update price and 
            try{
                const result = await vehicle.save();
                return 'changed';
            }catch(error){
                console.log(error);
                return 'Some thing went wrong';
            }
        }
    }else{
        return 'Bid higher'
    }
}

module.exports = {
    changePrice
}