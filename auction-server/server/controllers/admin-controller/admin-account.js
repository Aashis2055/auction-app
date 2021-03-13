// module imports 
const {validationResult} = require('express-validator');
// 
const adminModel = require('../../models/Admins');

const postRegister = (req, res, next)=>{
    const {email, password} = req.body;
    // const validationErrors = validationResult(req);
    // if(!validationErrors.isEmpty()){
    //     return res.status(400).json({
    //         msg: 'validation error',
    //         error: validationErrors.array()
    //     })
    // }
    // TODO use jasonwebtoken
    try {
        let admin = new adminModel({email, password});
        admin.save();
        return res.status(201).json({
            message: 'admin created'
        })
    } catch (error) {
        logger.log({
            level: 'error',
            message: 'Admin Registration error '+error.msg,
            date: Date.now()
        })
    }
}

const postLogin = (req, res) =>{
    const {email, password} = req.body;
    // TODO validation
    // DataBase fetch 
    try {
       return res.status(200).json({
           email, password
       })
    } catch (error) {
        logger.log({
            level: 'error',
            message: 'Admin Login error '+error.msg,
            date: Date.now()
        })
    }
}
module.exports = {
    postRegister,
    postLogin
}