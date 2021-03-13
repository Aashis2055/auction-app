const Filter = require('bad-words');
var filter = new Filter();

const filterProfanity = (req, res, next)=>{
    filter.addWords('jkjk');
    let flag = true;
    // end if the body is empty
    if(Object.keys(req.body).length === 0){
        console.log("empty");
        return res.send("empty");
    }
    for(const property in req.body){
        if(filter.isProfane(req.body[property].toString())) flag = false;
    }
    if(flag) next();
    else return res.send("profanity error");
}

module.exports = filterProfanity;