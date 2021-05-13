const mongoose = require('mongoose');
const {provinces} = require('./locations');
const Schema = mongoose.Schema;
const address = {
    province: {
        type: String, required: true, enum: provinces
    },
    disctrict: {
        type: String, required: true
    }
}
const userSchema = new Schema({
    email: {type: String,required: true},
    first_name: {type: String, required: true},
    last_name: {type: String, required: true},
    password: {type: String, required: true},
    status: {type: Boolean, default: false, required: true},
    address: {type: address},
    created_at: {type: Date, default: Date.now()},
    img: {type: String, default: 'default-profile.png'},
    phone_no: {type: Number}
})

module.exports = mongoose.model('User', userSchema);