const router = require('express').Router();
//
const {postLogin, postRegister} = require('../controllers/user-account');
const profanity = require('../validator/profanity');

router.post('/login',profanity, postLogin);
router.post('/register',profanity,  postRegister)

module.exports = router;