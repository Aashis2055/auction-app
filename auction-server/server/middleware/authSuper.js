const jwt = require('jsonwebtoken');
const ADMIN_KEY = process.env.ADMIN_KEY;
module.exports = (req, res, next)=>{
    // TODO validate user 
    try {
        let token = req.headers.authorization.split(" ")[1];
        // let token = req.headers.authorization;
        let decode = jwt.verify(token, ADMIN_KEY);
        if(decode.email === "super@email.com"){
            req.userData = decode;
            next();
        }else{throw 'unauthorized';}
        
    } catch (error) {
        console.log(error);
        res.status(401).json({
            msg: 'Unauthorized'
        })
    }
}