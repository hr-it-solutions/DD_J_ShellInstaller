INSERT INTO `#__users` (
	`id`, `name`, `username`, `email`, `password`, `block`,
	`sendEmail`, `registerDate`, `lastvisitDate`, `activation`,
	`params`, `lastResetTime`, `resetCount`, `otpKey`, `otep`, `requireReset`
	) VALUES (
		'1',
		'SuperUser',
		'admin',
		'email@domain.tld',
		MD5('adminpwd'), '0', '0', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000',
		'', '', '0000-00-00 00:00:00.000000',	'0', '', '', '0'
	);
INSERT INTO `#__user_usergroup_map` (
	`user_id`, `group_id`
	) VALUES (
		'1', '8'
	);