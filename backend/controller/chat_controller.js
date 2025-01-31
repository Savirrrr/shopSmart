const childProcess = require('child_process');
const path=require('path')
exports.handleChat = async (req, res) => {
  const userMessage = req.body.message;

  if (!userMessage) {
    return res.status(400).json({ error: 'Message is required' });
  }

  // Spawn a child process to run the Python script
  // const pythonScriptPath = path.join(__dirname, "..", "..", "web_scraping", "app.py");
  const pythonPath = "/Users/savir/Projects/shopsmart/web_scraping/venv/bin/python3";

  const python = childProcess.spawn(pythonPath, ["/Users/savir/Projects/shopsmart/web_scraping/app.py",userMessage]);
  let responseMessage = '';

  // Capture the output from the Python script
  python.stdout.on('data', (data) => {
    responseMessage += data.toString();
  });

  // Handle errors
  python.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });

  // Send the bot's reply when the Python script finishes
  python.on('close', (code) => {
    if (code === 0) {
      console.log("------------->", responseMessage);
      res.json({ reply: responseMessage.trim() });
    } else {
      res.status(500).json({ error: 'Error occurred while processing the request.' });
    }
  });
};