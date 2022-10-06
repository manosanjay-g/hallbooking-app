const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    username: { type: String, required: true },
    name: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    dept: { type: String, required: true },
    job: { type: String, required: true },
    role: { type: String, required: true },
    token: { type: String },
    events: { type: Array, default: [] }
}, {
    timestamps: true
});

const userCollection = mongoose.model('user', userSchema, 'users')

module.exports = userCollection