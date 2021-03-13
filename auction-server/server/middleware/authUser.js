const jwt = require('jsonwebtoken');
const SECRET_KEY = "the user key";
module.exports = (req, res, next)=>{
    // TODO validate user 
    try {
        // let token = req.headers.authorization.split(" ")[1];
        // let doken = jwt.verify(token, SECRET_KEY);
        // req.userData = decode;
        req.userData.u_id = '1';
        next();
    } catch (error) {
        res.status(401).json({
            msg: 'Unauthorized'
        })
    }
}