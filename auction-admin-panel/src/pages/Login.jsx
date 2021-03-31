import axios from 'axios';
import React, { Component } from 'react';
import { ToastContainer, toast } from 'react-toastify';
// import '../css/login.css';
import logo from '../logo.jpg';

export default class Login extends Component {
    
    constructor(){
        super();
        this.state = {
            email: '',
            password: ''
        }
    }
    render() {
        return (
            <div className="form-container">
                <div className="form-image">
                    <img src={logo} alt=""/>
                </div>
                <form className="form">
                    <h1>Login</h1>
                    <label htmlFor="email"><b>Email</b></label>
                    <input type="email" placeholder="Enter Email" name="email" required/>
                    <label htmlFor="password"><b>Password</b></label>
                    <input type="password" name="password" placeholder="Enter Password" required/>
                    <button type="submit" className="btn" onClick={this.onSubmit()}>Login</button>
                </form>
                <ToastContainer />
            </div>
        )
    }
    onSubmit = (event)=>{
        // let {email, password} = this.state;
        // // TODO validate data
        // event.preventDefault();
        // axios.post('http://localhost:5000/admin-api/login', {
        //     email, password
        // }).then((response)=>{
        //     console.log(response);
        //     if(response.status === 200){
        //         // this.props.loginAdmin();
        //     }
        // }).catch((error)=>{
        //     console.log(error);
        //     toast.error('Something went wrong');
        // })
    }
}
