//
const router = require('express').Router();
//
const authAdmin = require('../middleware/authAdmin');
const authId = require('../middleware/authId');
const {
    getVehicle,
    getVehicles,
    deleteVehicle,
    deleteComment,
    deleteReply
} = require('../controllers/vehicle-controller');
const {
    getUser,
    getUsers,
    updateUser
} = require('../controllers/admin-controller/admin-account');

router.get('/vehicle', authAdmin, getVehicles);
router.get('/vehicle/:id', authAdmin, getVehicle)
router.get('/user', authAdmin, getUsers);
router.put('/user/:id', authAdmin, updateUser);
router.get('/user/:id', authAdmin, authId,getUser);
router.delete('/vehicle/:id', authAdmin, deleteVehicle );
router.delete('/comment/:id', authAdmin, authId, deleteComment);
router.delete('reply/:id', authAdmin,authId, deleteReply);

module.exports = router;