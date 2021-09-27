//
const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('./server.js');
// configure chai
chai.use(chaiHttp);
chai.should();

describe("App", ()=>{
    // test 
    descrive('GET /public/list-cars', ()=>{
        it('should return array of string', (done)=>{
            chai.request(app)
            .get('/public/list-cars')
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('Array');
                done();
            })
        })
    })
})