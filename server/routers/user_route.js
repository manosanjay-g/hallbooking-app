const express = require('express')
const router = express.Router()
const { getUserInfo } = require('../controllers/user_controller')
router.get('/:id', getUserInfo)

module.exports = router