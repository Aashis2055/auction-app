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
                {loginStatus ? (<Link href="/register" to="/register">Register</Link>) : null}
                {loginStatus ? (<Link href="/dashboard" to="/dashboard">Dashboard</Link>) : null}
                {loginStatus ? (<Link href="/users" to="/users">Users</Link>) : null}

                <div>Login Status: {loginStatus? 'Yes': "No"}</div>
                {/* <FontAwesomeIcon icon={["fal", "coffee"]} /> */}
            </nav>
        )
    }
    
}
