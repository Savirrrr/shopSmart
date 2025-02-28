const express=require('express');


const funcroute=require('./routes/function_route');
const chatroutes=require('./routes/chat_route')
const { start } = require('repl');

const app=express();

app.use(express.json());

async function startServer() {
    try{
    app.use('/api/function',funcroute);
    app.use('/chat',chatroutes)
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