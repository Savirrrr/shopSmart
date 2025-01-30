const express=require('express');

const funcroute=require('./routes/function_route');
const { start } = require('repl');

const app=express();

app.use(express.json());

async function startServer() {
    try{
    app.use('/api/function',funcroute);
    port=3000
    app.listen(port,()=>{
        console.log(`Server running on port ${port}`);
        
    });}
    catch(error){
        console.error(error);
        console.log(error);
        
    }
}

startServer();