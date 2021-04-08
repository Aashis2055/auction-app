const KEY = 'token'
const isLogedIn = function(){
    let token = localStorage.getItem(KEY);
    return token ? true : false;
}
const getToken = function(){
    if(!isLogedIn()) return null;
    let token = localStorage.getItem(KEY);
    return token;
}
const setToken = function(token){
    localStorage.setItem(KEY,token);
}
module.exports=  {
    isLogedIn,
    getToken,
    setToken
}