require('dotenv').config();
const mariadb = require('mariadb');

class Database {

    constructor () {

    }

    async getConn() {
        await mariadb.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PWD,
            database: process.env.DB,
            port: process.env.DB_PORT
        });
    }

    getAll = (table: String) => {
        
    }
}

export default Database;