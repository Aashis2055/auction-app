import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import navcss from '../css/nav.module.css';

export default class NavBar extends Component {
    render() {
        console.log(navcss.topnav);
        let {loginStatus, logoutAdmin} = this.props;
        return (
            <nav className={navcss.topnav} >
                <Link className={navcss.active} href="/" to="/">Auction</Link>
                {
                    loginStatus ? (<Link href="#" onClick={logoutAdmin}>Logout</Link>) : <Link href="/login" to="/login">Login</Link>
                }
                {loginStatus ? (<Link href="/register" to="/register">Register</Link>) : null}
                {loginStatus ? (<Link href="/dashboard" to="/dashboard">Dashboard</Link>) : null}
                {loginStatus ? (<Link href="/users" to="/users">Users</Link>) : null}

                {/* <FontAwesomeIcon icon={["fal", "coffee"]} /> */}
            </nav>
        )
    }
    
}
