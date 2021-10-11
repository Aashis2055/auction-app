// npm modules 
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
// models
const userModel = require('../models/Users');
const vehicleModel = require('../models/Vehicle');
const notificationModel = require('../models/Notification');
const {userLogin, userRegister} = require('../validator/user');
const SALT_ROUND = 10;
const USER_KEY = process.env.USER_KEY;

//
const errorMsg = { message: 'Server Error'};
const postLogin = async (req, res)=>{
    let {email,password} = req.body;
    console.log(email,password);
    try{
        const loginValidationError = await userLogin.validate(req.body, {abortEarly: false});
        if(loginValidationError && loginValidationError.error){
            let loginerrormsg = loginValidationError.error.details.map(data=>{
                return data.message;
            });
            console.log(loginerrormsg);
            return res.status(400).json({error: loginerrormsg})
        }// eof validation
        email = email.toLowerCase();
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
        let {_id, firstName,  lastName, address} = currentUser;
        let token = jwt.sign({
            _id, email, firstName, lastName, address
        }, USER_KEY, {expiresIn: '8w'});
        return res.status(200).json({ msg: 'Login Sucess', token});
    }catch(error){
        // TODO log error
        console.log(error)
        return res.status(500).json(errorMsg)
    }
}
const postRegister = async (req, res)=>{
    let {email, password, first_name, last_name, province, district, phone_no} = req.body;
    let address = {province, district};
    try {
        // validation
        const registerValidationError = await userRegister.validate(req.body, {abortEarly: false});
        if(registerValidationError && registerValidationError.error){
            let registererror = registerValidationError.error.details.map(data => data.message);
            console.log(registererror);
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
        let newUser = new userModel({ first_name,last_name, email, password: hash, address,phone_no });
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
const getProfile = async (req, res)=>{
    const {_id} = req.userData;
    try {
        let user = await userModel.findOne({_id});
        if(user){
            return res.status(200).json({msg: 'Ok', user});
        }
        return res.status(404).json({msg: 'No user'});
    } catch (error) {
        // TODO log error
        console.log(error)
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getUserPosts = async (req, res)=>{
    const {_id} = req.userData;
    try{
        let posts = await vehicleModel.find({u_id: _id}).lean()
        .populate('u_id', 'address.district');
        if(posts.length !== 0){
            return res.status(200).json({posts});
        }
        else{
            return res.status(404).json({msg: 'No Posts'});
        }
    }catch(error){
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const addWatchList = async(req, res)=>{
    const {id} = req.params;
    const{_id} = req.userData;
    try{
        // push id to array
        const result = await userModel.updateOne({_id}, { $push: {"watch_list": id} });
        return res.status(201).json({result});
    }catch(e){
        console.log(e);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const deleteWatchList = async (req, res)=>{
    const {id} = req.params;
    const{_id} = req.userData;
    try{
        const result = await userModel.updateOne({_id}, {$pull: {"watch_list": { $in: [id]}}});
        return res.status(200).json({ msg: 'OK', result});
    }catch(e){
        console.log(e);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getWatchList = async (req, res)=>{
    const {_id} = req.userData;
    try{
        const result = await userModel.findOne({_id}).select('watch_list');
        // TODO check if array is empty
        if(result.length === 0){
            return res.status(404).json({msg: 'No Content'});
        }
        return res.status(200).json({msg: 'OK', result});
    }catch(e){
        console.log(e);
        return res.status(500).json({msg: 'Server Error'});
    }
}
// handlebars
const getPosts = async (req, res)=>{
    try {
        let date = new Date();
        let result = await vehicleModel.find({$and: [
            {auction_date: {"$lte": date.toISOString()}},
            {end_date: {"$gte": date.toISOString()}},
        ]}).lean();
        if(result.length === 0){
            return res.render('vehicles', {layout: false, result});
        }
        console.log(result);
        return res.render('vehicles', {layout: false, result})
    } catch (error) {
        // TODO log error
        return res.status(500).json({msg: 'Server Error'});
    }
}
const getPost = async (req, res)=>{
    let {id} = req.params;
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
const getNotifications = async (req, res)=>{
    const {_id} = req.userData;
    console.log(_id);
    try{
        const result = await notificationModel.find({u_id:_id}).sort({date: -1});
        if(result.length === 0){
            return res.status(204).json({msg: 'No Notification'});
        }
        return res.status(200).json({notifications: result});
    }catch(error){
        console.log(error);
        res.status(500).json({msg: 'Server Error'});

    }
}
module.exports = {
    postLogin,
    postRegister,
    getProfile,
    getUserPosts,
    getWatchList,
    deleteWatchList,
    addWatchList,
    // handlebars
    getPosts,
    getPost,
    getNotifications
}
