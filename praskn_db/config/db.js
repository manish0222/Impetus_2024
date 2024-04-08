const mongoose=require('mongoose');

const connection=
mongoose.createConnection('mongodb://127.0.0.1:27017/psknUser').on('open',()=>{
    console.log("Mongo Connected");
}).on('error',()=>{
    console.log("error");
});
// localhost:27017 gives error
// use 127.0.0.1
module.exports=connection;