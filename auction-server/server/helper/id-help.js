const Joi = require('joi-oid');
async function isMongooseId(id){
    const schema = Joi.object({
        id: Joi.objectId()
    });
    const validationError = await schema.validate({id});
    if(validationError && validationError.error){
        return false;
    }
    else return true;
}

module.exports = {
    isMongooseId
}