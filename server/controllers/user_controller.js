const userModel = require('../models/user_model')
const getUserInfo = async (req, res) => {
    try {
        const username = req.params.id;
        if (!username) {
            res.status(400).json({
                error: "username is required to find the user"
            })
        }
        const user = await userModel.findOne({ username });
        if (user == null) {
            return res.status(400).json({
                error: "User does not exist"
            })
        } else {
            return res.status(200).json({
                user
            })
        }
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    getUserInfo
}