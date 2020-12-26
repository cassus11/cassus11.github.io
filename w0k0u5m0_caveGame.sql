-- drop table if currently exists
DROP TABLE IF EXISTS `completion`;

-- create table
CREATE TABLE `completion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(24) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `matchedWith` INT(11) NOT NULL,
  `didKill` TINYINT(1) NOT NULL,
  `firstAskedQuestion` TINYINT(1) NOT NULL,
  `secondAskedQuestion` TINYINT(1) NOT NULL,
  `thirdAskedQuestion` TINYINT(1) NOT NULL,
  `response1` VARCHAR(126) NOT NULL,
  `response2` VARCHAR(126) NOT NULL,
  `response3` VARCHAR(126) NOT NULL,
  `hasEmailed` TINYINT(1) NOT NULL,
  `DATE` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- insert default values (first player)
INSERT INTO `completion` (
  `name`, `email`, `matchedWith`, `didKill`, `firstAskedQuestion`, `secondAskedQuestion`, `thirdAskedQuestion`, `response1`, `response2`, `response3`, `hasEmailed`, `DATE`
) VALUES ('Chris', 'chris@cjohnson.id.au', 0, false, 1, 2, 3, 'Answer 1', 'Answer 2', 'Answer 3', 0, CURRENT_TIMESTAMP()); 

-- drop procedures
DROP PROCEDURE IF EXISTS get_completion_count;
DROP PROCEDURE IF EXISTS get_player_to_pair;
DROP PROCEDURE IF EXISTS get_book_names;
DROP PROCEDURE IF EXISTS get_previous_by_id;
DROP PROCEDURE IF EXISTS insert_completion;
DROP PROCEDURE IF EXISTS get_all_ids;

-- create procedures
DELIMITER //

CREATE PROCEDURE get_completion_count()
BEGIN
	SELECT COUNT(*) num_players FROM `completion`;
END //

CREATE PROCEDURE get_player_to_pair()
BEGIN
	SELECT `id`, `name`, `response1`, `response2`, `response3`, `hasEmailed` FROM `completion` WHERE `id` NOT IN (SELECT `matchedWith` FROM `completion`) AND `hasEmailed` = 0;
END //

CREATE PROCEDURE get_book_names()
BEGIN
	SELECT `name` FROM `completion` ORDER BY `DATE` DESC LIMIT 0,4;
END //

CREATE PROCEDURE get_previous_by_id(IN in_id INT(11))
BEGIN
	SELECT `id`, `name`, `response1`, `response2`, `response3` FROM `completion` WHERE `id` = in_id;
END //

CREATE PROCEDURE insert_completion(IN in_name VARCHAR(24), IN in_email VARCHAR(120), IN in_matchedWith INT(11), IN in_didKill TINYINT(1),
								   IN in_firstAskedQuestion TINYINT(1),  IN in_secondAskedQuestion TINYINT(1), IN in_thirdAskedQuestion TINYINT(1),
								   IN in_response1 VARCHAR(126), IN in_response2 VARCHAR(126), IN in_response3 VARCHAR(126), IN in_hasEmailed TINYINT(1))
BEGIN
	INSERT INTO `completion` (
      `name`, `email`, `matchedWith`, `didKill`, `firstAskedQuestion`, `secondAskedQuestion`, `thirdAskedQuestion`, `response1`, `response2`, `response3`, `hasEmailed`
    ) VALUES (in_name, in_email, in_matchedWith, in_didKill, in_firstAskedQuestion, in_secondAskedQuestion, in_thirdAskedQuestion,
			  in_response1, in_response2, in_response3, in_hasEmailed); 

END //

CREATE PROCEDURE get_all_ids()
BEGIN
	SELECT id FROM `completion`;
END //

DELIMITER ;
