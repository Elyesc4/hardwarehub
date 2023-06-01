DELIMITER $$

USE `hardware_hub`$$

DROP PROCEDURE IF EXISTS `add_product_to_cart`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product_to_cart`(IN product INT, IN customer INT)
BEGIN
    DECLARE order_id INT;
    DECLARE product_count INT;

    -- Überprüfen, ob der Benutzer bereits eine offene Bestellung hat
    SELECT id INTO order_id
    FROM orders
    WHERE customer_id = customer AND status_id = 'inCart';

    IF order_id IS NULL THEN
        -- Keine offene Bestellung vorhanden, eine neue Bestellung erstellen
        INSERT INTO orders (customer_id, status_id, payment_status_id, insert_ts, update_ts)
        VALUES (customer, 'inCart', 'pending', NOW(), NULL);

        SET order_id = LAST_INSERT_ID();
    END IF;

    -- Überprüfen, ob das Produkt bereits in der Bestellung vorhanden ist
    SET product_count = (
        SELECT COUNT(*)
        FROM order_products
        WHERE order_id = order_id AND product_id = product
    );

    IF product_count = 0 THEN
        -- Das Produkt ist noch nicht in der Bestellung, Produkt zur Bestellungsprodukte-Tabelle hinzufügen
        INSERT INTO order_products (order_id, product_id, pieces, insert_ts, update_ts)
        VALUES (order_id, product, 1, NOW(), NOW());
    ELSE
        -- Das Produkt ist bereits in der Bestellung, die Anzahl der Pieces erhöhen
        UPDATE order_products
        SET pieces = pieces + 1, update_ts = NOW()
        WHERE order_id = order_id AND product_id = product;
    END IF;

END$$
