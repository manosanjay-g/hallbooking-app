const userModel = require('../models/user_model')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')

const register = async (req, res) => {
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

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!(email && password)) {
            res.status(400).json({
                error: "All inputs are required"
            })
        }
        const user = await userModel.findOne({ email });
        if (user == null) {
            return res.status(400).json({
                error: "User does not exist"
            })
        }
    
        const decryptedPassword = await bcrypt.compare(password, user.password);
        if (user && decryptedPassword) {
            const token = jwt.sign({
                user_id: user._id,
                email
            }, process.env.JWT_KEY)
            user.token = token;
            return res.status(200).json({
                token: user.token,
                username: user.username
            });
        }
        res.status(400).json({
            error: "Invalid Credentials"
        })
    } catch (err) {
        console.log(err);
    }
}

module.exports = {
    register,
    login
}