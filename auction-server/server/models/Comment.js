const mongoose = require('mongoose');
const replyModel = require('./Reply');
const schema = mongoose.Schema;
const id = mongoose.Schema.Types.ObjectId;

const commentModel = new mongoose.Schema({
    u_id: {type: id, required: true},
    v_id: {type: id, required: true},
    comment: {type: String, required: true},
    added_date: {type: Date, required: true, default: Date.now()},
    reply: {type: replyModel, default: null}
})

module.exports = mongoose.model('comment', commentModel);