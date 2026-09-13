CREATE TABLE IF NOT EXISTS `relay_phone_identities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(96) NOT NULL,
    `phone_number` VARCHAR(32) NOT NULL,
    `display_name` VARCHAR(100) NULL DEFAULT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `last_seen_at` TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_relay_phone_identities_identifier` (`identifier`),
    UNIQUE KEY `uq_relay_phone_identities_phone_number` (`phone_number`),
    KEY `idx_relay_phone_identities_last_seen` (`last_seen_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
