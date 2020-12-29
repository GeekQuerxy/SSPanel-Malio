/* 给 code 表增加 tradeno 字段，防止重复到账 */
ALTER TABLE `code` ADD COLUMN `tradeno` varchar(255) NULL;
ALTER TABLE `code` ADD UNIQUE (`tradeno`);