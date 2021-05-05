import React from 'react';
import { Link } from 'react-router-dom';
const URL = "http://localhost:5000/";

export default function Card(props) {
    let {_id, type, year, img} = props.post;
    const myStyle = {
        height: "200px",
        width: "200px"
    }
    return (
        <div>
            <Link key={props.index} to={`vehicle/${_id}`}>
            <img style={myStyle} src={`${URL}/vehicle-images/1617863857950-gallery3.jpg`} alt=""/>
            <div>{`Type: ${type}, Year:${year}`}</div>
            </Link>
            <div onClick={deletePost}>Delete</div>
        </div>
    )
    function deletePost(){
        props.delete(props.index);
    }
}
