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
                    users.map((user, index)=> <Link key={index} to={"/user/"+user._id}><UserCard user={user} index={index} /></Link> )
                }
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = ()=>{
        this.networkHelper.print();
    }
}

