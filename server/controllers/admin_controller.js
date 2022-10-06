const hallModel = require('../models/hall_model')
const eventModel = require('../models/event_model')
const userModel = require('../models/user_model');
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
//Hall Methods
const addHall = async (req, res) => {
    try {
        const reqFiles = [];
        const url = req.protocol + "://" + req.get('host');
        for (let index = 0; index < req.files.length; index++) {
            reqFiles.push(url + '/public/images/' + req.files[index].filename);
        }
        const { name, building, floor, capacity, description } = req.body;

        if (!(name && building && floor && capacity && description)) {
            return res.status(400).json({
                error: "All inputs are required"
            })
        }

        const oldHall = await hallModel.findOne({ name });

        if (oldHall) {
            return res.status(409).json({
                error: "Hall already exists"
            })
        }

        const hall = await hallModel.create({
            name,
            building,
            floor,
            capacity,
            description,
            images: reqFiles
        })

        res.status(201).json({
            hall_res: hall
        })

    } catch (err) {
        console.log(err);
    }
}
const updateHall = async (req, res) => {
    try {
        const reqFiles = [];
        const url = req.protocol + "://" + req.get('host');
        for (let index = 0; index < req.files.length; index++) {
            reqFiles.push(url + '/public/images/' + req.files[index].filename);
        }
        const id = req.params.id
        const { name, building, floor, capacity, description } = req.body;
        if (!(name && building && floor && capacity && description)) {
            return res.status(400).json({
                error: "All inputs are required"
            })
        }
        const hall = await hallModel.findByIdAndUpdate({ _id: id }, {
            name,
            building,
            floor,
            capacity,
            description,
            images: reqFiles
        })
        res.status(201).json({ res: hall })
    } catch (err) {
        console.log(err);
    }
}
const deleteHall = async (req, res) => {
    try {
        const id = req.params.id
        const deletedHall = await hallModel.deleteOne({ _id: id })
        const deletedEvents = await eventModel.deleteMany({ hall_id: id })
        res.status(204).json({ res: deletedHall })
    } catch (err) {
        console.log(err);
    }
}

//Event Methods
const addEvent = async (req, res) => {
    const { hallID, timeSlot, date, name, description, username } = req.body;
    const oldEvent = await eventModel.findOne({ hall_id: hallID, date: date, time_slot: timeSlot })
    if (oldEvent) {
        res.status(400).json({
            error: "Event already booked in the same date and timeslot for this venue"
        })
    } else {
        const event = await eventModel.create({
            name,
            description,
            date,
            time_slot: timeSlot,
            hall_id: hallID,
            user_id: username
        })
        res.status(201).json({
            event_res: event
        })
    }
}
const updateEvent = async (req, res) => {
    try {
        const id = req.params.id
        const { timeSlot, date, name, description } = req.body;
        const oldEvent = await eventModel.findOne({ hall_id: id, date: date, time_slot: timeSlot })
        if (oldEvent) {
            res.status(400).json({
                error: "Event already booked in the same date and timeslot for this venue"
            })
        } else {
            const event = await eventModel.findByIdAndUpdate({ _id: id }, {
                name,
                description,
                date,
                time_slot: timeSlot,

            })
            res.status(201).json({
                res: event
            })
        }

    } catch (err) {
        console.log(err);
    }
}
const deleteEvent = async (req, res) => {
    try {
        const id = req.params.id
        const deletedEvent = await eventModel.deleteOne({ _id: id })
        res.status(204).json(deletedEvent)
    } catch (err) {
        console.log(err);
    }
}

//User Methods
const readUsers = async (req, res) => {
    try {
        const users = await userModel.find({})
        return res.status(200).json({
            users: users
        })
    } catch (err) {

    }
}
const addUser = async (req, res) => {
    try {
        const { name, email, password, dept, job, role, username } = req.body;
        if (!(email && name && password && dept && job && role)) {
            return res.status(400).json({
                error: "All input are required"
            })
        }
        const oldUser = await userModel.findOne({ email });
        if (oldUser) {
            return res.status(409).json({
                error: "User already exists"
            })
        }

        encryptedPassword = await bcrypt.hash(password, 15);

        const user = await userModel.create({
            username,
            name,
            email: email.toLowerCase(),
            password: encryptedPassword,
            dept,
            job,
            role
        });

        const token = jwt.sign({
            user_id: user._id,
            email
        }, process.env.JWT_KEY);
        user.token = token;
        res.status(201).json({
            user_res: user,
        })
    } catch (err) {
        console.log(err);
    }
}
const updateUser = async (req, res) => {
    try {
        const id = req.params.id
        const { name, email, password, dept, job, role, username } = req.body;
        if (!(email && name && password && dept && job && role)) {
            return res.status(400).json({
                error: "All input are required"
            })
        }

        encryptedPassword = await bcrypt.hash(password, 15);

        const user = await userModel.findByIdAndUpdate({ _id: id }, {
            username,
            name,
            email: email.toLowerCase(),
            password: encryptedPassword,
            dept,
            job,
            role
        });

        const token = jwt.sign({
            user_id: user._id,
            email
        }, process.env.JWT_KEY);
        user.token = token;
        res.status(201).json({
            user_res: user,
        })
    } catch (err) {
        console.log(err);
    }
}
const deleteUser = async (req, res) => {
    try {
        const id = req.params.id
        const user = await userModel.findOne({ _id: id })
        const deletedUser = await userModel.deleteOne({ _id: id })
        const username = user.username;
        const deleteEvents = await eventModel.deleteMany({ user_id: username });
        res.status(204).json({ user: deletedUser, events: deleteEvents })
    } catch (err) {
        console.log(err);
    }
}
//Dangerous Methods - USE IT ONLY WHEN IT IS ABSOLUTELY NECESSARY
//WITH GREAT POWER COMES GREAT RESPONSIBILITY
const deleteHalls = async (req, res) => {
    try {
        const response = await hallModel.deleteMany({})
        res.status(204).json({
            deleted_halls: response
        })
    } catch (err) {
        console.log(err);
    }
}
const deleteEvents = async (req, res) => {
    try {
        const response = await eventModel.deleteMany({})
        res.status(204).json({
            deleted_events: response
        })
    } catch (err) {
        console.log(err);
    }
}
const deleteUsers = async (req, res) => {
    try {
        const response = await userModel.deleteMany({})
        res.status(204).json({
            deleted_users: response
        })
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    addHall,
    updateHall,
    deleteHall,
    addEvent,
    updateEvent,
    deleteEvent,
    readUsers,
    addUser,
    updateUser,
    deleteUser,
    deleteEvents,
    deleteHalls,
    deleteUsers
}