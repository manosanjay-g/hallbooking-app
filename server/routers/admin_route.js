const express = require('express')
const router = express.Router();
const { upload } = require('../middlewares/image_adding_middleware')
const { addHall, updateEvent, updateHall, deleteHalls, deleteEvents, deleteUsers, addEvent, deleteHall, deleteUser, updateUser, addUser, readUsers, deleteEvent } = require('../controllers/admin_controller')

//Event Related Routes
router.post('/add/events/', addEvent);
router.post('/manage/events/:id', updateEvent);
router.delete('/delete/events/:id', deleteEvent)

//Hall Related Routes
router.post('/add/halls/', upload.array('images', 10), addHall)
router.post('/manage/halls/:id', upload.array('images', 10), updateHall)
router.delete('/delete/halls/:id', deleteHall)

//User Related Routes
router.get('/read/users/', readUsers)
router.post('/add/users/', addUser)
router.post('/manage/users/:id', updateUser)
router.delete('/delete/users/:id', deleteUser)

//Dangerous Routes - USE IT ONLY WHEN IT IS ABSOLUTELY NECESSARY
router.post('/delete/halls', deleteHalls)
router.post('/delete/events', deleteEvents)
router.post('/delete/users', deleteUsers)

module.exports = router