const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const id = Schema.Types.ObjectId;
const vehicleTypes = ["Bike", "Scotter", "Car"];
const vehicleSchema = new Schema({
    img: {type: String, required: true},
    type: {type:String, required: true, default: null, enum: vehicleTypes},
    color: {type: String, required: true},
    model: {type: String, required: true},
    no_of_years: {type: Number, required: true},
    km_driven: {type: Number, required: true},
    description: {type: String, required: true, maxLength: 200},
    initial_price: {type: Number, required: true},
    added_date: {type: Date, required: true, default: Date.now()},
    auction_date: {type: Date, required: true, default: Date.now()},
    end_date: {type: Date, required: true},
    u_id: id
});

module.exports = mongoose.model('vehicle', vehicleSchema);