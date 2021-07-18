import React, { Component } from 'react';
import img1 from  '../images/bikes1.jpeg';
import img2 from  '../images/bikes2.jpeg';
import img3 from  '../images/bikes3.jpeg';
import img4 from  '../images/bikes4.jpeg';
import img5 from  '../images/cars1.jpg';
import img6 from  '../images/cars2.jpeg';
import img7 from  '../images/cars3.jpeg';
import img8 from  '../images/cars4.jpeg';
import  css from '../css/home.module.css';
export default class Home extends Component {
    render() {
        return (
            <div className={css.bodyContainer}>
                <div className={css.row}>
                    <div className={css.column}>
                        <img src={img1} alt="bike with red"/>
                        <img src={img2} alt="bike 2"/>
                        <img src={img3} alt=""/>
                    </div>
                    <div className={css.column}>
                        <img src={img4} alt=""/>
                        <img src={img5} alt=""/>
                        <img src={img6} alt=""/>
                    </div>
                    <div className={css.column}>
                        <img src={img7} alt=""/>
                        <img src={img8} alt=""/>
                        <img src={img1} alt=""/>
                    </div>
                </div>
                <div className={css.homeContainer}>
                    <h1>Vehicle Auction App</h1>
                    <p>A place where you can auction and bid on different cars and bikes</p>
                </div>
            </div>
        )
    }
}
