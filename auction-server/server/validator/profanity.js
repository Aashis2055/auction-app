const Filter = require('bad-words');
var filter = new Filter();

const filterProfanity = (req, res, next)=>{
    filter.addWords('jkjk');
    let flag = true;
    // end if the body is empty
    if(Object.keys(req.body).length === 0){
        return res.status(400).json({msg: "Validatoin error"});
    }
    for(const property in req.body){
        if(filter.isProfane(req.body[property].toString())) flag = false;
    }
    if(flag) next();
    else return res.send("profanity error");
}

module.exports = filterProfanity;