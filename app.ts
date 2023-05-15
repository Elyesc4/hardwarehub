import express, { Request, Response, Application } from 'express';
import expressLayouts from 'express-ejs-layouts';
import fs from 'fs';
import formData from 'express-form-data';
import Database from './classes/database';
import path from 'path';

require('dotenv').config();

const app: Application = express();
const port: number = 3000;

const pathPublic: string = path.join(__dirname, 'public');
const pathViews: string = path.join(pathPublic, 'views');
const pathLayouts: string = path.join(pathViews, 'layouts');
const pathPartials: string = path.join(pathViews, 'partials');

const db: Database = new Database();

db.getAll('customers');

app.use(formData.parse({}));
app.use(express.static('public'));
app.use('/css', express.static(path.join(pathPublic, 'css')));
app.use('/js', express.static(path.join(pathPublic, 'js')));
app.use('/img', express.static(path.join(pathPublic, 'img')));

app.use(expressLayouts);
app.set('layout', path.join(pathLayouts, 'default'));
app.set('views', pathViews);
app.set('view engine', 'ejs');

app.get('/', (req: Request, res: Response) => {
    res.render('index', {
        title: 'Hub Start'
    });
});

app.listen(port, () => {
    console.log(`app listening on port ${port}`);
});