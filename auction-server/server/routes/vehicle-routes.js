const router = require('express').Router();
// 
const {
    getVehicle,
    getVehicles,
    postVehicle,
    deleteVehicle,
    postComment,
    postReply,
    deleteComment,
    deleteReply
} = require('../controllers/vehicle-controller');
const authUser = require('../middleware/authUser');
const authAdmin = require('../middleware/authAdmin');
const authId = require('../middleware/authId');

router.post('/vehicle',authUser,  postVehicle );
router.get('/vehicle', authUser, getVehicles);
router.get('/vehicle/:id', authUser, authId, getVehicle);
router.post('/commment', authUser, postComment)
router.post('/reply/:id', authUser, authId, postReply);

router.delete('/vehicle:id', authAdmin, deleteVehicle );
router.delete('/comment/:id', authAdmin, authId, deleteComment);
router.delete('reply/:id', authAdmin,authId, deleteReply);
module.exports = router;