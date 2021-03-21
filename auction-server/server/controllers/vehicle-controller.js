//
//
const vehicleModel = require('../models/Vehicle');
const schemaVehicle = require('../validator/vehicle');
const commentModel = require('../models/Comment');
const schemaComment = require('../validator/')
const deleteFile = require('../helper/file');
const postVehicle = async (req, res)=>{
    let {_id:u_id} = req.userData;
    try{
        let validationError = await schemaVehicle.validate(req.body, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({
                msg: 'Validation error',
                errors: validationErrorMsg
            })
        };
        let newVehicle = new vehicleModel({u_id,...req.body });
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
const getVehicles = (req, res)=>{
    // TODO get filter parameters
    
    vehicleModel.find().then((vehicles)=>{
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
    })
    ;
}
const getVehicle = async (req, res)=>{
    let {id} = req.params;
    try {
        let post = await vehicleModel.find({_id: id});
        if(post){
            return res.status(200).json({
                post
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
const deleterVehicle = async (req, res)=>{
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
    let {id} = req.params;
    let {message} = req.body;
    let {_id:u_id} = req.userData;

    try {
        let validationError = await schemaComment.validate({message,id }, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({msg: 'Validation error', validationErrorMsg});
        }
        let newComment = new commentModel({message, v_id,u_id });
        let result = await newComment.save();
        return res.status(200).json({msg: 'Comment added', result});
    } catch (error) {
        // TODO log error
        return res.status(500).json({msg: 'Server Error'});
    }
}
module.exports = {
    postVehicle,
    getVehicle,
    getVehicles,
    deleterVehicle,
    postComment
}