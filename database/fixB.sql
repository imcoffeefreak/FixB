CREATE TABLE `group` (
  `group_id` varchar(255) PRIMARY KEY,
  `group_name` varchar(255)
);

CREATE TABLE `users` (
  `user_id` varchar(255) PRIMARY KEY,
  `group_id` varchar(255),
  `username` varchar(255),
  `firstname` varchar(255),
  `lastname` varchar(255),
  `email_address` varchar(255),
  `mobile_number` varchar(255),
  `bio` varchar(255),
  `location` varchar(255),
  `occupation` varchar(255),
  `password` varchar(255),
  `is_deleted` boolean,
  `deleted_at` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `domains_or_languages` (
  `id` varchar(255) PRIMARY KEY,
  `domain_name` varchar(255)
);

CREATE TABLE `user_domains` (
  `id` varchar(255) PRIMARY KEY,
  `user_id` varchar(255),
  `domain_id` varchar(255)
);

CREATE TABLE `bug_posts` (
  `bug_id` varchar(255) PRIMARY KEY,
  `bug_title` varchar(255),
  `bug_description` varchar(255),
  `bug_issuer_id` varchar(255),
  `bug_tags` json,
  `is_pooled` boolean,
  `pooled_count` int,
  `is_solved` boolean,
  `efficient_bid` int,
  `bid_count` int,
  `bug_solver_id` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `bug_screenshots` (
  `id` varchar(255) PRIMARY KEY,
  `bug_id` varchar(255),
  `screenshot_path` varchar(255)
);

CREATE TABLE `bug_pool` (
  `id` varchar(255) PRIMARY KEY,
  `bug_id` varchar(255),
  `bug_pooler_id` varchar(255),
  `pool_title` varchar(255),
  `pool_description` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `bug_bids` (
  `bid_id` varchar(255) PRIMARY KEY,
  `bug_id` varchar(255),
  `bidder_id` varchar(255),
  `bid_amount` int,
  `solving_time` timestamp,
  `is_deleted` boolean,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `bug_issuer_ratings` (
  `id` varchar(255) PRIMARY KEY,
  `bug_id` varchar(255),
  `bug_issuer_id` varchar(255),
  `bug_issuer_rating` int,
  `bug_issuer_comment` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `bug_solver_ratings` (
  `id` varchar(255) PRIMARY KEY,
  `bug_id` varchar(255),
  `bug_solver_id` varchar(255),
  `bug_solver_rating` int,
  `bug_solver_comment` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

ALTER TABLE `users` ADD FOREIGN KEY (`group_id`) REFERENCES `group` (`group_id`);

ALTER TABLE `user_domains` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `user_domains` ADD FOREIGN KEY (`domain_id`) REFERENCES `domains_or_languages` (`id`);

ALTER TABLE `bug_posts` ADD FOREIGN KEY (`bug_issuer_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `bug_posts` ADD FOREIGN KEY (`bug_solver_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `bug_screenshots` ADD FOREIGN KEY (`bug_id`) REFERENCES `bug_posts` (`bug_id`);

ALTER TABLE `bug_pool` ADD FOREIGN KEY (`bug_id`) REFERENCES `bug_posts` (`bug_id`);

ALTER TABLE `bug_bids` ADD FOREIGN KEY (`bug_id`) REFERENCES `bug_posts` (`bug_id`);

ALTER TABLE `bug_bids` ADD FOREIGN KEY (`bidder_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `bug_issuer_ratings` ADD FOREIGN KEY (`bug_id`) REFERENCES `bug_posts` (`bug_id`);

ALTER TABLE `bug_issuer_ratings` ADD FOREIGN KEY (`bug_issuer_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `bug_solver_ratings` ADD FOREIGN KEY (`bug_id`) REFERENCES `bug_posts` (`bug_id`);

ALTER TABLE `bug_solver_ratings` ADD FOREIGN KEY (`bug_solver_id`) REFERENCES `users` (`user_id`);
