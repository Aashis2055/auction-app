const Joi = require('joi');

const schemaComment = new Joi({
    message: Joi.string().min(2).required(),
    id: Joi.string().required()
})