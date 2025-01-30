const forLookFunction = async (req, res) => {
    const { message } = req.body; 
    console.log("Received search query:", message);

    res.status(200).json({ success: true, message: "Received: " + message }); 
};

module.exports={forLookFunction};