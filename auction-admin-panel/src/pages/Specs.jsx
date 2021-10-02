import React, { Component } from 'react'
import NetworkHelper from '../services/networkhelper';
export default class Specs extends Component {
    constructor(){
        super();
        this.state = {
            model:null, brand:null, price:null, type:"Bike", mielage:null, engine:null
        }
        this.networkHelper = new NetworkHelper();
    }
    render() {
        let {model, brand, price, type, mielage, engine} = this.state;
        return (
            <div className="Container">
                <form>
                    <div>
                        <label htmlFor="type">Type</label>
                        <select name="type" id="" value={type}>
                            <option value="Bike">Bike</option>
                            <option value="Car">Car</option>
                            <option value=""></option>
                        </select>
                    </div>
                    <div>
                        <label htmlFor="brand">Brand</label>
                        <input type="text" placeholder="Enter Brand" value={brand} onChange={this.changeHandler} />
                    </div>
                    <div>
                        <label htmlFor="model">Model</label>
                        <input type="text" placeholder="Enter Model" value={model} onChange={this.changeHandler}/>
                    </div>
                    <div>
                        <label htmlFor="price">Current Price</label>
                        <input type="number" onChange={this.changeHandler} value={price}/>
                    </div>
                    <div>
                        <label htmlFor="mielage">Mielage</label>
                        <input type="number" placeholder="Enter Mielage" value={mielage} onChange={this.changeHandler} />
                    </div>
                    <div>
                        <label htmlFor="engine">Engine Displacement</label>
                        <input type="number" placeholder="Enter Engine" value={engine} onChange={this.changeHandler}/>
                    </div>
                    <div>
                        <input style={{background: "#445", cursor: "pointer"}} type="submit" onClick={this.submitHandler} value="Add"/>
                    </div>
                </form>
            </div>
        )
    }
    onChangeHandler = (event)=>{
        this.setState({
            [event.target.name]:event.target.value
        })
    }
    submitHandler = (event)=>{
        event.preventDefault();
        let {type, mielage, brand, model, price, engine} = this.state;
        this.networkHelper.addSpecification(type, mielage, brand, model, price, engine);
    }
}
