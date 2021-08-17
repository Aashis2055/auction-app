const router = require('express').Router();
// 
const {
    getVehicle,
    getVehicles,
    postVehicle,
    postComment,
    postReply,
    getUpcomingVehicles,
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
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGU5NDkwYTg2OTRlNTcyMGM5YWQ3MjAiLCJlbWFpbCI6InVzZXJAZW1haWwuY29tIiwiaWF0IjoxNjI1OTAxODY3LCJleHAiOjE2MzA3NDAyNjd9.Qq8vY1vlu2Qoc_G0dG-X-eBKrAajag3k6J-WQtYMU80"
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGU5NDk2Yjg2OTRlNTcyMGM5YWQ3MjMiLCJlbWFpbCI6InVzZXIyQGVtYWlsLmNvbSIsImlhdCI6MTYyNTkwMjY0MCwiZXhwIjoxNjMwNzQxMDQwfQ.RxF3YMrwFFJTsrz-rYVUF04dNMIAX4YmwKFVBrnVvls";
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGU5NDk5MTg2OTRlNTcyMGM5YWQ3MjkiLCJlbWFpbCI6InVzZXI0QGVtYWlsLmNvbSIsImlhdCI6MTYyNTkwMzEyNywiZXhwIjoxNjMwNzQxNTI3fQ.5pgcIiS32HkqpRsYO-l19j96_RSBL3_QjmXV8eVSNWg";
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



module.exports = router;