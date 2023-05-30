import Database from '../classes/database';

const db: Database = new Database();

class Model1 {

    tblname: string = '';

    getAll = async () => {
        return await db.getAll(this.tblname)
    }

    count = async () => {
        return await db.count(this.tblname)
    }
    
}

export default Model1;