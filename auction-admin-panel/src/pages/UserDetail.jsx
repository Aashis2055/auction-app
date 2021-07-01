import React, { Component } from 'react'
import { withRouter } from 'react-router';
import NetworkHelper from '../services/networkhelper';
 class UserDetail extends Component {
    constructor(props){
        super(props);
        this.networkHelper = new NetworkHelper();
        this.state = {user:null};
    }
    render() {
        const user = this.user;
        console.log(user);
        return (
            user === null?
            <div>Loading ...</div> :
            <div>
                <div className="info">
                    {/* <div>Name: {this.user.first_name + this.user.last_name}</div> */}
                    {/* <div>Created At: {user.created_at}</div>
                    <div>Email: {user.email}</div>
                    <div>PhoneNo: {user.phone_no}</div>
                    {
                        user.status? <div className="inactive">Inactive</div> : <div className="satus active">Active</div>
                    } */}
                </div> 
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
}
export default withRouter(UserDetail);


 // <div>Hi there {this.props.match.params.theid}</div>

