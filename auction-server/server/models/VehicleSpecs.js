const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const vehicleSpecs = new Schema({
    brand: {type: String, required: true},
    model: {type: String, required: true},
    price: {type: Number, required: true},
    mileage: {type: Number, default: null},
    engine_displacement: {type: Number, default: null},
    type: {type:String,default: "Others"}
});

module.exports = mongoose.model('VehicleSpecs', vehicleSpecs);