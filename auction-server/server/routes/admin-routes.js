const router = require('express').Router();
const {
    postLogin,
    postRegister
} = require('../controllers/admin-controller/admin-account');

router.post('/login', postLogin);
router.post('/register', postRegister);

module.exports = router;