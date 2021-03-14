// module imports 
const {validationResult} = require('express-validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
// 
const adminModel = require('../../models/Admins');
const SALT_ROUND = 10;
const postRegister = async (req, res, next)=>{
    const {email, password} = req.body;
    const validationErrors = validationResult(req);
    email = email.toLowerCase();
    if(!validationErrors.isEmpty()){
        return res.status(400).json({
            msg: 'validation error',
            error: validationErrors.array()
        })
    }
    let oldAdmin = await adminModel.find({email});
    if(oldAdmin.length > 0){
        return res.status(422).json({message: 'Email auth'});
    }// if email already exists
    try {
        let hash = bcrypt.hashSync(password, SALT_ROUND);
        let newAdmin = new adminModel({ email, password:hash});
        let result = await newAdmin.save();
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

const postLogin = async (req, res) =>{
    const {email, password} = req.body;
    email = email.toLowerCase();
    try {
        const validationErrors = validationResult(req.body);
        if(!validationResult.isEmpty()){
            return res.status(200).json({ error: validationResult.array() });
        }// eof validation
        let currentAdmin = await adminModel.findOne({email});
        // if account does not exist
        if(currentAdmin === null)
            return res.status(401).json({ message: 'Auth fail'});
        // compare password
        let comparePassword = bcrypt.compareSync(password, currentAdmin.password);
        if(!comparePassword){
            return res.status(401).json({ message: 'Invalid password'});
        }// eof password check
        // generate web token
        let {_id, email} = currentAdmin;
        let token = jwt.sign({
            _id, email
        }, SALT_ROUND, {expiresIn: '1m'});
       return res.status(200).json({
           message: 'login sucessful',
           token: 'brearer '+token
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