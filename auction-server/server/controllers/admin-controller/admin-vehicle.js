const vehicleModel = require('../../models/Vehicle');
const commentModel = require('../../models/Comment');
// validation models
const schemaFilter = require('../../validator/filter-query');
const deleteFile = require('../../helper/file');
const getVehicles = async (req, res)=>{
    console.log(req.query);
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
        vehicleModel.find().then((vehicles)=>{
            if(vehicles.length === 0){
                return res.status(204).json({ message: 'No content found'});
            }
            const data = vehicles.map((vehicle)=>{
                if(vehicle.initial_price > filt.minPrice && vehicle.initial_price < filt.maxPrice){
                    return vehicle;
                }
            });
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
        const post = await vehicleModel.findOne({_id:id});
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
    getVehicle,
    getVehicles,
    deleteVehicle,
    deleteComment,
    deleteReply
}
