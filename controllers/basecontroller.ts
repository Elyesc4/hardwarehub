// controllers/HomeController.js
const User = require('../models/User');

class BaseController {

    static async index(req, res) {
        try {
            const user = await User.findById(1); // Example: retrieving user from the database
            res.render('index', { message: `Hello, ${user.name}!` });
        } catch (error) {
            console.error('Error: ', error);
            res.status(500).send('An error occurred');
        }
    }
}

export default BaseController;