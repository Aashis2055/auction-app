const router = require('express').Router();
//
const {
    postLogin, 
    postRegister, 
    getProfile, 
    getWatchList,
    addWatchList,
    deleteWatchList,
    getNotifications,
    getUserPosts
} = require('../controllers/user-account');
const authUser = require('../middleware/authUser');
const authId = require('../middleware/authUser');
const profanity = require('../validator/profanity');

router.post('/login',(req, res, next)=>{
console.log(req.body);
next();
},profanity, postLogin);
router.post('/register',profanity,  postRegister)
router.get('/', authUser, getProfile);
router.get('/myPosts', authUser, getUserPosts);
router.get('/notifications', authUser, getNotifications);
router.get('/watchlist', authUser, getWatchList);
router.post('/watchlist/:id', authUser,authId, addWatchList);
router.delete('/watchlist/:id', authUser,authId, deleteWatchList);
module.exports = router;
