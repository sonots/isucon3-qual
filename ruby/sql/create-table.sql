create table memos (
`id` int(11) NOT NULL AUTO_INCREMENT,
`user` int(11) NOT NULL,
`content` text,
`is_private` tinyint(4) NOT NULL DEFAULT '0',
`created_at` datetime NOT NULL,
`updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`),
KEY `user_create_at_index` (`user`,`created_at`),
KEY `user_is_private_created_at_index` (`user`,`is_private`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE users (
`id` int(11) NOT NULL AUTO_INCREMENT,
`username` varchar(255) NOT NULL,
`password` varchar(255) NOT NULL,
`salt` varchar(255) NOT NULL,
`last_access` datetime DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `users_username_idx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

