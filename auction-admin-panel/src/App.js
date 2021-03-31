// import logo from './logo.svg';
// import './App.css';
import React, { Component } from 'react';
import {BrowserRouter, Switch, Route, Redirect} from 'react-router-dom';
import '@fortawesome/free-solid-svg-icons';
import '@fortawesome/fontawesome-svg-core';
import Dashboard from './pages/Dashboard';
import Home from './pages/Home';
import Login from './pages/Login';
import Register from './pages/Register'
import ErrorPage from './pages/ErrorPage';

// components
import NavBar from './components/NavBar';

export class App extends Component {
  constructor(){
    super();
    this.state = {
      loginStatus: false
    }
  }
  render() {
    let {loginStatus} = this.state;
    console.log(loginStatus);
    return (
      <BrowserRouter>
      <NavBar loginStatus={loginStatus} />
      <Switch >
        <Route exact path="/">
          <Home />
        </Route>
        <Route path="/login" >
        {
          loginStatus ? (<Redirect to="/dashboard" />) : <Login />
        }
        </Route>
        <Route path="/register">
          <Register />
        </Route>
        <Route path="/dashboard">
          {
            loginStatus ? <Dashboard /> : (<Redirect to="/login" />)
          }
        </Route>
        <Route path="*">
          <ErrorPage />
        </Route>
      </Switch>
      </BrowserRouter>
    )
  }
  
  
}

export default App



// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;
