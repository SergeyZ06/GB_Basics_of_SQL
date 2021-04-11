-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `SergeyZ06`@`%` 
    SQL SECURITY DEFINER
VIEW `shop`.`2th task` AS
    SELECT 
        `p`.`name` AS `product_name`, `c`.`name` AS `catalog_name`
    FROM
        (`shop`.`products` `p`
        JOIN `shop`.`catalogs` `c` ON ((`c`.`id` = `p`.`catalog_id`)))
