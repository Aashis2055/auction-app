import React from 'react';
import { Link } from 'react-router-dom';
const URL = "http://localhost:5000/";

export default function Card(props) {
    let {_id, type, year, img} = props.post;
    return (
        <Link key={_id} to={`vehicle/${_id}`}>
            <img src={`${URL}`} alt=""/>
            <div>{`Type: ${type}, Year:${year}`}</div>
        </Link>
    )
}
