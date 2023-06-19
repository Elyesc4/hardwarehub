import express from "express";
import Router from 'express'
import multer from "multer";
import path from "path";
import expressLayouts from "express-ejs-layouts";

import HomeController from '../controllers/homecontroller';
import CartController from '../controllers/cartcontroller';

const router = Router();

const storage = multer.diskStorage({
    destination: 'temp/',
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
        const extension = path.extname(file.originalname);
        cb(null, file.fieldname + '-' + uniqueSuffix + extension);
    },
});

const pathPublic: string = path.join(__dirname, '..', 'public');
const pathViews: string = path.join(pathPublic, 'views');
const pathLayouts: string = path.join(pathViews, 'layouts');
const pathPartials: string = path.join(pathViews, 'partials');

router.use(express.static('public'));
router.use('/css', express.static(path.join(pathPublic, 'css')));
router.use('/js', express.static(path.join(pathPublic, 'js')));
router.use('/img', express.static(path.join(pathPublic, 'img')));

router.use(expressLayouts);
router.set('layout', path.join(pathLayouts, 'default'));
router.set('views', pathViews);
router.set('view engine', 'ejs');

const upload = multer({storage});

//routs

router.get('/', HomeController.index);

router.post('/cart', CartController.index);
router.post('/addToCart/:id', CartController.add);

//todo @ebr make action in controlelr

app.get('/product/:id', (req: Request, res: Response) => );

app.post('/checkout/:id', (req: Request, res: Response) => {
    res.redirect('/cart')
});

app.post('/addToCart/:id', (req: Request, res: Response) => {
    let id = req.params.id

    db.exQuery(
        `CALL add_product_to_cart(${id}, ${user})`
    ).then((product) => {
        res.redirect(`/product/${id}`)
    })
});

app.post('/removeFromCart', (req: Request, res: Response) => {
    console.log(req.body)
    let sql
    switch (req.body.action) {
        case 'delete':
            sql = ``
            break;
    }
    res.send(req.body.action)
    // db.exQuery(sql).then((result) => {
    //     res.status(200)
    // })
});


// Export the router
module.exports = router;