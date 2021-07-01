const Joi = require('joi-oid');

const schemaComment = Joi.object({
    comment: Joi.string().min(2).required(),
    v_id: Joi.objectId().required(),
    u_id: Joi.objectId().required()
})
const schemaReply = Joi.object({
    reply: Joi.string().required(),
    c_id: Joi.objectId().required(),
    u_id: Joi.objectId().required()
})
module.exports = {
    schemaComment,
    schemaReply
};