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
    check('email').not().isEmpty().withMessage('Email is required'),
    check('password', 'Your password must be at least 5 characters').not().isEmpty()
]

adminRegister = [
    check('email').isEmail().notEmpty(),

    check('password').isString().notEmpty().isLength({min:5, max: 20})
]

module.exports = {
    adminLogin, adminRegister
}
