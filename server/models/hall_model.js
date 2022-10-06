const mongoose = require('mongoose')

const hallSchema = mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    building: { type: String, required: true },
    floor: { type: String, required: true },
    capacity: { type: String, required: true },
    images: { type: Array, default: null },
    timeSlotBooked: { type: Array, default: [] }
}, {
    timestamps: true
})

const hallCollection = mongoose.model('hall', hallSchema, 'halls')

module.exports = hallCollection