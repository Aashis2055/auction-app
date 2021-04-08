import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import navcss from '../css/nav.css';

export default class NavBar extends Component {
    render() {
        let {loginStatus, logoutAdmin} = this.props;
        return (
            <nav className={navcss.topnav} >
                <Link className={navcss.active} href="/" to="/">Auction</Link>
                {
                    loginStatus ? (<span onClick={logoutAdmin}>Logout</span>) : <Link href="/login" to="/login">Login</Link>
                }
                <Link href="/register" to="/register">Register</Link>
                <div>Login Status: {loginStatus? 'Yes': "No"}</div>
                {/* <FontAwesomeIcon icon={["fal", "coffee"]} /> */}
            </nav>
        )
    }
    
}
