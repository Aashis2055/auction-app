import React, { Component } from 'react';
import Card from '../components/Card';
import {withRouter} from 'react-router-dom';
import {ToastContainer} from 'react-toastify';
import NetworkHelper from '../services/networkhelper';
import css from '../css/dashboard.module.css';
class Dashboard extends Component {
    constructor(){
        super();
        this.networkHelper = new NetworkHelper();
        this.allPosts = [];
        this.currentDate = new Date();
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
        this.allPosts = await this.networkHelper.getVehicles();
        // change the auction date and end date to date obj
        this.allPosts.forEach(function(element, index, elements){
            elements[index].auction_date = new Date(element.auction_date);
            elements[index].end_date = new Date(element.end_date);
        });
        let newId = this.props.location.search;
        console.log(newId);
        this.filterData(newId);
    }
    componentDidUpdate = async(prevProps)=>{
        let oldId = prevProps.location.search;
        let newId = this.props.location.search;
        if(oldId !== newId){
            this.filterData(newId);
        }
    }
    filterData=(search)=>{
        const select = new URLSearchParams(search).get("select");
        console.log(select);
        let posts = [];
        if(select === 'active'){
            console.log('show active');
            posts = this.allPosts.filter((element)=>{
                if(element.auction_date < this.currentDate && this.currentDate < element.end_date ){
                    return true;
                }else{
                    return false;
                }
            });
        }else if(select === 'upcoming'){
            console.log('upcoming');
            posts = this.allPosts.filter((element)=> this.currentDate < element.auction_date);
        }else if(select === 'end'){
            posts = this.allPosts.filter((element)=> this.currentDate > element.end_date);
        }
        else{
            posts = this.allPosts;
        }
        this.setState({
            posts
        });
        
        
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
export default withRouter(Dashboard);

