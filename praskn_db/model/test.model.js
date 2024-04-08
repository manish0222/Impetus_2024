const mongoose = require ('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;
const testSchema = new Schema({
email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true
},
score: {
    type: String,
    required :true
},
name:{
    type:String,
    required:true
}
}, {timestamps:true});

const TestModel = db.model('testscores', testSchema);
module.exports = TestModel;