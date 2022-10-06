const express = require('express')
const router = express.Router()
const { upload } = require('../middlewares/image_adding_middleware')
const { getEvent, getEvents, getEventsByHall, updateEvent, getEventsByUser } = require('../controllers/event_controller')

router.get('/', getEvents);
router.get('/:id', getEvent);
router.get('/hall/:id', getEventsByHall)
router.get('/user/:id', getEventsByUser)
router.post('/manage/:id', upload.array('images', 10), updateEvent);
module.exports = router