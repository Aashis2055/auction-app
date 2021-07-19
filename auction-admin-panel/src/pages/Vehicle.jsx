import React, {useEffect, useState} from 'react';
import {Link, useParams} from 'react-router-dom';
import CommentTile from '../components/CommentTile';
import NetworkHelper from '../services/networkhelper';
import {formatDate} from '../helper/dateFormater';

export default function Vehicle(props) {
    // const [post, setPost] = useState({
    //     added_date: "2021-03-20T11:40:25.021Z",
    //     auction_date: "2021-02-20T18:15:00.000Z",
    //     bid:{},
    //     price: 0,
    //     color: "blue",
    //     description: "this is the secound post",
    //     end_date: "2021-03-02T00:00:00.000Z",
    //     img: "image1.jpg",
    //     initial_price: 2500,
    //     km_driven: 125,
    //     model: "no-thing",
    //     type: "Bike",
    //     year: 2015,
    //     __v: 0,
    //     _id: "6055e0cab7b6c01bf9f6d159"
    // }, []);
    const [post, setPost] = useState(null, []);
    const [comments, setComments] = useState([]);
    const {id} = useParams();
    let networkhelper = new NetworkHelper();

    const deleteComment = async (index)=>{
        const status = await networkhelper.deleteComment(comments[index]._id);
        if(status){
            comments.splice(index, 1);
            setComments(comments);
        } 
    }
    const deleteReply = async (index)=>{
        const status = await networkhelper.deleteReply(comments[index]._id);
        if(status){
            comments[index].reply = undefined;
            setComments(comments);
        }
    }
    useEffect(()=>{
        networkhelper.getVehicle(id).then(({post, comments})=>{
            setPost(post);
            if(comments !== null || comments.lenght !== 0){
                setComments(comments);
            }
            console.log(comments !== null);
            console.log(comments.lenght !== 0)
        })
    },[]);
    return (
        post == null ?
        <div>Loading</div>:
        <div className="container">
            <div className="vehicle-detail">
                <img src={`http://localhost:5000/vehicle-images/${post.img}`} alt=""/>
                <table>
                    <tbody>
                    <tr>
                        <td>Price:</td>
                        <td>{post.price}</td>
                    </tr>
                    <tr>
                        <td>Color:</td>
                        <td>{post.color}</td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td>{post.description}</td>
                    </tr>
                    <tr>
                        <td>Initial Price:</td>
                        <td>{post.initial_price}</td>
                    </tr>
                    <tr>
                        <td>KM Driven:</td>
                        <td>{post.km_driven}</td>
                    </tr>
                    <tr>
                        <td>Year:</td>
                        <td>{post.year}</td>
                    </tr>
                    <tr>
                        <td>Model</td>
                        <td>{post.model}</td>
                    </tr>
                    <tr>
                        <td>Type:</td>
                        <td>{post.type}</td>
                    </tr>
                    <tr>
                        <td>Model:</td>
                        <td>{post.model}</td>
                    </tr>
                    <tr>
                        <td>Posted Date:</td>
                        <td>{formatDate( post.added_date)}</td>
                    </tr>
                    <tr>
                        <td>Auction Date:</td>
                        <td>{formatDate(post.auction_date) }</td>
                    </tr>
                    <tr>
                        <td>End Date:</td>
                        <td>{formatDate(post.end_date) }</td>
                    </tr>
                    <tr>
                        <td>Bid</td>
                        { post.bid == null? <td>Currently No bid</td> : <td>{post.bid}</td>}
                    </tr>
                    <tr>
                        <Link to={"/user/"+post.u_id}>User</Link>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div className="comment-container">
                {
                    comments === null ? 
                    <span>No comments to show</span> : 
                    comments.map((comment, index)=> <CommentTile delete={{deleteComment, deleteReply}} key={index} comment={comment} index={index}  />)
                }
            </div>
        </div>
    )
    
}
