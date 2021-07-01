import UserCard from '../components/UserCard';
import { ToastContainer} from 'react-toastify';
import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import NetworkHelper from '../services/networkhelper';
export default class Users extends Component {
    constructor(){
        super();
        this.networkHelper = new NetworkHelper();
        this.state = {users: []}}
    render() {
        const {users} = this.state;
        return (
            <div>
                {
                    users.map((user, index)=> <UserCard key={index} user={user} index={index} />)
                }
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = async ()=>{
        const users = await this.networkHelper.getUsers();
        this.setState({
            users
        })
    }
}

