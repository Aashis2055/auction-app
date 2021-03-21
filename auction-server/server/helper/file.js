const fs = require('fs');

function deleteFile(path){
    // TODO validate file path and file type
    try {
        fs.unlinkSync(appRoot+path);
        return true;
    } catch (error) {
        //TODO log error
        return false;
    }
}

module.exports = deleteFile;