const hallModel = require('../models/hall_model')
const getHalls = async (req, res) => {
    try {
        const halls = await hallModel.find({});
        res.status(200).json({
            halls: halls
        })
    } catch (err) {
        console.log(err);
    }
}

const getHall = async (req, res) => {
    try {
        const id = req.params.id
        const hall = await hallModel.findOne({ _id: id })
        res.status(200).json({
            hall: hall
        });
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    getHall,
    getHalls
}