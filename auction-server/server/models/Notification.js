const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const id = mongoose.Types.ObjectId;

const notificationSchema = new Schema({
    u_id: {type: id, required: true},
    v_id: {type: id, require: true},
    added_at: {type: Date, default: Date.now(), required: true},
    message: {type: String, required: true},
    type: {type: String, required: true, enum: ["Bid", "Sold", "Bought", "Fail"]}
});

module.exports = mongoose.model('Notification', notificationSchema);