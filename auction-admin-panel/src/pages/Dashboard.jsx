import axios from 'axios';
import React, { Component } from 'react';
import Card from '../components/Card';
import {ToastContainer} from 'react-toastify';
import NetworkHelper from '../services/networkhelper';
import css from '../css/dashboard.module.css';
export default class Dashboard extends Component {
    constructor(){
        super();
        this.networkHelper = new NetworkHelper();
        this.state = {
            posts:[]
        }
    }
    render() {
        let {posts} = this.state;
        return (
            <div className={css.cardGrid}>
                {
                    posts.map((post, index)=>{
                        return <Card key={index} post={post} index={index} delete={this.removePost} />
                    })
                }
                <button className="btnFloating">F</button>
                <ToastContainer />
            </div>
        )
    }
    componentDidMount = async ()=>{
       const posts = await this.networkHelper.getVehicles();
       this.setState({
           posts
       })
    }
    removePost = (index)=>{
        const {posts} = this.state;
        this.networkHelper.deletePost(posts[index]._id)
        .then(()=>{
            posts.splice(index, 1);
            this.setState({
                posts
            })
        })
    }
}
