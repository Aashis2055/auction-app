const router = require('express').Router();

//
const {
    getVehicle,
    getVehicles,
    postVehicle,
    deleterVehicle,
    postComment
} = require('../controllers/vehicle-controller');
const authUser = require('../middleware/authUser');
const authAdmin = require('../middleware/authAdmin');

router.post('/vehicle',authUser,  postVehicle );
router.get('/vehicle', authUser, getVehicles);
router.get('/vehicle/:id', authUser, getVehicle);
router.delete('/vehicle:id', authAdmin, deleterVehicle );
router.post('/commment', authUser, postComment)
module.exports = router;