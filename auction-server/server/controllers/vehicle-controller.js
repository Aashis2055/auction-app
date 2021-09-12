//
const vehicleModel = require('../models/Vehicle');
const commentModel = require('../models/Comment');
// validation models
const {schemaComment, schemaReply} = require('../validator/comment');
const schemaVehicle = require('../validator/vehicle');
const schemaFilter = require('../validator/filter-query');
const {scheduleEnd} = require('../events/schedule-jobs');
const VehicleSpecs = require('../models/VehicleSpecs');
const postVehicle = async (req, res)=>{
    let {_id:u_id, filePath} = req.userData;
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
            scheduleEnd(req.body.end_date);
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
const getUpcomingVehicles = async(req, res)=>{
    try{
        const date = new Date();
        console.log(date.toISOString());
        const posts = await vehicleModel.find({auction_date: {"$gte": date.toISOString()}});
        if(posts.length === 0){
            return res.status(204).json({ message: 'No content found'});
        }
        return res.status(200).json({posts})
    }catch(error){
        // TODO log error
        console.log(error);
        return res.status(500).json({msg:"Server error"});
    }
}
const getVehicles = async (req, res)=>{
    // TODO get filter parameters
    console.log(req.query);
    const {address} = req.userData;
    const filter = req.query;
    const filt = {
        minPrice: 0,
        maxPrice: 5000000
    }
    try{
        let filterError = schemaFilter.validate(filter, {abortEarly: false});
        if(filterError && filterError.error){
            let validationErrorMsg = filterError.error.details.map(data => data.message);
            return res.status(400).json({
                msg: 'Validation error',
                errors: validationErrorMsg
            })
        };
        let date = new Date();
        vehicleModel.find({$and: [
            {auction_date: {"$lte": date.toISOString()}},
            {end_date: {"$gte": date.toISOString()}},
            filter
        ]}).populate({
            path: 'u_id',
            match: {status: false}
        }).then((vehicles)=>{
            /**
             * @description filter the post whose users are active
             */
            const data = vehicles.filter(vehicle=>{
                if(vehicle.initial_price > filt.minPrice && vehicle.initial_price < filt.maxPrice){
                    return vehicle.u_id != null;
                }else return false;
            });
            if(data.length === 0){
                return res.status(204).json({ message: 'No content found'});
            }
            return res.status(200).json({
                message:'ok',
                posts: data
            });
        }).catch((error)=>{
            console.log(error);
            return res.status(500).json({
                message: 'Server Error'
            })
        });
    }catch(error){
        // TODO log error
        console.log(error);
        res.status(500).json({msg: 'Server Error'});
    }
    
}
const getVehicle = async (req, res)=>{
    let {id} = req.params;
    try {
        // let data = await commentModel.find({})
        //     .populate(vehicleModel.)
        // return res.json({data});
        // let post = await commentModel.find();
        // return res.json({post});
        // let post = await vehicleModel.collection.aggregate([
        //     {$lookup: {from: 'Comment'}, localField: "_id",  foreignField:  "v_id", as: "comments"}
        // ]);
        // return res.json({post});
        // let post = await vehicleModel.findOne({_id: id}).populate('v_id').exec((err, item)=>{
        //     if(err) return res.status(500).json({err});
        //     return res.json({item});
        // });
        const post = await vehicleModel.findOne({_id:id}).populate('Comment.v_id');
        const comments = await commentModel.find({v_id:id});
        console.log(post);
        if(post){
            return res.status(200).json({
                post,
                comments
            });
        }
        else{
            return res.status(404).json({msg: 'Id not found'});
        }
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json({ msg: 'Server Error'});
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
/**
 * @desc callback for posting reply for user
 * 
 */
const postReply = async(req, res)=>{
    let{_id:u_id} = req.userData;
    let {reply} = req.body;
    let {id:c_id} = req.params;
    try {
        let validationError = await schemaReply.validate({reply,c_id, u_id}, {abortEarly: false});
        if(validationError && validationError.error){
            let validationErrorMsg = validationError.error.details.map(data => data.message);
            return res.status(400).json({msg: 'Validation error', validationErrorMsg});
        }
        let newReply = {reply: {reply,u_id}};
        // TODO make so that only the user who pasted can reply
        let result = await commentModel.findOneAndUpdate({_id: c_id}, newReply);
        return res.status(200).json({msg: 'Reply posted', result});
    } catch (error) {
        // TODO log error
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
const getPredication = async (req, res)=>{
    console.log('here');
    const {year, model, brand, km_Driven} = req.query;
    // TODO predict 
    const availableBrand = ["TVS", "Yamaha", "KTM"];
    if(availableBrand.includes(model)){
        return res.status(200).json({msg: 'Working on it'});
    }else{
        res.status(404).json({msg: 'Not supported for the model'});
    }
}
const testRoute = async (req, res)=>{
    let {id} = req.params;
    try {
        // const post = await vehicleModel.findOne({_id:id});
        // const comments = await commentModel.find({v_id:id});
        vehicleModel.find().populate('u_id').exec(function (err, post){
            if(err)
                return res.json(err);
            return res.json(post);
        });
        // console.log(post);
        // if(post){
        //     return res.status(200).json({
        //         post,
        //         comments
        //     });
        // }
        // else{
        //     return res.status(404).json({msg: 'Id not found'});
        // }
    } catch (error) {
        // TODO log error
        console.log(error);
        return res.status(500).json({ msg: 'Server Error'});
    }
}

module.exports = {
    postVehicle,
    getVehicle,
    getVehicles,
    postComment,
    postReply,
    deleteComment,
    deleteReply,
    getUpcomingVehicles,
    getPredication,
    testRoute
}

// select * from Vehicle join Comment on vehicle_id = Comment.v_id where vehicle._id = id;