import React from 'react';
import { Link, Redirect } from 'react-router-dom';
import css from '../css/dashboard.module.css';
const URL = 'http://localhost:5000/vehicle-images';
export default function Card(props) {
    let {_id, type, year, img} = props.post;
    return (
        <div className={css.card}>
            <Link  to={`vehicle/${_id}`}>
            <img  src={`${URL}/${img}`} alt=""/>
            <div>{`Type: ${type}, Year:${year}`}</div>
            </Link>
            <div className={css.cardFooter}>
                <button className={ css.btndelete} onClick={deletePost}>Delete</button>
                <button className={css.btn} ><Link href={"/user/"+_id}>User</Link></button>
            </div>
        </div>
    )
    function deletePost(){
        props.delete(props.index);
    }
}
