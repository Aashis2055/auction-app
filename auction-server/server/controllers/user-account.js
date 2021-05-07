// 
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
//
const userModel = require('../models/Users');
const vehicleModel = require('../models/Vehicle');
const commentModel = require('../models/Comment');
const {userLogin, userRegister} = require('../validator/user');
const SALT_ROUND = 10;
const USER_KEY = process.env.USER_KEY;

//
const errorMsg = { message: 'Server Error'};
const postLogin = async (req, res)=>{
    let {email, password} = req.body;
    try{
        email = email.toLowerCase();
        const loginValidationError = await userLogin.validate(req.body, {abortEarly: false});
        if(loginValidationError && loginValidationError.error){
            let loginerrormsg = loginValidationError.error.details.map(data=>{
                return data.message;
            })
            return res.status(200).json({error: loginerrormsg})
        }// eof validation
        let currentUser = await userModel.findOne({email});
        // if account does not exist
        if(currentUser === null)       
            return res.status(401).json({message: 'Auth fail'});
        // compare password
        let comparePassword = bcrypt.compareSync(password, currentUser.password);
        // if password does not match
        if(!comparePassword){
            return res.status(401).json({ message: 'Invalid password'});
        }// eof pasword check
        // generate web token
        let {_id, firstName} = currentUser;
        let token = jwt.sign({
            _id, email, firstName
        }, USER_KEY, {expiresIn: '8w'});
        console.log(token);
        return res.status(200).json({ msg: 'Login Sucess', token});
    }catch(error){
        // TODO log error
        console.log(error)
        return res.status(500).json(errorMsg)
    }
}
const postRegister = async (req, res)=>{
    let {email, password, firstName, lastName} = req.body;
    try {
        // validation
        const registerValidationError = await userRegister.validate(req.body);
        if(registerValidationError && registerValidationError.error){
            let registererror = registerValidationError.error.details.map(data => data.message);
            return res.status(400).json({
                message: 'validation error',
                error: registererror
            })
        }// eof validation
        email = email.toLowerCase();
        // check for duplicate
        let oldUser = await userModel.find({email});
        if(oldUser.length > 0){
            return res.status(422).json({ message: 'Email auth'});
        }// if email already exists
        // hash password
        let hash = bcrypt.hashSync(password,SALT_ROUND );
        let newUser = new userModel({ firstName,lastName, email, password: hash});
        let result = await newUser.save();
        return res.status(201).json({
            message: 'Registered'
        })
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json(errorMsg);
    }
}
const getPosts = async (req, res)=>{
    let {_id} = req.userData;
    try {
        let result = await vehicleModel.find({u_id: _id});
        if(result.length === 0){
            return res.status(204).json({msg: 'No content'});
        }
        return res.status(200).json({
            result
        })
    } catch (error) {
        // TODO log error
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getPost = async (req, res)=>{
    // let {id} = req.params;
    let id = "6055e37967d9de1f2b909fe6";
    try {
        let post = await vehicleModel.findOne({_id: id}).lean();
        // const comments = await commentModel.find({v_id:id});
        // post.comments = comments;
        console.log(post);
        if(post){
            return res.render('vehicle',{layout:false, post});
        }
        else{
            return res.status(404).json({
                msg: 'Id not found'
            });
        }
    } catch (error) {
        // TODO log error
        console.log(error);

        return res.status(500).json({ msg: 'Server Error'});
    }
}
module.exports = {
    postLogin,
    postRegister,
    getPosts,
    getPost
}