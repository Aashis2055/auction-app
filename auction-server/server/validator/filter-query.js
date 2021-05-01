const joi = require('joi');

const filterSchema = joi.object({
    type: joi.string().allow('Bike', 'Scotter', 'Car'),
    price : joi.number().min(2000),
    model: joi.string(),
    brand: joi.string()
});

module.exports = filterSchema;