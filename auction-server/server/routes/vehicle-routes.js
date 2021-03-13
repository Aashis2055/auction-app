const router = require('express').Router();

//
const {
    getVehicle,
    getVehicles,
    postVehicle
} = require('../controllers/vehicle-controller');
const authUser = require('../middleware/authUser');

router.post('/vehicle',authUser,  postVehicle );
router.get('/vehicle', authUser, getVehicles);
router.get('vehicle/:id', authUser, getVehicle);

module.exports = router;