import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import navcss from '../css/nav.css';

export default class NavBar extends Component {
    render() {
        let {loginStatus} = this.props;
        return (
            <nav className={navcss.topnav} >
                <Link className={navcss.active} href="/" to="/">Auction</Link>
                {
                    loginStatus ? (<Link to="" >Logout</Link>) : <Link href="/login" to="/login">Login</Link>
                }
                <Link href="/register" to="/register">Register</Link>
                <div>Login Status: {loginStatus? 'Yes': "No"}</div>
                {/* <FontAwesomeIcon icon={["fal", "coffee"]} /> */}
            </nav>
        )
    }
    
}
