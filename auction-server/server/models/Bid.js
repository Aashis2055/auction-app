const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const id = Schema.Types.ObjectId;

// const bidSchema = new Schema({
//     price: {type: Number, required: true, default: 0},
//     u_id: {type: id, required: true},
//     date: {type: Date, required: Date.now},
//     v_id: {type: id, required: true}
// });

// module.exports = mongoose.model('bid', bidSchema);
module.exports = {
    price: {type: Number, required: true, default: 0},
    u_id: {type: id, required: true},
    date: {type: Date, required: Date.now}
}