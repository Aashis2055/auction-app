import React from 'react';
import { Link } from 'react-router-dom';
const URL = "http://localhost:5000/profile-image/"
export default function UserCard(props) {
    let {_id, first_name, last_name, img, status, phone_no} = props.user;
    return (
        <div className="user-card">
            <img src={`${URL+img}`} alt="" srcset="" />
            <div>FirstName: {first_name}</div>
            <div>LastName: {last_name}</div>
            <div>Phone No {phone_no}</div>
            {
                status ? <div className="deactive">Deactive</div> : <div className="active">Active </div>
            }
            <Link to={"user/"+_id}><button>More INFO</button></Link>
        </div>
    )
}
