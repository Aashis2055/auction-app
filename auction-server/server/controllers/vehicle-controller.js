//
//
const vehicleModel = require('../models/Vehicle');
const commentModel = require('../models/Comment');
// validation models
const schemaComment = require('../validator/comment');
const schemaVehicle = require('../validator/vehicle');
const schemaFilter = require('../validator/filter-query');
const deleteFile = require('../helper/file');
const { isMongooseId} = require('../helper/id-help');
const postVehicle = async (req, res)=>{
    let {_id:u_id, filePath} = req.userData;
    console.log(req.body);
    try{
        let validationError = await schemaVehicle.validate(req.body, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({
                msg: 'Validation error',
                errors: validationErrorMsg
            })
        };
        let newVehicle = new vehicleModel({u_id,img:filePath,...req.body });
        let result = await newVehicle.save().then(()=>{
            // TODO generate notification
            return res.status(200).json({
                message: 'posted'
            })
        }).catch(error=>{
            console.log(error);
            return res.status(500).json({msg: 'Server Error'});
        });
        
    }catch(error){
        return res.status(500).json({msg: 'Server Error'})
    }
}
const getVehicles = async (req, res)=>{
    // TODO get filter parameters
    console.log(req.query);
    const filter = req.query;
    try{
        let filterError = schemaFilter.validate(filter, {abortEarly: false});
        if(filterError && filterError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({
                msg: 'Validation error',
                errors: validationErrorMsg
            })
        };
        vehicleModel.find(filter).then((vehicles)=>{
            if(vehicles.length === 0){
                return res.status(204).json({ message: 'No content found'});
            }
            return res.status(200).json({
                message:'ok',
                posts: vehicles
            })
        }).catch((error)=>{
            console.log(error);
            return res.status(500).json({
                message: 'Server Error'
            })
        });
    }catch(error){
        // TODO log error
        res.status(500).json({msg: 'Server Error'});
    }
    
}
const getVehicle = async (req, res)=>{
    let {id} = req.params;
    try {
        let post = await vehicleModel.findOne({_id: id});
        const comments = await commentModel.find({v_id:id});
        // console.log(comments);
        // post.comments = comments;
        console.log(post);
        if(post){
            return res.status(200).json({
                post,
                comments
            });
        }
        else{
            return res.status(404).json({
                msg: 'Id not found'
            });
        }
    } catch (error) {
        // TODO log error
        return res.status(500).json({ msg: 'Server Error'});
    }
}
const deleteVehicle = async (req, res)=>{
    const {_id:a_id} = req.adminData;
    const {id:_id} = req.params;
    try {
        let vehicle = await vehicleModel.findOne({_id});
        deleteFile(vehicle.img);
        vehicle = await vehicleModel.deleteOne({_id});
        return res.status(200).json({msg: 'OK', vehicle})
    } catch (error) {
        // TODO log error
        return res.status(500).json({
            msg: 'Server Error'
        })
    }
}
const postComment = async (req, res)=>{
    let {id: v_id} = req.params;
    let {comment} = req.body;
    let {_id:u_id} = req.userData;
    try {
        let validationError = await schemaComment.validate({comment,v_id, u_id}, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({msg: 'Validation error', validationErrorMsg});
        }
        let newComment = new commentModel({comment, v_id,u_id });
        let result = await newComment.save();
        return res.status(200).json({msg: 'Comment added', result});
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
}
const postReply = async(req, res)=>{
    let{_id:u_id} = req.userData;
    let {reply} = req.body;
    let {id:c_id} = req.params;
    try {
        let flag = isMongooseId(c_id);
        if(!flag) return res.status(401).json({msg: 'Auth Error'});
        let newReply = {reply: {reply,u_id}};
        let result = await commentModel.findOneAndUpdate({_id: c_id}, newReply);
        return res.status(200).json({msg: 'Reply posted', result});
    } catch (error) {
        // TODO logo error
        console.log(error)
        return res.status(500).json({msg: 'Server Error'});
    }
}
const deleteComment = async (req, res)=>{
    let {id} = req.params;
    try {
        let result = await commentModel.deleteOne({_id: id});
        return res.status(200).json({msg: 'Comment deleted', result});
    } catch (error) {
        return res.status(500).json({msg: 'Server Error'});
    }
}
const deleteReply = async (req, res)=>{
    let {id} = req.params;
    try {
        let result = await commentModel.findOneAndUpdate({_id: id}, {reply: null});
        return res.status(200).json({msg: 'Reply deleted'});
        // let result =await  replyModel.deleteOne({_id: id});
        // return res.status(200).json({msg: 'Reply deleted', result});
    } catch (error) {
        return res.status(500).json({msg: 'Server Error'});
    }
}
module.exports = {
    postVehicle,
    getVehicle,
    getVehicles,
    deleteVehicle,
    postComment,
    postReply,
    deleteComment,
    deleteReply
}