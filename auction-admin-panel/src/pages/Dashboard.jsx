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
                    posts.map((post, index)=>{
                        return <Card post={post} index={index} delete={this.removePost} />
                    })
                }
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = ()=>{
        axios.get(`${URL}admin-api/vehicle`, {
            headers:{
                authorization: getToken()
            }
        }).then((response)=>{
            const {posts} = response.data;
            this.setState({posts});
        }).catch((error)=>{
            console.log(error);
            if(error.response) toast.error(error.response.msg);
            else if(error.request) toast.error('check your internet connection');
            else toast.error('Some thing went wrong');
        });
    }
    removePost = (index)=>{
        let {_id} = this.state.posts[index];
        
        axios.delete(URL+"vehicle/"+_id, {
            headers: getToken()
        }).then((response)=>{
            if(response.status === 200){
                this.state.posts.splice(index-1, 1);
                this.setState({
                    posts: this.state.posts
                })
            }
        }).catch(error=>{
            console.log(error);
            toast.error('Something went wrong');
        })
    }
}
