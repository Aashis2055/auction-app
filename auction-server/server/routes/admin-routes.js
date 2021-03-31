const router = require('express').Router();
const {
    postLogin,
    postRegister
} = require('../controllers/admin-controller/admin-account');
const {adminLogin, adminRegister} = require('../validator/admin');
router.post('/login',adminLogin, postLogin);
router.post('/register',adminRegister, postRegister);

module.exports = router;