import express, { Request, Response, Application } from 'express';
import expressLayouts from 'express-ejs-layouts';
import fs from 'fs';
import formData from 'express-form-data';
import Database from './classes/database';
// import Customer from './models/customer';
import path from 'path';

require('dotenv').config();

const app: Application = express();
const port: number = 3000;

const pathPublic: string = path.join(__dirname, 'public');
const pathViews: string = path.join(pathPublic, 'views');
const pathLayouts: string = path.join(pathViews, 'layouts');
const pathPartials: string = path.join(pathViews, 'partials');


app.use(formData.parse({}));
app.use(express.static('public'));
app.use('/css', express.static(path.join(pathPublic, 'css')));
app.use('/js', express.static(path.join(pathPublic, 'js')));
app.use('/img', express.static(path.join(pathPublic, 'img')));

app.use(expressLayouts);
app.set('layout', path.join(pathLayouts, 'default'));
app.set('views', pathViews);
app.set('view engine', 'ejs');

// const customer: Customer = new Customer();

// customer.getAll().then((result) => {
//     console.log(result);
// })

// customer.count().then((count) => {
//     console.log(count);
// })
const db: Database = new Database();

const user = 1;
const cart: Array<any> = [];

app.get('/', (req: Request, res: Response) => {

    db.exQuery(
        `SELECT p.*, IFNULL(pim.img_path, '') AS img_path
        FROM products p
        LEFT JOIN product_imgs pim ON p.id = pim.product_id AND pim.img_oder = 0
        ORDER BY p.id;`
    ).then((produckts) => {
        
        res.render('index', {
            styles: 'index',
            title: 'Hub Start',
            produckts: produckts
        });        
    })
});

app.get('/cart', (req: Request, res: Response) => {
    
    db.exQuery(
        `SELECT p.*
        FROM products p
        JOIN order_products op ON p.id = op.product_id
        JOIN orders o ON op.order_id = o.id
        WHERE o.customer_id = ${user}
        AND o.status_id = 'inCart';`
    ).then((inCart) => {
        res.render('cart', {
            styles: 'cart',
            title: 'Hub Cart',
            inCart: inCart
        });
    })
});

app.get('/product/:id', (req: Request, res: Response) => {
    let id = req.params.id
    
    db.exQuery(
        `SELECT * FROM products WHERE id = ${id}`
    ).then((product) => {
        
        res.render('product', {
            styles: 'product',
            title: 'Hub Product',
            product: product.length === 1 ? product[0] : product,
        });     
    })
});

app.post('/addToCart/:id', (req: Request, res: Response) => {
    let id = req.params.id
    
    cart.push(id);
    res.redirect(`/product/${id}`)
});

app.listen(port, () => {
    console.log(`app listening on port ${port}`);
});