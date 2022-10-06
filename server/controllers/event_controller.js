const eventModel = require('../models/event_model')
const getEvents = async (req, res) => {
    try {
        const events = await eventModel.find({}).sort({ date: 'asc' })
        res.status(200).json({
            events: events
        })
    } catch (err) {
        console.log(err);
    }
}

const getEvent = async (req, res) => {
    try {
        const id = req.params.id;
        const event = await eventModel.find({ _id: id })
        res.status(200).json({
            event: event
        })
    } catch (err) {
        console.log(err);
    }
}
const getEventsByHall = async (req, res) => {
    try {
        const hall_id = req.params.id
        const events = await eventModel.find({ hall_id: hall_id })
        res.status(200).json({
            events: events
        })
    } catch (err) {
        console.log(err);
    }
}
const getEventsByUser = async (req, res) => {
    try {
        const user_id = req.params.id
        const events = await eventModel.find({ user_id: user_id })
        res.status(200).json({
            events: events
        })
    } catch (err) {
        console.log(err);
    }
}
const updateEvent = async (req, res) => {
    try {
        const reqFiles = [];
        const url = req.protocol + "://" + req.get('host');
        for (let index = 0; index < req.files.length; index++) {
            reqFiles.push(url + '/public/images/' + req.files[index].filename);
        }

        const id = req.params.id
        const { hallID, timeSlot, date, name, description, capacity } = req.body;
        const oldEvent = await eventModel.findOne({ hall_id: hallID, date: date, time_slot: { $in: timeSlot } })
        if (oldEvent && oldEvent._id != id) {
            res.status(400).json({
                error: "Event already booked in the same date and timeslot for this venue"
            })
        } else {
            const event = await eventModel.findByIdAndUpdate({ _id: id }, {
                name,
                description,
                date,
                time_slot: timeSlot,
                images: reqFiles,
                capacity
            })
            res.status(201).json({
                res: event
            })
        }

    } catch (err) {
        console.log(err);
    }
}
module.exports = {
    getEvent,
    getEvents,
    getEventsByHall,
    getEventsByUser,
    updateEvent,
}