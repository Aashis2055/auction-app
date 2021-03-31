const router = require('express').Router();
// 
const {
    getVehicle,
    getVehicles,
    postVehicle,
    postComment,
    postReply
} = require('../controllers/vehicle-controller');
const authUser = require('../middleware/authUser');
const authId = require('../middleware/authId');

router.post('/vehicle',authUser,  postVehicle );
router.get('/vehicle', authUser, getVehicles);
router.get('/vehicle/:id', authUser, authId, getVehicle);
router.post('/commment', authUser, postComment)
router.post('/reply/:id', authUser, authId, postReply);


module.exports = router;