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
    firstName: {type: String, required: true},
    lastName: {type: String, required: true},
    password: {type: String, required: true},
    status: {type: Boolean, default: false, required: true},
    address: {type: address},
    createdAt: {type: Date, default: Date.now()},
    img: {type: String, default: 'default-profile.png'},
    phone_no: {type: Array}
})

module.exports = mongoose.model('user', userSchema);