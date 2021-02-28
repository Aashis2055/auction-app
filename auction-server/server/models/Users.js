const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const userSchema = new Schema({
    email: {type: String,required: true},
    firstName: {type: String, required: true},
    lastName: {type: String, required: true},
    password: {type: String, required: true},
    status: {type: Boolean, default: false, required: true}
})

module.exports = mongoose.model('user', userSchema);