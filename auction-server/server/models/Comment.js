const mongoose = require('mongoose');
const schema = mongoose.Schema;
const id = mongoose.Schema.Types.ObjectId;

const commentModel = new mongoose.Schema({
    u_id: {type: id, required: true},
    v_id: {type: id, required: true},
    comment: {type: String, required: true},
    added_date: {type: Date, required: true, default: Date.now()}
})

module.exports = mongoose.model('comment', commentModel);