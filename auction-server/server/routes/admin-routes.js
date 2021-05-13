const router = require('express').Router();
const {
    postLogin,
    postRegister,
    postSuperLogin
} = require('../controllers/admin-controller/admin-account');
const {adminLogin, adminRegister} = require('../validator/admin');
const authSuper = require('../middleware/authSuper');

router.post('/login',adminLogin, postLogin);
router.post('/register',adminRegister, authSuper, postRegister);
router.post('/superlogin', postSuperLogin );

module.exports = router;