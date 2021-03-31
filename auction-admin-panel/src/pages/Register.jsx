import axios from 'axios';
import React, { Component } from 'react';
import {toast} from 'react-toastify';

export default class Register extends Component {
    constructor(){
        super();
        this.state = {
            email: '',
            firstName: '',
            lastName: '',
            password: ''
        }
    }
    render() {
        return (
            <div>
                <form action="">
                    <label htmlFor="email">Email:</label>
                    <input type="email" name="email" id=""/>
                    <label htmlFor="first">First Name:</label>
                    <input type="text" name="first" id=""/>
                    <label htmlFor="last">Last Name:</label>
                    <input type="text" name="last" id=""/>
                    <label htmlFor="password">Password:</label>
                    <input type="password" name="password" id=""/>
                    <button type="submit" onClick={this.submit}>Register</button>
                </form>
            </div>
        )
    }

    submit = (event)=>{
        event.preventDefault();
        let {email, firstName, lastName, password} = this.state;
        axios.post('http://localhost:5000/admin-api/rgister', {
            email, firstName, lastName, password
        }).then(response=>{
            console.log(response);
        }).catch(error=>{
            console.log(error);
            if(error.response){
                toast.error(error.response.msg);
            }else if(error.request){
                toast('chick internet connection');
            }else {
                toast('something went wrong');
            }
        })
    }
}
