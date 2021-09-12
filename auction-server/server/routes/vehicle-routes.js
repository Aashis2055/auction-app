const router = require('express').Router();
// 
const {
    getVehicle,
    getVehicles,
    postVehicle,
    postComment,
    postReply,
    getUpcomingVehicles,
    getPredication,
    testRoute
} = require('../controllers/vehicle-controller');
const  {
    postFile
} = require('../controllers/file-controller');
const authUser = require('../middleware/authUser');
const authId = require('../middleware/authId');
const jwt = require('jsonwebtoken');
const USER_KEY = process.env.USER_KEY;
const testauth = (req, res, next)=>{
    // TODO validate user 
    console.log(req.body.auction_date);
    try {
        if(req.body.auction_date == ''){
            req.body.auction_date = Date.now()
            console.log(req.body.auction_date);
        }
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTI4NzgxNmNiODM0MDFlZWJjZGU5Y2YiLCJlbWFpbCI6InVzZXIyQGVtYWlsLmNvbSIsImFkZHJlc3MiOnsicHJvdmluY2UiOiJCYWdtYXRpIFByb3ZpbmNlIiwiZGlzdHJpY3QiOiJLYXRobWFuZHUifSwiaWF0IjoxNjMwODEyMjg4LCJleHAiOjE2MzU2NTA2ODh9.fwwtTOH8i7oqHq9DpWMkV1HNAqBo3rqyVOWnZOixB5w";
        let decode = jwt.verify(token, USER_KEY);
        req.userData = decode;
        next();
    } catch (error) {
        console.log(error);
        res.status(401).json({
            msg: 'Unauthorized'
        })
    }
}
// TODO remove before production
router.post('/testpost',testauth, postFile, postVehicle );
router.get('/testpop/:id', testRoute);

router.get('/upcoming', authUser, getUpcomingVehicles);
router.post('/vehicle',authUser, postFile,  postVehicle );
router.get('/vehicle', authUser, getVehicles);
router.get('/vehicle/:id', authUser, authId, getVehicle);
router.post('/comment/:id', authUser, authId, postComment);
router.post('/reply/:id', authUser, authId, postReply);
router.get('/prediction', authUser, getPredication);

module.exports = router;