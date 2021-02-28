const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const id = Schema.Types.ObjectId;
const vehicleTypes = ["Bike", "Scotter", "Car"];
const vehicleSchema = new Schema({
    img: {type: String, required: true},
    type: {type:String, required: true, default: null, enum: vehicleTypes},
    color: {type: String, required: true},
    model: {type: String, required: true},
    noOfYears: {type: TimeRanges, required: true},
    kmDriven: {type: Number, required: true},
    description: {type: String, required: true, maxLength: 200},
    initPrice: {type: Number, required: true},
    u_id: id
});

module.exports = mongoose.model('vehicle', vehicleSchema);