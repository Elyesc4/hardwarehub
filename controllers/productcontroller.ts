import { Request, Response } from 'express';
import BaseController from './basecontroller';

class ProductController extends BaseController {

    static async index(req: Request, res: Response): Promise<void> {
        let id = req.params.id
    
        db.exQuery(
            `SELECT * FROM products WHERE id = ${id}`
        ).then((product) => {
    
            res.render('product', {
                styles: 'product',
                title: 'Hub Product',
                action: 'product',
                product: product.length === 1 ? product[0] : product,
            });
        }, (err) => {
            console.log(err)
            res.redirect('/')
        })
    }

    static async checkout(req: Request, res: Response): Promise<void> {
        res.redirect('/cart')
    }

}

export default ProductController;