const Joi = require('joi-oid');

const schemaComment = Joi.object({
    comment: Joi.string().min(2).required(),
    v_id: Joi.objectId().required(),
    u_id: Joi.objectId().required()
})
module.exports = schemaComment;