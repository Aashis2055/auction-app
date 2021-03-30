const Joi = require('joi-oid');

const authId = async (req, res, next)=>{
    const schema = Joi.object({
        id: Joi.objectId()
    });
    const validationError = await schema.validate({id:req.params.id});
    if(validationError && validationError.error){
        let validationErrorMsg = validationError.error.details.map(()=>{
            
        })
        return res.status(400).json({msg: 'Validation Error'});
    }
    return next();
}
module.exports = authId;