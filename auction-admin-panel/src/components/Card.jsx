import React from 'react';
import { useState, useEffect } from 'react';
const URL = "http://localhost:5000/"


export default function Card(props) {
    let {firstName, lastName, img} = props.post;
    return (
        <div>
            <img src={`${URL}`} alt=""/>
            <div>Name: {`${firstName+lastName}`}</div>
        </div>
    )
}
