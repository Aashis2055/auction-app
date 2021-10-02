import React, { Component } from 'react';
import {BrowserRouter, Switch, Route, Redirect} from 'react-router-dom';
import '@fortawesome/free-solid-svg-icons';
import '@fortawesome/fontawesome-svg-core';
import {isLogedIn} from './helper/localstorage';
// screens
import Dashboard from './pages/Dashboard';
import Home from './pages/Home';
import Login from './pages/Login';
import Register from './pages/Register'
import ErrorPage from './pages/ErrorPage';
import Users from './pages/Users';
import Test from './pages/test';
import Specs from './pages/Specs';
import './css/style.css';

// components
import NavBar from './components/NavBar';
import Vehicle from './pages/Vehicle';
import UserDetail from './pages/UserDetail';

export class App extends Component {
  constructor(){
    super();
    this.state = {
      loginStatus: isLogedIn()
    }
  }
  render() {
    let {loginStatus} = this.state;
    return (
      <BrowserRouter>
      <NavBar loginStatus={loginStatus} logoutAdmin={this.logoutAdmin} />
      <Switch >
        <Route exact path="/">
          <Home />
        </Route>
        <Route path="/login" >
        {
          loginStatus ? (<Redirect to="/dashboard" />) : <Login loginAdmin={this.loginAdmin} />
        }
        </Route>
        <Route path="/register">
          {
            loginStatus ? <Register /> :(<Redirect to="/login"/>)
          }
        </Route>
        <Route path="/dashboard">
          {
            loginStatus ? <Dashboard /> : (<Redirect to="/login" />)
          }
        </Route>
        <Route path="/vehicle/:id" >
          {loginStatus ? <Vehicle /> : (<Redirect to="/login"/>)}
        </Route>
        <Route path="/users" component={loginStatus?Users:<Redirect to="/login"/>}/>
        <Route exact  path="/user/:id">
          { loginStatus ? <UserDetail /> : <Redirect to="/login" />}
        </Route>
        <Route path="/specs">
          <Specs />
        </Route>
        <Route path="/test/:theid">
          <Test />
        </Route>
        <Route path="*">
          <ErrorPage />
        </Route>
      </Switch>
      </BrowserRouter>
    )
  }
  loginAdmin = ()=>{
    this.setState({
      loginStatus: true
    })
  }
  logoutAdmin = ()=>{
    localStorage.clear();
    this.setState({
      loginStatus: false
    })
  }
}


export default App

