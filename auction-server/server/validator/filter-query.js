const joi = require('joi');

const filterSchema = joi.object({
    type: joi.string().allow('Bike', 'Scotter', 'Car'),
    price : joi.number().min(2000),
    model: joi.string(),
    brand: joi.string(),
    year: joi.string(),
    minPrice: joi.number(),
    maxPrice: joi.number().not(joi.required())
});

module.exports = filterSchema;