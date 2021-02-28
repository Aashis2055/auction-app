// module imports 

// 
const adminModel = require('../models/Admins');

const postRegister = (req, res, next)=>{
    const {email, password} = req.body;
    // TODO validation
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
    // TODO validation
    // DataBase fetch 
    try {
        
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