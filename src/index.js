const express=require('express')
const {PORT}=require("./config/serverConfig")
 const setupAndStartTheServer=async()=>{
    const app=express()
    app.listen(PORT,()=>{
        console.log(`server started at PORT:  ${PORT}`)
    })

 }
setupAndStartTheServer()