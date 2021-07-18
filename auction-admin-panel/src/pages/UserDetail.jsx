import React, { Component } from 'react'
import { withRouter } from 'react-router';
import { toast, ToastContainer } from 'react-toastify';
import NetworkHelper from '../services/networkhelper';
const URL = "http://localhost:5000/profile-image/"
const inLinecss = {
    active:{
        backgroundColor: "green"
    },
    inactive:{
        backgroundColor: "red"
    }
}
 class UserDetail extends Component {
    constructor(props){
        super(props);
        this.networkHelper = new NetworkHelper();
        this.state = {user:null};
    }
    render() {
        const user = this.state.user;
        console.log(user);
        return (
            user === null?
            <div>Loading ...</div> :
            <div>
                <div className="info">
                    <img src={`${URL+user.img}`} alt="" srcSet="" />
                    <div>Name: {user.first_name + user.last_name}</div>
                    <div>Created At: {user.created_at}</div>
                    <div>Email: {user.email}</div>
                    <div>Address: {user.address.province+"   "+user.address.district}</div>
                    <div>PhoneNo: {user.phone_no}</div>
                    <div>Status: 
                    {
                        user.status? <span className={inLinecss.inactive}>Inactive</span> : <span className={inLinecss.active}>Active</span>
                    }
                    </div>
                    
                </div> 
                <div className="control">
                    {
                        user.status? <button onClick={this.updateUser}>Remove Ban</button> : <button onClick={this.updateUser}>Ban User</button>
                    }
                </div>
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = async ()=>{
        const {id} = this.props.match.params;
        const user = await this.networkHelper.getUser(id);
        console.log(user);
        this.setState({
            user:user
        })
    }
    updateUser = ()=>{
        const user = this.state.user;
        const {status, _id} = user;
        this.networkHelper.updateUser(!status, _id).then(()=>{
            this.setState({
                user:{
                    ...user,
                    status: !status
                }
            })
        }).catch(error=>{
            
        })
    }
}
export default withRouter(UserDetail);


 // <div>Hi there {this.props.match.params.theid}</div>

