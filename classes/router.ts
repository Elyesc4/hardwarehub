import express from "express";
import Router from 'express'
import path from "path";
import expressLayouts from "express-ejs-layouts";

const router = Router();

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

import HomeController from '../controllers/homecontroller';
import CartController from '../controllers/cartcontroller';
import ProductController from '../controllers/productcontroller';

// import * from '../controllers/';

//todo @ebr make action in controlelr
//todo @ebr make routes dynamic by pattern and make url params avalable for actions
//routs

//home

router.get('/', HomeController.index);

//cart

router.post('/cart', CartController.index);
router.post('/addToCart/:id', CartController.add);
router.post('/removeFromCart', CartController.remove);

//product

router.post('/product/:id', ProductController.index);
router.post('/checkout/:id', ProductController.index);

// Export the router
module.exports = router;