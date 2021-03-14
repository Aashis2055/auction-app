//
//
const vehicleModel = require('../models/Vehicle');
const schemaVehicle = require('../validator/vehicle');
const postVehicle = async (req, res)=>{
    let {u_id} = req.userData;
    try{
        let validationError = await schemaVehicle.validate(req.body, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({
                msg: 'Validation error',
                errors: validationErrorMsg
            })
        };
        // TODO save to database
    }catch(error){
        return res.status(500).json({msg: 'Server Error'})
    }
}
const getVehicles = (req, res)=>{
    // TODO get filter parameters
    
    vehicleModel.find().then((vehicles)=>{
        if(vehicles.length === 0){
            return res.status(204).json({ message: 'No content found'});
        }
        return res.status(200).json({
            message:'ok',
            posts: vehicles
        })
    }).catch((error)=>{
        console.log(error);
        return res.status(500).json({
            message: 'Server Error'
        })
    })
    ;
}
const getVehicle = (req, res)=>{
    res.status(200).json({ 
        message: 'OK',
    })
}

module.exports = {
    postVehicle,
    getVehicle,
    getVehicles
}