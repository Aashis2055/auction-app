import React from 'react';
import { Link } from 'react-router-dom';
const URL = 'http://localhost:5000/vehicle-images';
export default function Card(props) {
    let {_id, type, year, img} = props.post;
    const myStyle = {
        height: "200px",
        width: "200px"
    }
    return (
        <div>
            <Link  to={`vehicle/${_id}`}>
            <img style={myStyle} src={`${URL}/${img}`} alt=""/>
            <div>{`Type: ${type}, Year:${year}`}</div>
            </Link>
            <div onClick={deletePost}>Delete</div>
        </div>
    )
    function deletePost(){
        props.delete(props.index);
    }
}
