// const mongoose = require('mongoose');
// const Schema = mongoose.Schema;
// const id = mongoose.Types.ObjectId;
// const replySchema = new Schema({
//     c_id:{type:id, required:true},
//     reply: {type:String, required: true},
//     u_id: {type:id, required:true}
// })
// module.exports = mongoose.model('Reply', replySchema);
const id = require('mongoose').Schema.ObjectId;

module.exports = {
    reply: {type:String, required: true},
    u_id: {type:id, required:true}
}