import axios from 'axios';
import React, { Component } from 'react';
import Card from '../components/Card';
import { getToken} from '../helper/localstorage';
import {toast, ToastContainer} from 'react-toastify';

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
                        return <Card post={post} />
                    })
                }
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = ()=>{
        console.log(getToken());
        axios.get(`${URL}admin-api/vehicle`, {
            headers:{
                authorization: getToken()
            }
        }).then((response)=>{
            this.setState({
                posts: response.data.posts
            })
        }).catch((error)=>{
            console.log(error);
            if(error.response) toast.error(error.response.msg);
            else if(error.request) toast.error('check your internet connection');
            else toast.error('Some thing went wrong');
        });
    }
}
