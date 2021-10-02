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
    deleteComment = async(id)=>{
        try{
            const response = await axios.delete(`${this.URL}/comment/${id}`, this.header);
            console.log(response);
            if(response.status == 200) return true;
            else return false;
        }catch(error){
            this.showError(error);
            return false;
        }
    }
    deleteReply = async(id)=>{
        try{
            const response = await axios.delete(`${this.URL}/reply/${id}`, this.header);
            
            if(response.status == 200) return true;
            else return false;
        }catch(error){
            this.showError(error);
            return false;
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
    addSpecification = async(type, mielage=null, brand, model, price, engine)=>{
        axios.post(`${this.URL}/vehiclespecs`, {
            type,
            mielage,
            engine_displacement: engine,
            price,
            brand,
            model
        }, this.header)
        .then((response)=>{
            return true;
        })
        .catch((error)=>{
            return false;
        })
    }
    showError = (error)=>{
        console.log(error);
        if(error.response) toast.error(error.response.msg);
        else if(error.request) toast.error('check your internet connection');
        else toast.error('Some thing went wrong');
    }
    
}


module.exports = NetworkHelper;