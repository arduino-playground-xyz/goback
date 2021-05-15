DROP SCHEMA IF EXISTS `terentiy`;
CREATE SCHEMA `terentiy` DEFAULT CHARACTER SET utf8mb4;

CREATE TABLE `terentiy`.`board` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `secure_id` VARCHAR(30) NOT NULL,
    `tag` VARCHAR(50) NOT NULL,
    `type` ENUM('uno_wifi_rev2') NOT NULL DEFAULT 'uno_wifi_rev2',
    UNIQUE INDEX `secure_id__unq` (`secure_id` ASC)
);

CREATE TABLE `terentiy`.`incubator` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `board_id` INT UNSIGNED NOT NULL,
    `is_active` TINYINT(1) NULL DEFAULT 1,
    `tag` VARCHAR(50) NOT NULL,
    `measurement_interval_ms` INT UNSIGNED NOT NULL,
    `action_polling_interval_ms` INT UNSIGNED NOT NULL,
    UNIQUE INDEX `board_id__is_active__unq` (`board_id` ASC, `is_active` ASC)
);

CREATE TABLE `terentiy`.`output_device_model` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` ENUM('pump', 'led', 'fan'),
    `model` VARCHAR(100) NOT NULL
);

CREATE TABLE `terentiy`.`output_device` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `incubator_id` INT UNSIGNED NOT NULL,
    `device_model_id` INT UNSIGNED NOT NULL,
    `tag` VARCHAR(50) NOT NULL,
    `pin` VARCHAR(3) NOT NULL,
    `meta` VARCHAR(100) NULL
);

CREATE TABLE `terentiy`.`input_device_model` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` ENUM('soil_humidity', 'air_humidity', 'air_temperature', 'ambient_light'),
    `model` VARCHAR(100) NOT NULL
);

CREATE TABLE `terentiy`.`input_device` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `incubator_id` INT UNSIGNED NOT NULL,
    `device_model_id` INT UNSIGNED NOT NULL,
    `tag` VARCHAR(50) NOT NULL,
    `pin` VARCHAR(3) NOT NULL,
    `meta` VARCHAR(100) NULL
);

CREATE TABLE `terentiy`.`decision` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` ENUM('restart_config', 'pump', 'fan', 'led'),
    `incubator_id` INT UNSIGNED NOT NULL,
    `output_device_id` INT UNSIGNED NULL
);

CREATE TABLE `terentiy`.`action` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `decision_id` INT UNSIGNED NOT NULL,
    `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `duration_ms` INT UNSIGNED NULL,
    `value` FLOAT NULL,
    `reason` VARCHAR(255) NOT NULL,
    `influx_query` TEXT NULL
);

CREATE TABLE `terentiy`.`action_state` (
    `action_id` INT UNSIGNED NOT NULL PRIMARY KEY,
    `started` TIMESTAMP NULL,
    `finished` TIMESTAMP NULL
);
