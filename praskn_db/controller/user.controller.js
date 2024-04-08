const UserService = require('../services/user.services');
exports.register = async(req,res, next)=>{
    try{
        const {email,password}=req.body;
        const successRes = await UserService.registerUser(email,password);
        res.json({status:true,success:"User Registered"});
    }
    catch (error){
        throw error
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserService.checkuser(email);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }
        // Creating Token
        let tokenData;
        tokenData = { _id: user._id, email: user.email };
    
        const token = await UserService.generateToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.test = async (req, res, next) => {
    try {
        const {email, score,name} = req.body;
        if(!email || !score || !name) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserService.checkuser(email);
        if(!user) {
            throw new Error('User does not exist');
        } else {
            await UserService.inserttest(email, score,name);
            res.status(200).json({status:true});
        }
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}