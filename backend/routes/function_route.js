const express=require('express');
const {forLookFunction}=require('../controller/function_controller');


const router= express.Router();

router.post('/forwardfunction',async (req,res)=>{
    forLookFunction(req,res);
});

module.exports=router;