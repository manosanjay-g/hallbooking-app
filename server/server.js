const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config();

//Router Initialization
const authRouter = require('./routers/auth_route');
const adminRouter = require('./routers/admin_route');
const bookingRouter = require('./routers/booking_route');
const eventsRouter = require('./routers/events_route')
const hallsRouter = require('./routers/halls_route')
const userRouter = require('./routers/user_route.js')

//DB Initialization
const connectDB = require('./configs/database_config');

//Middleware Declaration
const { authenticateToken } = require('./middlewares/auth_middleware')

//Middleware Initialization
app.use(cors())
app.use(express.json());
app.use('/public', express.static('public'))

app.use('/book', bookingRouter)
app.use('/auth', authRouter)
app.use('/admin', authenticateToken, adminRouter)
app.use('/events', authenticateToken, eventsRouter)
app.use('/halls', authenticateToken, hallsRouter)
app.use('/users', authenticateToken, userRouter)
//Routes
app.get('/', authenticateToken, (req, res) => {
    const u = req.user;
    res.send(u);
})
//Express
const start = async () => {
    try {
        await connectDB(process.env.MONGODB_URI);
        app.listen(process.env.PORT, () => {
            console.log(`Server listening on PORT ${process.env.PORT}`);
        })
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

start()