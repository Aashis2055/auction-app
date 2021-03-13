const {body} = require('express-validator');

adminLogin = [
    body('email')
    .isEmail()
    .notEmpty(),

    body('password')
    .isString().notEmpty()
    .isLength({ min: 5, max: 20})
    .isStrongPassword().withMessage("Password not strong")
];

adminRegister = [
    body('email').isEmail().notEmpty(),

    body('password').isString().notEmpty().isLength({min:5, max: 20})
]

module.exports = {
    adminLogin, adminRegister
}