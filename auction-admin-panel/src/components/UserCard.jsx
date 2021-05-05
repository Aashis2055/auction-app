import React from 'react';

export default function UserCard(props) {
    let {_id, firstName, lastName} = props.user;
    return (
        <div key={props.index.toString()}>
            FirstName: {firstName}
            LastName: {lastName}
        </div>
    )
}
