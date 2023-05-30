require('dotenv').config();
const mariadb = require('mariadb');

class Database {

    constructor() {

    }

    exQuery = async (sql: String) => {
        const conn = await this.getConn()
        //todo implement type safety

        try {
            const result = await conn.query(sql, [2])
            return result;
        } finally {
            conn.end();
        }
    }

    getConn = async () => {

        return mariadb.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PWD,
            database: process.env.DB,
            port: process.env.DB_PORT
        });
    }

    getAll = async (table: String) => {
        let sql = `SELECT * FROM ${table};`;
        return this.exQuery(sql)
    }

    getWehre = async (table: String, where: String, cols: Array<String> | String = '*') => {
        let col_string = Array.isArray(cols) ? '`' + cols.join('`, `') + '`' : cols;
        let sql = `SELECT ${col_string} FROM ${table} WHERE ${where};`;

        return await this.exQuery(sql);
    }

    count = async (table: String) => {
        let sql = `SELECT COUNT(*) FROM ${table};`;
        let result = await this.exQuery(sql);
        
        return parseInt(result[0]['COUNT(*)']);
    }
}

export default Database;