import { Request, Response } from 'express';

class ProductController extends BaseController {

    static async index(req: Request, res: Response): Promise<void> {
    }

    static async getProduct(req: Request, res: Response): Promise<void> {
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

}

export default ProductController;