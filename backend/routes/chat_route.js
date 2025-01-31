const express = require('express');
const router = express.Router();
const { handleChat } = require('../controller/chat_controller');


router.post('/', handleChat);

module.exports = router;