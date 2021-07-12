const jwt = require('jsonwebtoken');
const ADMIN_KEY = process.env.ADMIN_KEY;
/**
 * @description middleware function to validate super admin
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 */
module.exports = (req, res, next)=>{
    // TODO validate user 
    try {
        let token = req.headers.authorization.split(" ")[1];
        let decode = jwt.verify(token, ADMIN_KEY);
        if(decode.email === "super@email.com"){
            req.adminData = decode;
            next();
        }else{throw 'unauthorized';}
        
    } catch (error) {
        console.log(error);
        res.status(401).json({
            msg: 'Unauthorized'
        })
    }
}