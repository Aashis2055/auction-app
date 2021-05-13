const {check} = require('express-validator');

// adminLogin = [
//     check('email')
//     .isEmail()
//     .notEmpty().withMessage('email is required'),

//     check('password')
//     .isString().notEmpty()
//     .isLength({ min: 5, max: 20})
//     .isStrongPassword().withMessage("Password not strong")
// ];
adminLogin = [
    check('email').isEmail().notEmpty().withMessage('Email is required'),
    check('password', 'Your password must be at least 5 characters').notEmpty()
]

adminRegister = [
    check('email').isEmail().notEmpty(),
    check('password').isString().notEmpty().isLength({min:5, max: 20}),
    check('role', 'Role is required').isString().notEmpty().isIn(["Admin","Moderator"])
]

module.exports = {
    adminLogin, adminRegister
}
