import axios from 'axios';
import React, { Component } from 'react';
import Card from '../components/Card';
const URL = 'http://localhost:5000/';
export default class Dashboard extends Component {
    constructor(){
        super();
        this.state = {
            posts:[

            ]
        }
    }
    render() {
        let {posts} = this.state;
        return (
            <div>
                {
                    posts.map((post)=>{
                        <Card post={post} />
                    })
                }
            </div>
        )
    }
    componentDidMount = ()=>{
        axios.get(`${URL}vehicle-api/vehicles`).then((response)=>{
            console.log(response);
        }).catch((error)=>{

        });
    }
}
