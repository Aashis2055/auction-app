const vehicleSpecs = require('../models/VehicleSpecs');

const getAvailableBrand = async (req, res)=>{
    const {type} = req.params;
    try{
        
        const brands = await vehicleSpecs.distinct("brand", {type});
        if(brands.length === 0){
            return res.status(404).json({msg: 'No Brand'});
        }
        return res.status(200).json({
            msg: 'OK',
            result: brands
        });
    }catch(e){
        console.log(e);
        return res.status(500).json({msg: 'Server Error'});
    }
}

const getAvailabeModels = async(req, res)=>{
    const {brand} = req.params;
    try{
        
        const models = await vehicleSpecs.distinct("model", {brand});
        if(models.length === 0){
            return res.status(404).json({msg: 'No Model'});
        }
        return res.status(200).json({
            msg: 'OK',
            result: models
        });
    }catch(e){
        console.log(e);
        return res.status(500).json({msg: 'Server Error'});
    }
}

module.exports = {
    getAvailabeModels,
    getAvailableBrand
}