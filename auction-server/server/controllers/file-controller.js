const postFile = (req, res, next)=>{
    const validFiles = ["image/jpeg", "image/png"];
    if(!req.files || Object.keys(req.files) === 0){
        return res.status(400).json({ message: 'no file uploaded'});
    };// eof if no file uploaded
    let {mainFile} = req.files;
    // if file exceed file limit
    if(mainFile.truncated === true){
        return res.status(400).json({message: 'file size exceeds'});
    };
    // validate file type
    if(validFiles.includes(mainFile.mimetype) ){
        return res.status(400).json({ message: 'file type not allowed'});
    };
    // change file name
    mainFile.name = `${Date.now()}-${mainFile.name}`;
    appRoot = __dirname;
    let filePath = `${appRoot}/public/images/${mainFile.name}`;
    mainFile.mv(filePath, (err)=>{
        if(err) 
            return res.status(500).json({ message: 'file upload fail'});
        req.userDate.filePath = filePath;
        next();
    })
}