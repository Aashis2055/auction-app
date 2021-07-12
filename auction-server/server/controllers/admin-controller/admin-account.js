// module imports 
const {validationResult} = require('express-validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
// 
const adminModel = require('../../models/Admins');
const userModel = require('../../models/Users');
const vehicleModel = require('../../models/Vehicle');
const SALT_ROUND = 10;
const ADMIN_KEY = process.env.ADMIN_KEY;
const postRegister = async (req, res, next)=>{
    let {email, password, role} = req.body;
    const validationErrors = validationResult(req);
    if(!validationErrors.isEmpty()){
        return res.status(400).json({
            msg: 'validation error',
            error: validationErrors.array()
        })
    }
    email = email.toLowerCase();
    let oldAdmin = await adminModel.find({email});
    if(oldAdmin.length > 0){
        return res.status(422).json({message: 'Email auth'});
    }// if email already exists
    try {
        let hash = bcrypt.hashSync(password, SALT_ROUND);
        let newAdmin = new adminModel({ email, password:hash, role});
        newAdmin.save().then((result)=>{
            return res.status(201).json({
                message: 'admin created',
                result
            })
        }).catch((error)=>{
            console.log(error);
            throw 'error';
        });
        
    } catch (error) {
        logger.log({
            level: 'error',
            message: 'Admin Registration error '+error.msg,
            date: Date.now()
        });
        console.log(error);
        return res.status(500).json({msg: 'Error'});
    }
}

const postLogin = async (req, res) =>{
    try {
        const validationErrors = validationResult(req);
        if(!validationErrors.isEmpty()){
            return res.status(200).json({ error: validationErrors.array() });
        }// eof validation
        let {email, password} = req.body;
        email = email.toLowerCase();
        let currentAdmin = await adminModel.findOne({email}).then((currentAdmin)=>{
            console.log(currentAdmin);
            // if account does not exist
            if(currentAdmin === null)
                return res.status(401).json({ message: 'Auth fail'});
            // compare password
            let comparePassword = bcrypt.compareSync(password, currentAdmin.password);
            if(!comparePassword){
                return res.status(401).json({ message: 'Invalid password'});
            }// eof password check
            // generate web token
            let {_id, role} = currentAdmin;
            console.log(_id);
            let token = jwt.sign({
                _id, email, role
            }, ADMIN_KEY, {expiresIn: '10w'});
            return res.status(200).json({
                message: 'login sucessful',
                token: 'brearer '+token
            })
        });
        
    } catch (error) {
        logger.log({
            level: 'error',
            message: 'Admin Login error '+error.msg,
            date: Date.now()
        })
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const postSuperLogin  = async (req, res)=>{
    try {
        const {email, password } = req.body;
        if(email === "super@email.com" && password === "super password"){
            const _id = 0;
            const role = "super";
            let token = jwt.sign({
                _id, email, role
            }, ADMIN_KEY, {expiresIn: '10w'});
            return res.status(200).json({
                message: 'login sucessful',
                token: 'brearer '+token
            });
        }else{
            return res.status(400).json({msg: 'Auth Error'})
        }
    } catch (error) {
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getUser = async (req, res)=>{
    const {id} = req.params;
    try {
        let user = await userModel.findOne({_id:id});
        if(user){
            let posts = await vehicleModel.find({u_id: id});
            return res.status(200).json({msg: 'Ok', user, posts});   
        }
        return res.status(404).json({msg: 'No user'});
    } catch (error) {
        // TODO log error
        console.log(error)
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getUsers = async (req, res)=>{
    console.log(req.query);
    // let {status = undefined, province=undefined,district=undefined, orderBy} = req.query;
    // const queryArray = [
    //     {status},
    //     {'address.province': province,},
    //     {'address.district': district}
    // ];
    
    try {
        let users = await userModel.find({}).sort({created_at: -1});
        if(users.length === 0)
            return res.status(404).json({msg: 'No Users'});
        return res.status(200).json({msg: 'OK', users});
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const updateUser = async (req, res)=>{
    // let {firstName, lastName} = req.body;
    const status = req.body.status;
    const _id = req.params.id;
    try {
        let result = await userModel.findOneAndUpdate({_id}, {status});
        return res.status(200).json({status: 'user modified',result})
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json({msg: 'Server error'});
    }
}
module.exports = {
    postRegister,
    postLogin,
    updateUser,
    getUser,
    getUsers,
    postSuperLogin
}