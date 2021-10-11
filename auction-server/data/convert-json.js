const fs = require('fs');
const csv = require('csv-parser');
const path = require('path');

let results = [];
// Specifying source directory + file name

fs.createReadStream('./datas/bike_scooter2.csv')
.pipe(csv())
.on('data', (data) =>{
    results.push({
        "model": data.model.trim().toLowerCase(),
        "brand": data.brand.trim().toLowerCase(),
        "price": parseInt(data.current_price),
        "engine_displacement": parseInt(data.engine),
        "mielage":parseInt(data.mielage),
        "type":data.Type.trim()
    });
} )
.on('end', () => {
    console.log(results[3]);
    results = [...new Set(results)];
    const write = JSON.stringify(results);

    fs.writeFile('./bikespecs3.json', write, err=>{
        if(err) console.log(err.message);
        else console.log('Write sucess');
    })
});