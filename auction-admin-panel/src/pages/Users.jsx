import UserCard from '../components/UserCard';
import { ToastContainer} from 'react-toastify';
import React, { Component } from 'react'
import NetworkHelper from '../services/networkhelper';
import UserDetail from './UserDetail';
import'../css/users.css';
export default class Users extends Component {
    constructor(){
        super();
        this.networkHelper = new NetworkHelper();
        this.state = {
            users: [],
            userId: null
        }
    }
    render() {
        const {users} = this.state;
        console.log(users);
        return (
            <div className="user-page">
                <div className="user-list-container">
                {
                    users.map((user, index)=> <UserCard key={index} user={user} index={index} showDetails={this.showDetails} />)
                }
                </div>
                {
                    <UserDetail userId={this.state.userId}/>
                }
                <button className="btnFloating">F</button>
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = async ()=>{
        const users = await this.networkHelper.getUsers();
        this.setState({
            users,
            userId: null
        })
    }
    showDetails = async(id)=>{
        console.log(id);
        this.setState({
            ...this.state,
            userId: id
        })
    }
}

