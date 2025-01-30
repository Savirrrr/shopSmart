const childProcess = require('child_process');
const path = require('path');

const forLookFunction = async (req, res) => {
    const { message } = req.body;
    console.log("Received search query:", message);
    // const pythonScriptPath = path.join(__dirname, '..', '..', 'web_scraping', 'app.py');

    // const pythonProcess = childProcess.spawn('python3', [pythonScriptPath, message]);

    // let output = "";

    // pythonProcess.stdout.on('data', (data) => {
    //     output += data.toString();
    // });

    // pythonProcess.stderr.on('data', (data) => {
    //     console.error("Python Error:", data.toString());
    // });

    // pythonProcess.on('close', (code) => {
    //     console.log(`output after running python code ${output}`);
        
    //     console.log(`Python process exited with code ${code}`);
    //     res.status(200).json({ success: true, processed_message: output.trim() });
    // });
    // const pythonScriptPath=path.join(__dirname,'..','..','NLP','retreive_reviews.py');
    // const pythonInterpreter = path.join(__dirname, '..', '..', 'NLP', 'myenv', 'bin', 'python3');
    // const pythonProcess=childProcess.spawn(pythonInterpreter,[pythonScriptPath,message]);

    // let output=""
    // pythonProcess.stdout.on('data',(data)=>{
    //     output+=data.toString();
    // });

    // pythonProcess.stderr.on('data', (data) => {
    //     console.error("Python Error:", data.toString());
    // });

    // pythonProcess.on('close',(code)=>{
    //     console.log(`output after running python code ${output}`);
    //     console.log(`Python process exited with code ${code}`);
    //     res.status(200).json({ success: true, processed_message: output.trim() });
    // });
    const { messages } = req.body;
    console.log("Received search queries:", messages);

    const pythonScriptPath = path.join(__dirname, '..', '..', 'NLP', 'retreive_reviews.py');
    const pythonInterpreter = path.join(__dirname, '..', '..', 'NLP', 'myenv', 'bin', 'python3');

    const pythonProcess = childProcess.spawn(pythonInterpreter, [pythonScriptPath, JSON.stringify(messages)]);

    let output = "";

    pythonProcess.stdout.on('data', (data) => {
        output += data.toString();
    });

    pythonProcess.stderr.on('data', (data) => {
        console.error("Python Error:", data.toString());
    });

    pythonProcess.on('close', (code) => {
        console.log(`Output after running Python code: ${output}`);
        console.log(`Python process exited with code ${code}`);
        res.status(200).json({ success: true, percentage: JSON.parse(output.trim()) });
    });
};

module.exports = { forLookFunction };