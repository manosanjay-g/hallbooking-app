const express = require('express')
const router = express.Router()

const { getHall, getHalls } = require('../controllers/hall_controller')

router.get('/', getHalls)
router.get('/:id', getHall)

module.exports = router