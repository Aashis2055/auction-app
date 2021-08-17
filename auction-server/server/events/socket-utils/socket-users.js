const jwt = require('jsonwebtoken');
const users = [];

function userJoin(token, v_id, s_id){
    const USER_KEY = process.env.USER_KEY;
    let decode = jwt.verify(token, USER_KEY);
    const user = {decode, v_id, s_id};
    users.push(user);
    return user;
}
function getCurrentUser(id){
    return users.find(user => user.decode._id === id);
}
function getUserBySocketId(id){
    return users.find(user => user.s_id === id);
}
function userLeaves(s_id){
    const index = user.findIndex(user => user.decode._id === id);

    if(index !== -1){
        let user = getUserBySocketId(id);
        user.splice(index, 1)[0];
    }
}

module.exports = {
    userJoin,
    getCurrentUser,
    userLeaves,
    getUserBySocketId
}