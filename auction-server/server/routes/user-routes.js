const router = require('express').Router();
//
const {postLogin, postRegister} = require('../controllers/user-account');
const profanity = require('../validator/profanity');
const authSuper = require('../middleware/authSuper');
router.post('/login',profanity, postLogin);
router.post('/register',profanity, authSuper,  postRegister)

module.exports = router;