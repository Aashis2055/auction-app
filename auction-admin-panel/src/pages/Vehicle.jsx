import axios from 'axios';
import React, {useEffect, useState} from 'react';
import {useParams} from 'react-router-dom';
import {getToken} from '../helper/localstorage';
const URL = 'http://localhost:5000/';
export default function Vehicle(props) {
    const [post, setPost] = useState({
        added_date: "2021-03-20T11:40:25.021Z",
        auction_date: "2021-02-20T18:15:00.000Z",
        bid:{},
        price: 0,
        color: "blue",
        description: "this is the secound post",
        end_date: "2021-03-02T00:00:00.000Z",
        img: "image1.jpg",
        initial_price: 2500,
        km_driven: 125,
        model: "no-thing",
        type: "Bike",
        year: 2015,
        __v: 0,
        _id: "6055e0cab7b6c01bf9f6d159"
    });
    const [count, setCount] = useState(0);
    const {id} = useParams();
    useEffect(()=>{
        axios.get(`${URL}admin-api/vehicle/${id}`,{
            headers:{
                authorization: getToken()
            }
        }).then((response)=>{
            console.log('this is the post',response.data.post);
            let {post:value} = response.data;
            setPost(value);
        }).catch((error)=>{
            console.log(error);
        })
    }, [])
    return (
        <div>
            The vehicle page {post.type}
        </div>
    )
    
}
