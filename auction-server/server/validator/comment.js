const Joi = require('joi');

const schemaComment = Joi.object({
    message: Joi.string().min(2).required(),
    id: Joi.string().required()
})
module.exports = schemaComment;