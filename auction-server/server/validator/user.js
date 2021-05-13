const Joi = require('joi');

const userLogin = Joi.object({
    email: Joi.string().required().email().max(20),
    password: Joi.string().required().min(4).max(20)
})

const userRegister = Joi.object({
    email: Joi.string().required().email().max(20).min(2),
    password: Joi.string().required().min(4).max(20),
    first_name: Joi.string().required().min(2).max(20),
    last_name: Joi.string().required().min(2).max(20),
    address: Joi.object({
        province: Joi.string().required(),
        district: Joi.string().required()
    }).required(),
    phone_no: Joi.string().regex(/^98[0-9]{8}/).required()
})

module.exports = {
    userLogin, userRegister
}