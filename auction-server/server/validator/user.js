const Joi = require('joi');

const userLogin = Joi.object({
    email: Joi.string().required().email().max(20),
    password: Joi.string().required().min(4).max(20)
})

const userRegister = Joi.object({
    email: Joi.string().required().email().max(20).min(2),
    password: Joi.string().required().min(4).max(20),
    firstName: Joi.string().required().min(2).max(20),
    lastName: Joi.string().required().min(2).max(20)
})

module.exports = {
    userLogin, userRegister
}