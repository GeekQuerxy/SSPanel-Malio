/* 给 user 表增加 phone 字段 */
ALTER TABLE `user` ADD `phone` bigint(20) AFTER `email`;

/* 增加 短信验证码 表 */
CREATE TABLE IF NOT EXISTS `sms_verify` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phone` bigint(20) NOT NULL,
  `code` text NOT NULL,
  `ip` text NOT NULL,
  `expire_in` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
