import {Request, Response} from 'express';
import BaseController from './basecontroller';

class HomeController extends BaseController {
    static async index(req: Request, res: Response): Promise<void> {

        db.exQuery(
            `SELECT p.*, IFNULL(pim.img_path, '') AS img_path
            FROM products p
            LEFT JOIN product_imgs pim ON p.id = pim.product_id AND pim.img_oder = 0
            ORDER BY p.id;`
        ).then((produckts) => {
    
            res.render('index', {
                styles: 'index',
                title: 'Hub Start',
                action: 'start',
                produckts: produckts
            });
        })
    }

}

export default HomeController;