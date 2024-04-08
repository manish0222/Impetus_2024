const mongoose = require ('mongoose');
const db = require('../config/db');
const bcrypt=require('bcrypt');
const { Schema } = mongoose;
const userSchema = new Schema({
email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true
},
password: {
    type: String,
    required :true
}
});
userSchema.pre('save',async function(){
    try{
        var user=this;
        const salt=await(bcrypt.genSalt(10));
        const hashpass=await bcrypt.hash(user.password,salt);
        user.password=hashpass;
    }
    catch(error){
        throw error;
    }
});

//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.password);
        // @ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};

const UserModel = db.model('user', userSchema);
module.exports = UserModel;