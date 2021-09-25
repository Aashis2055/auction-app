const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const id = Schema.Types.ObjectId;
const vehicleTypes = ["Bike", "Scooter", "Car", "Others"];
const deliveryType = ["Will Deliver", "You come"];
const bidSchema = require('./Bid');
let date = new Date();
const vehicleSchema = new Schema({
    img: {type: String, required: true},
    type: {type:String, required: true, default: null, enum: vehicleTypes},
    color: {type: String, required: true},
    brand: {type: String, required: true},
    model: {type: String, required: true},
    year: {type: Number, required: true},
    km_driven: {type: Number, required: true},
    description: {type: String, required: true, maxLength: 200},
    initial_price: {type: Number, required: true},
    added_date: {type: Date, required: true, default: Date.now()},
    auction_date: {type: Date, required: true, default: Date.now()},
    end_date: {type: Date, required: true, default: date.setDate(date.getDate() + 7)},
    delivery_type: {type: String, required: true, default: deliveryType[0], enum: deliveryType },
    u_id: {type: id, required:true, ref: 'User'},
    bid: {type:bidSchema, default: null}
});

module.exports = mongoose.model('Vehicle', vehicleSchema);