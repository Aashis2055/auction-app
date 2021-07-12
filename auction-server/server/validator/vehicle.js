const Joi = require('joi');

const schemaVehicle = Joi.object({
    type: Joi.string().alphanum().required(),
    color: Joi.string().alphanum().required(),
    model: Joi.string().required(),
    brand: Joi.string().required(),
    year: Joi.date().required(),
    km_driven: Joi.number().required().min(0),
    description: Joi.string().required().min(5).max(200),
    initial_price: Joi.number().required(),
    auction_date: Joi.date().min(Date.now()),
    end_date: Joi.date().required(),
    
})

module.exports = schemaVehicle;