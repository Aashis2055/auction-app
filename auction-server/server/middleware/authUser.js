const jwt = require('jsonwebtoken');
const USER_KEY = process.env.USER_KEY;
module.exports = (req, res, next)=>{
    // TODO validate user 
    try {
        // let token = req.headers.authorization.split(" ")[1];
        let token = req.headers.authorization;
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDljZDkwNGI2NWM1NjU0ZDFlYzRiYTciLCJlbWFpbCI6InVzZXJAZW1haWwuY29tIiwiaWF0IjoxNjIwODkyNjQzLCJleHAiOjE2MjU3MzEwNDN9.4ugFH0LTbvwGUNQ5PeKEJwt1JpgCfuM-3uax2tdQQaI";
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDljZDk2MWI2NWM1NjU0ZDFlYzRiYTkiLCJlbWFpbCI6InVzZXIzQGVtYWlsLmNvbSIsImlhdCI6MTYyMDg5NjM0MiwiZXhwIjoxNjI1NzM0NzQyfQ.pzlZpzLl524e9nCeFKNVSD5TbrDn9_RTu2htAziuJgw";
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