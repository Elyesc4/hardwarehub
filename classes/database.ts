
import mysql from 'mysql';
class DB {

    connection
    constructor() {
        this.connection = mysql.createConnection({
            host: 'localhost', //todo @ebr make .env
            user: 'your_mysql_username', //todo @ebr make .env
            password: 'your_mysql_password', //todo @ebr make .env
            database: 'your_database_name' //todo @ebr make .env
        });

        this.connection.connect((err) => {
            if (err) {
                console.error('Error connecting to the database: ', err);
                return;
            }
            console.log('Connected to the database');
        });
    }

}

module.exports = DB;