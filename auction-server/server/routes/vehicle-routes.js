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
    postBid,
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
        // one
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTFlMmZhYjI1Njg3ZTM3ZDUzYzA5ODQiLCJlbWFpbCI6InVzZXIxQGVtYWlsLmNvbSIsImFkZHJlc3MiOnsicHJvdmluY2UiOiJCYWdtYXRpIFByb3ZpbmNlIiwiZGlzdHJpY3QiOiJMYWxpdHB1ciJ9LCJpYXQiOjE2MzIwMzQ4MzksImV4cCI6MTYzNjg3MzIzOX0.1bnqYug-zGzVtyio6ZHG3AjJ9WG5DEe7i-YB2YxCb-A";
        // two 
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTI4NzgxNmNiODM0MDFlZWJjZGU5Y2YiLCJlbWFpbCI6InVzZXIyQGVtYWlsLmNvbSIsImFkZHJlc3MiOnsicHJvdmluY2UiOiJCYWdtYXRpIFByb3ZpbmNlIiwiZGlzdHJpY3QiOiJLYXRobWFuZHUifSwiaWF0IjoxNjMyMDM1NDUzLCJleHAiOjE2MzY4NzM4NTN9.LYZKZmxWta522EDgXXXdebRT9OeH_2uYhuJ969cgb1U";
        // six jhapa
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTQ2ZTY0YjYzYjA3ZDE3M2ExY2Y0OGMiLCJlbWFpbCI6InVzZXI2QGVtYWlsLmNvbSIsImFkZHJlc3MiOnsicHJvdmluY2UiOiJQcm92aW5jZSBObyAxIiwiZGlzdHJpY3QiOiJKaGFwYSJ9LCJpYXQiOjE2MzIwMzY0OTEsImV4cCI6MTYzNjg3NDg5MX0.61h_7eJ-aPqsfCSWBxltuNONDQZvdTwvnWFDgyKcNno";
        // seven panchthar
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTQ2ZTY2NTYzYjA3ZDE3M2ExY2Y0OGYiLCJlbWFpbCI6InVzZXI3QGVtYWlsLmNvbSIsImFkZHJlc3MiOnsicHJvdmluY2UiOiJQcm92aW5jZSBObyAxIiwiZGlzdHJpY3QiOiJQYW5jaHRoYXIifSwiaWF0IjoxNjMyMDM2NjQ4LCJleHAiOjE2MzY4NzUwNDh9.Q-89h-G-wHw5EnbReqvE5xKMaW3G8hn2C3hywVc4YTg";
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
router.post('/bid/:id', authUser, authId, postBid );
module.exports = router;