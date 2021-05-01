const jwt = require('jsonwebtoken');
const USER_KEY = process.env.USER_KEY;
module.exports = (req, res, next)=>{
    // TODO validate user 
    try {
        // let token = req.headers.authorization.split(" ")[1];
        let token = req.headers.authorization;
        // let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDRkZTg4ZjIxMmE3NTIzOTY2NWVmYzQiLCJlbWFpbCI6ImVtYWlsQGVtYWlsLmNvbSIsImZpcnN0TmFtZSI6ImZpcnN0IiwiaWF0IjoxNjE3ODU4NjgyLCJleHAiOjE2MTkwNjgyODJ9.prttBvI2Wp6DV-iI2Qie2Mbb3OqqI82gxcNfxKB0dWY";
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