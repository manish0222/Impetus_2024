const UserModel = require('../model/user.model');
const TestModel = require('../model/test.model');
const jwt=require('jsonwebtoken');
class UserService{
static async registerUser(email, password){
    const createUser = new UserModel({email, password});
        return await createUser.save();
    }catch(err) {   
        throw err
    }

    static async inserttest(email, score,name) {
        try {
            let user = await this.checkuser(email);
            if(!user) {
                throw new Error('User does not exist');
            } else {
                if(email) {
                    await TestModel.findOneAndUpdate({email},{score,name},{upsert:true});
                } else {
                    await TestModel.insertMany({email, score,name});
                }
            }
        } catch (err) {
            throw err;
        }
    }


    static async checkuser(email){
        try{
            return await UserModel.findOne({email});
        }
        catch(err){
            throw err;
        }
    }

    static async generateToken(tokendata,secretKey,jwt_expire){
        return jwt.sign(tokendata,secretKey,{expiresIn:jwt_expire});
    }
}

module.exports = UserService;