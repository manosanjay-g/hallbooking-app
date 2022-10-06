const eventModel = require('../models/event_model')

const bookHallForEvent = async (req, res) => {
    try {
        const reqFiles = [];
        const url = req.protocol + "://" + req.get('host');
        for (let index = 0; index < req.files.length; index++) {
            reqFiles.push(url + '/public/images/' + req.files[index].filename);
        }

        const { hallID, timeSlot, date, name, description, username, capacity, dept, job } = req.body;
        const oldEvent = await eventModel.findOne({ hall_id: hallID, date: date, time_slot: { $in: timeSlot } })
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
                user_id: username,
                user_dept: dept,
                user_job: job,
                images: reqFiles,
                capacity
            })
            res.status(201).json({
                event_res: event
            })
        }
    } catch (err) {
        console.log(err);
    }

}

module.exports = {
    bookHallForEvent
}

