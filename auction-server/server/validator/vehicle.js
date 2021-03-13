const Joi = require('joi');

const schemaVehicle = Joi.object({
    img: Joi.string()
        .alphanum()
        .min(3)
        .max(30)
        .required(),
    
    type: Joi.string().alphanum().required(),
    color: Joi.string().alphanum().required(),
    model: Joi.string().alphanum().required(),
    year: Joi.date().required(),
    km_driven: Joi.number().required().negative().not(),
    description: Joi.string().alphanum().required().min(5).max(200),
    initial_price: Joi.number().required().negative().not(),
    added_date: Joi.date().required(),
    auction_date: Joi.date().required(),
    end_date: Joi.date().required(),
    u_id: Joi.string().alphanum().required()
})

module.exports = schemaVehicle;