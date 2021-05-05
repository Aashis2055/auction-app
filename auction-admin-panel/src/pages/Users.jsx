import axios from 'axios';
import UserCard from '../components/UserCard';
import {getToken} from '../helper/localstorage';
import {toast, ToastContainer} from 'react-toastify';
import React, { Component } from 'react'
import { Link } from 'react-router-dom';
const URL = 'http://localhost:5000/';

export default class Users extends Component {
    constructor(){
        super();
        this.state = {users: []}}
    render() {
        const {users} = this.state;
        return (
            <div>
                {
                    users.map((user, index)=> <Link to={"/user/"+user._id}><UserCard user={user} index={index} /></Link> )
                }
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = ()=>{
        axios.get(`${URL}admin-api/users`,{
            headers:{authorization: getToken()}
        }).then((response)=>{
            let{users} = response.data;
            console.log(users);
            this.setState({
                users
            });
        }).catch((error)=>{
            console.log(error);
            if(error.response) toast.error(error.response.msg);
            else if(error.request) toast.error('check your internet connection');
            else toast.error('Some thing went wrong');
        })
    }
}

