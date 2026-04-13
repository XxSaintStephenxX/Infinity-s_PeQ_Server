DROP TABLE IF EXISTS `bot_data`;

CREATE TABLE `bot_data` (
  `bot_id` int unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int unsigned NOT NULL DEFAULT '0',
  `spells_id` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `last_name` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(32) NOT NULL DEFAULT '',
  `suffix` varchar(32) NOT NULL DEFAULT '',
  `zone_id` int unsigned NOT NULL DEFAULT '0',
  `gender` tinyint unsigned NOT NULL DEFAULT '0',
  `race` smallint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `level` tinyint unsigned NOT NULL DEFAULT '1',
  `deity` smallint unsigned NOT NULL DEFAULT '0',
  `creation_day` int unsigned NOT NULL DEFAULT '0',
  `last_spawn` int unsigned NOT NULL DEFAULT '0',
  `time_spawned` int unsigned NOT NULL DEFAULT '0',

  `size` float NOT NULL DEFAULT '6',
  `face` tinyint unsigned NOT NULL DEFAULT '1',
  `hair_color` tinyint unsigned NOT NULL DEFAULT '1',
  `hair_style` tinyint unsigned NOT NULL DEFAULT '1',
  `beard` tinyint unsigned NOT NULL DEFAULT '0',
  `beard_color` tinyint unsigned NOT NULL DEFAULT '1',
  `eye_color_1` tinyint unsigned NOT NULL DEFAULT '1',
  `eye_color_2` tinyint unsigned NOT NULL DEFAULT '1',
  `drakkin_heritage` tinyint unsigned NOT NULL DEFAULT '0',
  `drakkin_tattoo` tinyint unsigned NOT NULL DEFAULT '0',
  `drakkin_details` tinyint unsigned NOT NULL DEFAULT '0',

  `ac` int NOT NULL DEFAULT '0',
  `atk` int NOT NULL DEFAULT '0',
  `hp` int NOT NULL DEFAULT '0',
  `mana` int NOT NULL DEFAULT '0',

  `str` int NOT NULL DEFAULT '75',
  `sta` int NOT NULL DEFAULT '75',
  `cha` int NOT NULL DEFAULT '75',
  `dex` int NOT NULL DEFAULT '75',
  `int` int NOT NULL DEFAULT '75',
  `agi` int NOT NULL DEFAULT '75',
  `wis` int NOT NULL DEFAULT '75',

  `extra_haste` int NOT NULL DEFAULT '0',

  `fire` int NOT NULL DEFAULT '25',
  `cold` int NOT NULL DEFAULT '25',
  `magic` int NOT NULL DEFAULT '25',
  `poison` int NOT NULL DEFAULT '15',
  `disease` int NOT NULL DEFAULT '15',
  `corruption` int NOT NULL DEFAULT '0',

  `expansion_bitmask` int NOT NULL DEFAULT '0',

  `heroic_str` int NOT NULL DEFAULT '0',
  `heroic_sta` int NOT NULL DEFAULT '0',
  `heroic_cha` int NOT NULL DEFAULT '0',
  `heroic_dex` int NOT NULL DEFAULT '0',
  `heroic_int` int NOT NULL DEFAULT '0',
  `heroic_agi` int NOT NULL DEFAULT '0',
  `heroic_wis` int NOT NULL DEFAULT '0',

  `heroic_res_fire` int NOT NULL DEFAULT '0',
  `heroic_res_cold` int NOT NULL DEFAULT '0',
  `heroic_res_magic` int NOT NULL DEFAULT '0',
  `heroic_res_poison` int NOT NULL DEFAULT '0',
  `heroic_res_disease` int NOT NULL DEFAULT '0',
  `heroic_res_corruption` int NOT NULL DEFAULT '0',

  PRIMARY KEY (`bot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `bot_timers`;
CREATE TABLE `bot_timers` (
  `bot_id` int(11) unsigned NOT NULL,
  `timer_id` int(11) unsigned NOT NULL,
  `timer_value` int(11) unsigned NOT NULL DEFAULT 0,
  `recast_time` int(11) unsigned NOT NULL DEFAULT 0,
  `is_spell` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `is_disc` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `spell_id` int(11) unsigned NOT NULL DEFAULT 0,
  `is_item` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `item_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`bot_id`, `timer_id`)
);

DROP TABLE IF EXISTS `bot_groups`;
CREATE TABLE `bot_groups` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) unsigned NOT NULL DEFAULT 0,
  `group_name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bot_group_members`;
CREATE TABLE `bot_group_members` (
  `group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `bot_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`, `bot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bot_heal_rotation`;
CREATE TABLE `bot_heal_rotation` (
  `rotation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) unsigned NOT NULL DEFAULT 0,
  `interval` int(11) unsigned NOT NULL DEFAULT 0,
  `fast_heals` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `adaptive_targeting` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `casting_override` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `safe_hp_base` float unsigned NOT NULL DEFAULT 0,
  `safe_hp_cloth` float unsigned NOT NULL DEFAULT 0,
  `safe_hp_leather` float unsigned NOT NULL DEFAULT 0,
  `safe_hp_chain` float unsigned NOT NULL DEFAULT 0,
  `safe_hp_plate` float unsigned NOT NULL DEFAULT 0,
  `critical_hp_base` float unsigned NOT NULL DEFAULT 0,
  `critical_hp_cloth` float unsigned NOT NULL DEFAULT 0,
  `critical_hp_leather` float unsigned NOT NULL DEFAULT 0,
  `critical_hp_chain` float unsigned NOT NULL DEFAULT 0,
  `critical_hp_plate` float unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`rotation_id`)
);

DROP TABLE IF EXISTS `bot_heal_rotation_members`;
CREATE TABLE `bot_heal_rotation_members` (
  `rotation_id` int(11) unsigned NOT NULL,
  `bot_id` int(11) unsigned NOT NULL,
  `position` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`rotation_id`, `bot_id`)
);

DROP TABLE IF EXISTS `bot_heal_rotation_targets`;
CREATE TABLE `bot_heal_rotation_targets` (
  `rotation_id` int(11) unsigned NOT NULL,
  `target_name` varchar(64) NOT NULL DEFAULT '',
  `position` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`rotation_id`, `target_name`)
);

DROP TABLE IF EXISTS `bot_stances`;