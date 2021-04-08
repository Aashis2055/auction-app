import axios from 'axios';
import React, { Component } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import {setToken} from '../helper/localstorage';
// import '../css/login.css';
// eslint-disable-next-line
import logo from '../logo.jpg';

export default class Login extends Component {
    
    constructor(){
        super();
        this.state = {
            email: 'admin@email.com',
            password: 'the password'
        }
    }
    render() {
        return (
            <div className="form-container">
                <div className="form-image">
                    {/* <img src={logo} alt=""/> */}
                </div>
                <form className="form">
                    <h1>Login</h1>
                    <label htmlFor="email"><b>Email</b></label>
                    <input type="email" placeholder="Enter Email" name="email" required onChange={this.onChangeHandler} value={this.state.email}/>
                    <label htmlFor="password"><b>Password</b></label>
                    <input type="password" name="password" placeholder="Enter Password" onChange={this.onChangeHandler} value={this.state.password} required/>
                    <button type="submit" className="btn" onClick={this.onSubmit}>Login</button>
                </form>
                <ToastContainer />
            </div>
        )
    }
    onSubmit = (event)=>{
        let {email, password} = this.state;
        // TODO validate data
        event.preventDefault();
        console.log(email, password);
        axios.post('http://localhost:5000/admin-api/login', {
            email, password
        }).then((response)=>{
            console.log(response);
            if(response.status === 200){
                const {token} = response.data;
                console.log(token);
                setToken(token);
                this.props.loginAdmin();
            }
        }).catch((error)=>{
            console.log(error);
            if(error.response) toast.error(error.response.msg);
            else if(error.request) toast.error('check your internet connection');
            else toast.error('Some thing went wrong');
        })
    }
    onChangeHandler = (event)=>{
        this.setState({
            [event.target.name]:event.target.value
        })
    }
}
