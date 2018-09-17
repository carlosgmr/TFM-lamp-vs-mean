-- -----------------------------------------------------
-- Table `administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `administrator` ;

CREATE TABLE IF NOT EXISTS `administrator` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(256) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `surname_1` VARCHAR(64) NOT NULL,
  `surname_2` VARCHAR(64) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instructor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instructor` ;

CREATE TABLE IF NOT EXISTS `instructor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(256) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `surname_1` VARCHAR(64) NOT NULL,
  `surname_2` VARCHAR(64) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(256) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `surname_1` VARCHAR(64) NOT NULL,
  `surname_2` VARCHAR(64) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE TABLE IF NOT EXISTS `group` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NOT NULL,
  `description` VARCHAR(256) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instructor_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instructor_group` ;

CREATE TABLE IF NOT EXISTS `instructor_group` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `instructor` INT(10) UNSIGNED NOT NULL,
  `group` INT(10) UNSIGNED NOT NULL,
  `added_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_instructor_group_1_idx` (`instructor` ASC),
  INDEX `fk_instructor_group_2_idx` (`group` ASC),
  UNIQUE INDEX `unique_instructor_group` (`instructor` ASC, `group` ASC),
  CONSTRAINT `fk_instructor_group_1`
    FOREIGN KEY (`instructor`)
    REFERENCES `instructor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instructor_group_2`
    FOREIGN KEY (`group`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_group` ;

CREATE TABLE IF NOT EXISTS `user_group` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` INT(10) UNSIGNED NOT NULL,
  `group` INT(10) UNSIGNED NOT NULL,
  `added_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_user_group_1_idx` (`user` ASC),
  INDEX `fk_user_group_2_idx` (`group` ASC),
  UNIQUE INDEX `unique_user_group` (`user` ASC, `group` ASC),
  CONSTRAINT `fk_user_group_1`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_2`
    FOREIGN KEY (`group`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `questionary_model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `questionary_model` ;

CREATE TABLE IF NOT EXISTS `questionary_model` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `description` VARCHAR(256) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `questionary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `questionary` ;

CREATE TABLE IF NOT EXISTS `questionary` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group` INT(10) UNSIGNED NOT NULL,
  `title` VARCHAR(256) NOT NULL,
  `description` TEXT NULL,
  `model` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `public` TINYINT(1) NOT NULL DEFAULT 0,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_questionary_1_idx` (`group` ASC),
  INDEX `fk_questionary_2_idx` (`model` ASC),
  CONSTRAINT `fk_questionary_1`
    FOREIGN KEY (`group`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionary_2`
    FOREIGN KEY (`model`)
    REFERENCES `questionary_model` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `question_model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `question_model` ;

CREATE TABLE IF NOT EXISTS `question_model` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `description` VARCHAR(256) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `question` ;

CREATE TABLE IF NOT EXISTS `question` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `questionary` INT(10) UNSIGNED NOT NULL,
  `statement` TEXT NOT NULL,
  `sort` INT(10) UNSIGNED NOT NULL,
  `model` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_question_1_idx` (`questionary` ASC),
  INDEX `fk_question_2_idx` (`model` ASC),
  CONSTRAINT `fk_question_1`
    FOREIGN KEY (`questionary`)
    REFERENCES `questionary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_2`
    FOREIGN KEY (`model`)
    REFERENCES `question_model` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `answer` ;

CREATE TABLE IF NOT EXISTS `answer` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` INT(10) UNSIGNED NOT NULL,
  `statement` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `correct` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_answer_1_idx` (`question` ASC),
  CONSTRAINT `fk_answer_1`
    FOREIGN KEY (`question`)
    REFERENCES `question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `registry` ;

CREATE TABLE IF NOT EXISTS `registry` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` INT(10) UNSIGNED NULL,
  `questionary` INT(10) UNSIGNED NOT NULL,
  `question` INT(10) UNSIGNED NOT NULL,
  `answer` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_registry_1_idx` (`user` ASC),
  INDEX `fk_registry_2_idx` (`questionary` ASC),
  INDEX `fk_registry_3_idx` (`question` ASC),
  INDEX `fk_registry_4_idx` (`answer` ASC),
  CONSTRAINT `fk_registry_1`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registry_2`
    FOREIGN KEY (`questionary`)
    REFERENCES `questionary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registry_3`
    FOREIGN KEY (`question`)
    REFERENCES `question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registry_4`
    FOREIGN KEY (`answer`)
    REFERENCES `answer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `administrator`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `administrator` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (1, 'administrator@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Admin', 'Uno', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `administrator` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (2, 'administrator2@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Admin', 'Dos', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `administrator` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (3, 'administrator3@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Admin', 'Tres', NULL, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `instructor`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `instructor` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (1, 'instructor@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Instructor', 'Uno', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `instructor` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (2, 'instructor2@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Instructor', 'Dos', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `instructor` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (3, 'instructor3@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Instructor', 'Tres', NULL, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `user` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (1, 'user@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Usuario', 'Uno', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `user` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (2, 'user2@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Usuario', 'Dos', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `user` (`id`, `email`, `password`, `name`, `surname_1`, `surname_2`, `created_at`, `updated_at`, `active`) VALUES (3, 'user3@tfm.com', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Usuario', 'Tres', NULL, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `group` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (1, 'Grupo Uno', 'Grupo Uno', DEFAULT, DEFAULT, 1);
INSERT INTO `group` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (2, 'Grupo Dos', 'Grupo Dos', DEFAULT, DEFAULT, 1);
INSERT INTO `group` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (3, 'Grupo Tres', 'Grupo Tres', DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `instructor_group`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (1, 1, 1, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (2, 1, 2, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (3, 1, 3, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (4, 2, 1, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (5, 2, 2, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (6, 2, 3, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (7, 3, 1, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (8, 3, 2, DEFAULT);
INSERT INTO `instructor_group` (`id`, `instructor`, `group`, `added_at`) VALUES (9, 3, 3, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_group`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (1, 1, 1, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (2, 1, 2, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (3, 1, 3, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (4, 2, 1, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (5, 2, 2, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (6, 2, 3, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (7, 3, 1, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (8, 3, 2, DEFAULT);
INSERT INTO `user_group` (`id`, `user`, `group`, `added_at`) VALUES (9, 3, 3, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `questionary_model`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `questionary_model` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (1, 'Examen', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `questionary_model` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (2, 'Encuesta', NULL, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `questionary`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (1, 1, 'Examen 1 - Grupo 1', 'Examen 1 - Grupo 1', 1, DEFAULT, DEFAULT, 0, 1);
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (2, 1, 'Examen 2 - Grupo 1', 'Examen 2 - Grupo 1', 1, DEFAULT, DEFAULT, 0, 1);
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (3, 2, 'Examen 1 - Grupo 2', 'Examen 1 - Grupo 2', 1, DEFAULT, DEFAULT, 0, 1);
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (4, 2, 'Examen 2 - Grupo 2', 'Examen 2 - Grupo 2', 1, DEFAULT, DEFAULT, 0, 1);
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (5, 3, 'Examen 1 - Grupo 3', 'Examen 1 - Grupo 3', 1, DEFAULT, DEFAULT, 0, 1);
INSERT INTO `questionary` (`id`, `group`, `title`, `description`, `model`, `created_at`, `updated_at`, `public`, `active`) VALUES (6, 3, 'Examen 2 - Grupo 3', 'Examen 2 - Grupo 3', 1, DEFAULT, DEFAULT, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `question_model`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `question_model` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (1, 'Sí/No', NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `question_model` (`id`, `name`, `description`, `created_at`, `updated_at`, `active`) VALUES (2, 'Test', NULL, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `question`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (1, 1, '¿Es Tirana la capital de Albania?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (2, 1, '¿Es Berlín la capital de Alemania?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (3, 1, '¿Es Viena la capital de Austria?', 3, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (4, 2, '¿Es Bruselas la capital de Bélgica?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (5, 2, '¿Es Minsk la capital de Bielorrusia?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (6, 2, '¿Es Sofía la capital de Bulgaria?', 3, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (7, 3, '¿Es Zagreb la capital de Croacia?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (8, 3, '¿Es Copenhague la capital de Dinamarca?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (9, 3, '¿Es Bratislava la capital de Eslovaquia?', 3, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (10, 4, '¿Es Liubliana la capital de Eslovenia?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (11, 4, '¿Es Madrid la capital de España?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (12, 4, '¿Es Tallín la capital de Estonia?', 3, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (13, 5, '¿Es Helsinki la capital de Finlandia?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (14, 5, '¿Es París la capital de Francia?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (15, 5, '¿Es Atenas la capital de Grecia?', 3, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (16, 6, '¿Es Budapest la capital de Hungría?', 1, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (17, 6, '¿Es Dublín la capital de Irlanda?', 2, 1, DEFAULT, DEFAULT, 1);
INSERT INTO `question` (`id`, `questionary`, `statement`, `sort`, `model`, `created_at`, `updated_at`, `active`) VALUES (18, 6, '¿Es Reikiavik la capital de Islandia?', 3, 1, DEFAULT, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `answer`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (1, 1, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (2, 1, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (3, 2, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (4, 2, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (5, 3, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (6, 3, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (7, 4, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (8, 4, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (9, 5, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (10, 5, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (11, 6, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (12, 6, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (13, 7, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (14, 7, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (15, 8, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (16, 8, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (17, 9, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (18, 9, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (19, 10, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (20, 10, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (21, 11, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (22, 11, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (23, 12, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (24, 12, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (25, 13, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (26, 13, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (27, 14, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (28, 14, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (29, 15, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (30, 15, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (31, 16, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (32, 16, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (33, 17, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (34, 17, 'No', DEFAULT, DEFAULT, 0);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (35, 18, 'Sí', DEFAULT, DEFAULT, 1);
INSERT INTO `answer` (`id`, `question`, `statement`, `created_at`, `updated_at`, `correct`) VALUES (36, 18, 'No', DEFAULT, DEFAULT, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `registry`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (1, 1, 1, 1, 1, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (2, 1, 1, 2, 4, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (3, 1, 1, 3, 5, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (4, 1, 3, 7, 14, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (5, 1, 3, 8, 15, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (6, 1, 3, 9, 18, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (7, 1, 5, 13, 25, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (8, 1, 5, 14, 28, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (9, 1, 5, 15, 29, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (10, 2, 1, 1, 2, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (11, 2, 1, 2, 3, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (12, 2, 1, 3, 6, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (13, 2, 3, 7, 13, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (14, 2, 3, 8, 16, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (15, 2, 3, 9, 17, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (16, 2, 5, 13, 26, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (17, 2, 5, 14, 27, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (18, 2, 5, 15, 30, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (19, 3, 1, 1, 1, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (20, 3, 1, 2, 4, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (21, 3, 1, 3, 5, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (22, 3, 3, 7, 14, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (23, 3, 3, 8, 15, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (24, 3, 3, 9, 18, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (25, 3, 5, 13, 25, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (26, 3, 5, 14, 28, DEFAULT);
INSERT INTO `registry` (`id`, `user`, `questionary`, `question`, `answer`, `created_at`) VALUES (27, 3, 5, 15, 29, DEFAULT);

COMMIT;


