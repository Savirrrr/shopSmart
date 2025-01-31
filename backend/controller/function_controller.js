const childProcess = require("child_process");
const path = require("path");

const forLookFunction = async (req, res) => {
    const { message } = req.body;
    console.log("Received search queries:", message);

    const pythonScriptPath = path.join(__dirname, "..", "..", "web_scraping", "scrape_product.py");
    const pythonVenvPath = path.join(__dirname, "..", "..", "web_scraping", "venv", "bin", "python3");
    
    try {
        const final = childProcess.spawn(pythonVenvPath, [pythonScriptPath, message], {
            env: {
                ...process.env,
                PYTHONPATH: path.join(__dirname, "..", "..", "web_scraping", "venv", "lib", "python3.11", "site-packages"),
                PYTHONUNBUFFERED: '1'
            },
            stdio: ['pipe', 'pipe', 'pipe']
        });

        let stdout = '';
        let stderr = '';

        final.stdout.on('data', (data) => {
            stdout += data.toString();
        });

        final.stderr.on('data', (data) => {
            stderr += data.toString();
            console.error('Python Error:', data.toString());
        });

        final.on('error', (error) => {
            console.error('Failed to start Python process:', error);
            res.status(500).json({ success: false, error: 'Failed to start Python process' });
        });

        final.on('close', (code) => {
            if (code !== 0) {
                console.error(`Python process exited with code ${code}`);
                console.error('STDERR:', stderr);
                return res.status(500).json({ 
                    success: false, 
                    error: `Python process failed`,
                    stderr: stderr
                });
            }

            try {
                // Trim and remove any leading/trailing whitespace
                const cleanedOutput = stdout.trim().replace(/^\s*[\r\n]+/gm, '');
                const parsedOutput = JSON.parse(cleanedOutput);
                console.log(parsedOutput);
                res.status(200).json({ success: true, message: parsedOutput });
            } catch (error) {
                console.error('Error parsing Python output:', error);
                console.error('Raw output:', stdout);
                res.status(500).json({ 
                    success: false, 
                    error: 'Failed to parse Python output',
                    rawOutput: stdout
                });
            }
            
            
        });
    } catch (error) {
        console.error('Unexpected error:', error);
        res.status(500).json({ success: false, error: 'Unexpected server error' });
    }
};
module.exports={forLookFunction}