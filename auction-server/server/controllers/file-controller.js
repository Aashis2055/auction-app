const postFile = (req, res, next)=>{
    console.log(req.body);
    console.log(req.files);
    const validFiles = ["image/jpeg", "image/png", "image/jpg"];
    if(!req.files || Object.keys(req.files) === 0){
        return res.status(400).json({ message: 'no file uploaded'});
    };// eof if no file uploaded
    let {mainFile} = req.files;
    // if file exceed file limit
    if(mainFile.truncated === true){
        return res.status(400).json({message: 'file size exceeds'});
    };
    // validate file type
    if(!validFiles.includes(mainFile.mimetype) ){
        return res.status(400).json({ message: 'file type not allowed'});
    };
    // change file name
    mainFile.name = `${Date.now()}-${mainFile.name}`;
    let filePath = `${appRoot}/public/vehicle-images/${mainFile.name}`;
    mainFile.mv(filePath, (err)=>{
        if(err) {
            console.log(err);
            return res.status(500).json({ message: 'file upload fail'});
        }
        req.userData.filePath = mainFile.name;
        next();
    })
}

module.exports = {
    postFile
}