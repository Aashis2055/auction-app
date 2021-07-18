const  {getToken} = require('../helper/localstorage');
const axios = require('axios');
const {toast} = require('react-toastify');
class NetworkHelper{
    constructor(){
        this.URL = "http://localhost:5000/admin-api";
        this.header = {
            headers:{
                authorization: getToken(),
            }
        };
    }
    getData = async (url)=>{
        try {
            return  await axios.get(url, this.header);
        } catch (error) {this.showError(error);}
    }
    getVehicles = async ()=>{
        try {
            let response = await axios.get(`${this.URL}/vehicle`, this.header);            
            return response.data.posts
        } catch (error) {
            this.showError(error);
            throw error;
        } 
    }
    getVehicle = async(id)=>{
        try{
            let response = await axios.get(`${this.URL}/vehicle/${id}`, this.header);
            return response.data;
        }catch(error){
            this.showError(error);
        }
    }
    getUsers = async()=>{
        try {
            const response = await axios.get(`${this.URL}/users`, this.header)
            return response.data.users;
        } catch (error) {
            this.showError(error);
        }        
    }
    getUser = async(id)=>{
        try {
            const response = await axios.get(`${this.URL}/user/${id}`, this.header)
            return response.data.user;
        } catch (error) {
            this.showError(error)   ;
        }
    }
    deletePost = async(id)=>{
        try {
            console.log(this.header);
            const response = await axios.delete(`${this.URL}/vehicle/${id}`, this.header);
            return response;
        } catch (error) {
            this.showError(error);
            throw error;
        }
    }
    updateUser = async(status, id)=>{
        try{
            const response = await axios.put(`${this.URL}/user/${id}`,{status}, this.header);
            return response;
        }catch(error){
            this.showError(error);
            throw error;
        }
    }
    showError = (error)=>{
        console.log(error);
        if(error.response) toast.error(error.response.msg);
        else if(error.request) toast.error('check your internet connection');
        else toast.error('Some thing went wrong');
    }
    
}
// eslint-disable-next-line
class NetworkHelper2{
    constructor(){
        this.URL = "http://localhost:5000/admin-api";
        this.header = {
            headers:{
                authorization: getToken(),
            }
        };
    }

    getVehicles = ()=>{
        axios.get(`${this.URL}/vehicle`, {
            headers:{
                authorization: getToken()
            }
        }).then((response)=>{
            const {posts} = response.data;
            console.log(posts);
            return posts;
        }).catch(error =>{
            this.showError(error);
        });
    }
    getVehicle = (id)=>{
        axios.get(`${this.URL}/vehicle/${id}`,)
        .then((response)=>{
            console.log(response);
            return response;
        }).catch((error)=>{
            this.showError(error);
        })
    }
    getUsers = ()=>{
        axios.get(`${this.URL}/users`, this.header)
        .then((response)=>{
            let {users} = response.data;
            return users;
        })
        .catch(this.showError)
    }
    getUser = (id)=>{
        axios.get(`${this.URL}/user/${id}`, this.header)
        .then((response)=>{
            return response;
        }).catch(error=> this.showError(error));
    }
    deletePost = (index)=>{
        let {_id} = this.state.posts[index];
        
        axios.delete(this.URL+"vehicle/"+_id, {
            headers: getToken()
        }).then((response)=>{
            if(response.status === 200){
                this.state.posts.splice(index-1, 1);
                this.setState({
                    posts: this.state.posts
                })
            }
        }).catch(error=> this.showError(error));
    }
    showError = (error)=>{
        console.log(error);
        if(error.response) toast.error(error.response.msg);
        else if(error.request) toast.error('check your internet connection');
        else toast.error('Some thing went wrong');
    }
    print = ()=>{
        console.log('console');
    }
}

module.exports = NetworkHelper;