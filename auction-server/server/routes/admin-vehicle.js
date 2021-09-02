//
const router = require('express').Router();
//
const authAdmin = require('../middleware/authAdmin');
const {
    getVehicle,
    getVehicles,
    deleteVehicle,
    deleteComment,
    deleteReply,
    postVehicleSpecs,
    getVehicleSpecs
} = require('../controllers/admin-controller/admin-vehicle');
const {
    getUser,
    getUsers,
    updateUser,
    generateNotifications
} = require('../controllers/admin-controller/admin-account');
const authId = require('../middleware/authId');
router.get('/vehicle', authAdmin, getVehicles);
router.get('/vehicle/:id', authAdmin,authId, getVehicle);
router.delete('/vehicle/:id', authAdmin, authId, deleteVehicle );

router.post('/vehiclespecs', authAdmin, postVehicleSpecs);
router.get('/vehiclespecs', authAdmin, getVehicleSpecs);

router.get('/users', authAdmin, getUsers);
router.put('/user/:id', authAdmin, authId, updateUser);
router.get('/user/:id', authAdmin, authId,getUser);
router.delete('/comment/:id', authAdmin, authId, deleteComment);
router.delete('/reply/:id', authAdmin,authId, deleteReply);
router.get('/generate', authAdmin, generateNotifications);
module.exports = router;