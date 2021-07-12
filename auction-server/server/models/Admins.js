const mongoose = require('mongoose');
const Schema = mongoose.Schema;
/**
 * @description mongoose shema object for admin
 */
const adminSchema = new Schema({
    email:{type: String, required: true},
    password: {type: String, required: true, minLength: 4},
    role: {type: String, enum: ["Moderator", "Admin"], required:true},
    dateCreated: {type: Date, default: Date.now}
});

module.exports = mongoose.model('Admin', adminSchema);