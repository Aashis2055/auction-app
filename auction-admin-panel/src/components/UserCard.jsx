import React from 'react';
const URL = "http://localhost:5000/profile-image/"
export default function UserCard(props) {
    let {_id, first_name, last_name, img, status, phone_no} = props.user;
    function showDetails(){
        props.showDetails(_id);
    }
    return (
        <div className="user-card">
            <img src={`https://avatars.dicebear.com/api/initials/${first_name}-${last_name}.svg`} alt="" srcset="" />
            <div className="user-card-info">
                <div>FirstName: {first_name}</div>
                <div>LastName: {last_name}</div>
                <div>Phone No {phone_no}</div>
                {
                status ? <div className="deactive">Deactive</div> : <div className="active">Active </div>
                }
            </div>
            <button className="user-card-action" onClick={showDetails}>More INFO</button>
        </div>
    )
    
}
