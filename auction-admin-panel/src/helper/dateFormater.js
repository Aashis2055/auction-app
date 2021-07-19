function formatDate(date){
    let dateObj = new Date(date);
    const year = dateObj.getFullYear();
    let month = dateObj.getMonth()+1;
    let dt = dateObj.getDate();

    if (dt < 10) {
    dt = '0' + dt;
    }
    if (month < 10) {
    month = '0' + month;
    }
    return `${year}/${month}/${dt}`;
}

module.exports = {
    formatDate
}