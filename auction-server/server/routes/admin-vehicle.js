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
} = require('../controllers/vehicle-controller')

router.get('/vehicle', authAdmin, getVehicles);
router.get('/vehicle/:id', authAdmin, getVehicle)
router.delete('/vehicle:id', authAdmin, deleteVehicle );
router.delete('/comment/:id', authAdmin, authId, deleteComment);
router.delete('reply/:id', authAdmin,authId, deleteReply);

module.exports = router;