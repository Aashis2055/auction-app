import React, { Component } from 'react'
import NetworkHelper from '../services/networkhelper';
export default class UserDetail extends Component {
    constructor(){
        super();
        this.networkHelper = new NetworkHelper();
        this.state = {};
    }
    render() {
        return (
            <div>
                The user detail page
            </div>
        )
    }
    componentDidMount = ()=>{
        this.networkHelper.print();
    }
}
