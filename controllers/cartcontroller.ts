import { Request, Response } from 'express';
import BaseController from './basecontroller';

//todo @ebr user musst come from session (make usermodel singelton)

class CartController extends BaseController {

    static calcCartPrice = (inCart): number => {
        let cartPrice = 0
        inCart.forEach((item) => {
            cartPrice += parseFloat(item.price_netto)
        })
        return Number(cartPrice.toFixed(2))
    }

    static async index(req: Request, res: Response): Promise<void> {

        db.exQuery(
            `SELECT p.*, op.pieces
            FROM products p
            JOIN order_products op ON p.id = op.product_id
            JOIN orders o ON op.order_id = o.id
            WHERE o.customer_id = ${1}
            AND o.status_id = 'inCart';`
        ).then((inCart) => {

            res.render('cart', {
                styles: 'cart',
                title: 'Hub Cart',
                action: 'cart',
                inCart: inCart,
                cartPrice: this.calcCartPrice(inCart)
            });
        })
    }

    static async add(req: Request, res: Response): Promise<void> {
        let id = req.params.id

        db.exQuery(
            `CALL add_product_to_cart(${id}, ${user})`
        ).then((product) => {
            res.redirect(`/product/${id}`)
        })
    }

    static async remove(req: Request, res: Response): Promise<void> {
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
    }

}

export default CartController;