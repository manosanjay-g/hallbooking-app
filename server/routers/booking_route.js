const express = require('express');
const router = express.Router();

const { upload } = require('../middlewares/image_adding_middleware')
const { bookHallForEvent } = require('../controllers/booking_controller')


router.post('/events', upload.array('images', 10), bookHallForEvent)

module.exports = router