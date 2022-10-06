const mongoose = require('mongoose')

const eventSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String },
    date: { type: String, required: true },
    time_slot: { type: Array, required: true },
    images: { type: Array, default: null },
    hall_id: { type: String, required: true },
    user_id: { type: String, required: true },
    user_dept: { type: String, required: true },
    user_job: { type: String, required: true },
    capacity: { type: String, required: true }
}, {
    timestamps: true
});

const eventCollection = mongoose.model('event', eventSchema, 'events')

module.exports = eventCollection