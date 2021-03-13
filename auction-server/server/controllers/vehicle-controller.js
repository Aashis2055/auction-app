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
        console.log(vehicles);
    })
}
const getVehicle = (req, res)=>{

}

module.exports = {
    postVehicle,
    getVehicle,
    getVehicles
}