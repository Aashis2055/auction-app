const router = require('express').Router();
//
const {postLogin, postRegister, getProfile, getNotifications} = require('../controllers/user-account');
const authUser = require('../middleware/authUser');
const profanity = require('../validator/profanity');

router.post('/login',profanity, postLogin);
router.post('/register',profanity,  postRegister)
router.get('/', authUser, getProfile);
router.get('/notifications', authUser, getNotifications);

module.exports = router;