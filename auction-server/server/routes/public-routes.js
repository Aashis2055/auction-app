const router = require('express').Router();
const fs = require('fs');
router.get('/list-cars',(req, res)=>{
    const filePath = appRoot+'/server/models/list.json';
    try{
        let rawData = fs.readFileSync(filePath);
        let list = JSON.parse(rawData);
        let carsList = list.four_wheelers;
        return res.status(200).json(carsList);
    }catch(error){
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
} );
router.get('/list-all', (req, res)=>{
    const filePath = appRoot+'/server/models/list.json';
    try{
        let rawData = fs.readFileSync(filePath);
        let list = JSON.parse(rawData);
        return res.status(200).json(list);
    }catch(error){
        console.log(error);
        return res.status(500).json({msg: 'Server Error'});
    }
});
const getTwoWheelers = (req, res)=>{
    const filePath = appRoot+'/server/models/list.json';
    try{
        let rawData = fs.readFileSync(filePath);
        let list = JSON.parse(rawData);
        let twoWheelers = list.two_wheelers;
        console.log(twoWheelers);
        return res.status(200).json(twoWheelers);
    }catch(error){
        return res.status(500).json({msg: 'Server Error'});
    }
}
router.get('/list-bikes', getTwoWheelers);
router.get('/list-scooters', getTwoWheelers);

module.exports = router;