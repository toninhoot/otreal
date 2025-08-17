-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 17/08/2025 às 21:59
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `teste`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(64) NOT NULL DEFAULT '',
  `created` int(11) NOT NULL DEFAULT 0,
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(3) NOT NULL DEFAULT '',
  `web_lastlogin` int(11) NOT NULL DEFAULT 0,
  `web_flags` int(11) NOT NULL DEFAULT 0,
  `email_hash` varchar(32) NOT NULL DEFAULT '',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int(11) NOT NULL DEFAULT 0,
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `email_next` int(11) NOT NULL DEFAULT 0,
  `premium_points` int(11) NOT NULL DEFAULT 0,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `premdays` int(11) NOT NULL DEFAULT 0,
  `premdays_purchased` int(11) NOT NULL DEFAULT 0,
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `coins` int(12) UNSIGNED NOT NULL DEFAULT 0,
  `coins_transferable` int(12) UNSIGNED NOT NULL DEFAULT 0,
  `tournament_coins` int(12) UNSIGNED NOT NULL DEFAULT 0,
  `creation` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `recruiter` int(6) DEFAULT 0,
  `house_bid_id` int(11) NOT NULL DEFAULT 0,
  `vote` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `email`, `key`, `created`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_new`, `email_new_time`, `email_code`, `email_next`, `premium_points`, `email_verified`, `premdays`, `premdays_purchased`, `lastday`, `type`, `coins`, `coins_transferable`, `tournament_coins`, `creation`, `recruiter`, `house_bid_id`, `vote`) VALUES
(1, 'god', '21298df8a3277357ee55b01df9530b535cf08ec1', '@god', '', 0, '', '', '', 0, 0, '', '', 0, '', 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 1755433633, 0, 0, 0),
(2, 'tonireinbold', '97a1e557ff74e7aee3355962fcddb7b26258d10b', 'toni.reinbold@gmail.com', '', 1755434081, '', '', 'us', 0, 3, '', '', 0, '', 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 1755434148, 0, 0, 0);

--
-- Acionadores `accounts`
--
DELIMITER $$
CREATE TRIGGER `oncreate_accounts` AFTER INSERT ON `accounts` FOR EACH ROW BEGIN
    INSERT INTO `account_vipgroups` (`account_id`, `name`, `customizable`) VALUES (NEW.`id`, 'Enemies', 0);
    INSERT INTO `account_vipgroups` (`account_id`, `name`, `customizable`) VALUES (NEW.`id`, 'Friends', 0);
    INSERT INTO `account_vipgroups` (`account_id`, `name`, `customizable`) VALUES (NEW.`id`, 'Trading Partner', 0);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(11) NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_sessions`
--

CREATE TABLE `account_sessions` (
  `id` varchar(191) NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `expires` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_vipgrouplist`
--

CREATE TABLE `account_vipgrouplist` (
  `account_id` int(11) UNSIGNED NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `vipgroup_id` int(11) UNSIGNED NOT NULL COMMENT 'id of vip group that player belongs'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_vipgroups`
--

CREATE TABLE `account_vipgroups` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL COMMENT 'id of account whose vip group entry it is',
  `name` varchar(128) NOT NULL,
  `customizable` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `account_vipgroups`
--

INSERT INTO `account_vipgroups` (`id`, `account_id`, `name`, `customizable`) VALUES
(1, 1, 'Enemies', 0),
(2, 1, 'Friends', 0),
(3, 1, 'Trading Partner', 0),
(4, 2, 'Enemies', 0),
(5, 2, 'Friends', 0),
(6, 2, 'Trading Partner', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) UNSIGNED NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `notify` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `boosted_boss`
--

CREATE TABLE `boosted_boss` (
  `boostname` text DEFAULT NULL,
  `date` varchar(250) NOT NULL DEFAULT '',
  `raceid` varchar(250) NOT NULL DEFAULT '',
  `looktypeEx` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `lookmount` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `boosted_boss`
--

INSERT INTO `boosted_boss` (`boostname`, `date`, `raceid`, `looktypeEx`, `looktype`, `lookfeet`, `looklegs`, `lookhead`, `lookbody`, `lookaddons`, `lookmount`) VALUES
('The Unwelcome', '17', '1868', 0, 1277, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `boosted_creature`
--

CREATE TABLE `boosted_creature` (
  `boostname` text DEFAULT NULL,
  `date` varchar(250) NOT NULL DEFAULT '',
  `raceid` varchar(250) NOT NULL DEFAULT '',
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `lookmount` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `boosted_creature`
--

INSERT INTO `boosted_creature` (`boostname`, `date`, `raceid`, `looktype`, `lookfeet`, `looklegs`, `lookhead`, `lookbody`, `lookaddons`, `lookmount`) VALUES
('Nightmare', '17', '299', 245, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `coins_transactions`
--

CREATE TABLE `coins_transactions` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL,
  `coin_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `amount` int(12) UNSIGNED NOT NULL,
  `description` varchar(3500) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `daily_reward_history`
--

CREATE TABLE `daily_reward_history` (
  `id` int(11) NOT NULL,
  `daystreak` smallint(2) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `economy_tariffs`
--

CREATE TABLE `economy_tariffs` (
  `id` int(11) NOT NULL,
  `scope` enum('FEDERAL','KINGDOM') NOT NULL,
  `kingdom_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `rate` decimal(5,4) NOT NULL DEFAULT 0.0000,
  `set_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `economy_tariffs`
--

INSERT INTO `economy_tariffs` (`id`, `scope`, `kingdom_id`, `rate`, `set_by`, `updated_at`) VALUES
(1, 'FEDERAL', NULL, 0.0000, NULL, '2025-08-17 13:48:14'),
(2, 'KINGDOM', 1, 0.0000, NULL, '2025-08-17 13:48:14'),
(3, 'KINGDOM', 2, 0.0000, NULL, '2025-08-17 13:48:14'),
(4, 'KINGDOM', 3, 0.0000, NULL, '2025-08-17 13:48:14'),
(5, 'KINGDOM', 4, 0.0000, NULL, '2025-08-17 13:48:14');

-- --------------------------------------------------------

--
-- Estrutura para tabela `election_candidate`
--

CREATE TABLE `election_candidate` (
  `id` bigint(20) NOT NULL,
  `cycle_id` bigint(20) NOT NULL,
  `office` enum('PRESIDENT','GOVERNOR') NOT NULL,
  `kingdom` tinyint(3) UNSIGNED DEFAULT NULL,
  `player_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `election_cycle`
--

CREATE TABLE `election_cycle` (
  `id` bigint(20) NOT NULL,
  `week_iso` char(8) NOT NULL,
  `start_ts` datetime NOT NULL,
  `candidacy_open_ts` datetime NOT NULL,
  `voting_open_ts` datetime NOT NULL,
  `voting_close_ts` datetime NOT NULL,
  `status` enum('PLANNED','CANDIDACY','VOTING','CLOSED') NOT NULL DEFAULT 'PLANNED',
  `pres_quorum_abs` int(11) DEFAULT NULL,
  `pres_quorum_pct` decimal(5,2) DEFAULT NULL,
  `gov_quorum_abs` int(11) DEFAULT NULL,
  `gov_quorum_pct` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `election_vote`
--

CREATE TABLE `election_vote` (
  `id` bigint(20) NOT NULL,
  `cycle_id` bigint(20) NOT NULL,
  `office` enum('PRESIDENT','GOVERNOR') NOT NULL,
  `kingdom` tinyint(3) UNSIGNED DEFAULT NULL,
  `voter_player_id` int(11) NOT NULL,
  `voter_account_id` int(11) NOT NULL,
  `candidate_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `forge_history`
--

CREATE TABLE `forge_history` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `action_type` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `is_success` tinyint(4) NOT NULL DEFAULT 0,
  `bonus` tinyint(4) NOT NULL DEFAULT 0,
  `done_at` bigint(20) NOT NULL,
  `done_at_date` datetime DEFAULT current_timestamp(),
  `cost` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `gained` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `global_storage`
--

CREATE TABLE `global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `global_storage`
--

INSERT INTO `global_storage` (`key`, `value`) VALUES
('40000', '4');

-- --------------------------------------------------------

--
-- Estrutura para tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `residence` int(11) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `description` varchar(5000) NOT NULL DEFAULT '',
  `logo_name` varchar(255) NOT NULL DEFAULT 'default.gif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Acionadores `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('The Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT 0,
  `targetguild` int(11) NOT NULL DEFAULT 0,
  `warid` int(11) NOT NULL DEFAULT 0,
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT 0,
  `guild2` int(11) NOT NULL DEFAULT 0,
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `started` bigint(15) NOT NULL DEFAULT 0,
  `ended` bigint(15) NOT NULL DEFAULT 0,
  `frags_limit` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `payment` bigint(13) UNSIGNED NOT NULL DEFAULT 0,
  `duration_days` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `new_owner` int(11) NOT NULL DEFAULT -1,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `guildid` int(11) DEFAULT NULL,
  `beds` int(11) NOT NULL DEFAULT 0,
  `bidder` int(11) NOT NULL DEFAULT 0,
  `bidder_name` varchar(255) NOT NULL DEFAULT '',
  `highest_bid` int(11) NOT NULL DEFAULT 0,
  `internal_bid` int(11) NOT NULL DEFAULT 0,
  `bid_end_date` int(11) NOT NULL DEFAULT 0,
  `state` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `transfer_status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `houses`
--

INSERT INTO `houses` (`id`, `owner`, `new_owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `size`, `guildid`, `beds`, `bidder`, `bidder_name`, `highest_bid`, `internal_bid`, `bid_end_date`, `state`, `transfer_status`) VALUES
(2628, 0, -1, 0, 0, 'Castle of the Winds', 500000, 5, 493, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2629, 0, -1, 0, 0, 'Ab\'Dendriel Clanhall', 250000, 5, 310, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2630, 0, -1, 0, 0, 'Underwood 9', 50000, 5, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2631, 0, -1, 0, 0, 'Treetop 13', 100000, 5, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2632, 0, -1, 0, 0, 'Underwood 8', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2633, 0, -1, 0, 0, 'Treetop 11', 50000, 5, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2635, 0, -1, 0, 0, 'Great Willow 2a', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2637, 0, -1, 0, 0, 'Great Willow 2b', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2638, 0, -1, 0, 0, 'Great Willow Western Wing', 100000, 5, 53, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2640, 0, -1, 0, 0, 'Great Willow 1', 100000, 5, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2642, 0, -1, 0, 0, 'Great Willow 3a', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2644, 0, -1, 0, 0, 'Great Willow 3b', 80000, 5, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2645, 0, -1, 0, 0, 'Great Willow 4a', 25000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2648, 0, -1, 0, 0, 'Great Willow 4b', 25000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2649, 0, -1, 0, 0, 'Underwood 6', 100000, 5, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2650, 0, -1, 0, 0, 'Underwood 3', 100000, 5, 33, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2651, 0, -1, 0, 0, 'Underwood 5', 80000, 5, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2652, 0, -1, 0, 0, 'Underwood 2', 100000, 5, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2653, 0, -1, 0, 0, 'Underwood 1', 100000, 5, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2654, 0, -1, 0, 0, 'Prima Arbor', 400000, 5, 197, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2655, 0, -1, 0, 0, 'Underwood 7', 200000, 5, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2656, 0, -1, 0, 0, 'Underwood 10', 25000, 5, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2657, 0, -1, 0, 0, 'Underwood 4', 100000, 5, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2658, 0, -1, 0, 0, 'Treetop 9', 50000, 5, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2659, 0, -1, 0, 0, 'Treetop 10', 80000, 5, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2660, 0, -1, 0, 0, 'Treetop 8', 25000, 5, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2661, 0, -1, 0, 0, 'Treetop 7', 50000, 5, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2662, 0, -1, 0, 0, 'Treetop 6', 25000, 5, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2663, 0, -1, 0, 0, 'Treetop 5 (Shop)', 80000, 5, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2664, 0, -1, 0, 0, 'Treetop 12 (Shop)', 100000, 5, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2665, 0, -1, 0, 0, 'Treetop 4 (Shop)', 80000, 5, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2666, 0, -1, 0, 0, 'Treetop 3 (Shop)', 80000, 5, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2687, 0, -1, 0, 0, 'Northern Street 1a', 100000, 6, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2688, 0, -1, 0, 0, 'Park Lane 3a', 100000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2689, 0, -1, 0, 0, 'Park Lane 1a', 150000, 6, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2690, 0, -1, 0, 0, 'Park Lane 4', 150000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2691, 0, -1, 0, 0, 'Park Lane 2', 150000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2692, 0, -1, 0, 0, 'Theater Avenue 7, Flat 04', 50000, 6, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2693, 0, -1, 0, 0, 'Theater Avenue 7, Flat 03', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2694, 0, -1, 0, 0, 'Theater Avenue 7, Flat 05', 50000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2695, 0, -1, 0, 0, 'Theater Avenue 7, Flat 06', 25000, 6, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2696, 0, -1, 0, 0, 'Theater Avenue 7, Flat 02', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2697, 0, -1, 0, 0, 'Theater Avenue 7, Flat 01', 25000, 6, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2698, 0, -1, 0, 0, 'Northern Street 5', 200000, 6, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2699, 0, -1, 0, 0, 'Northern Street 7', 150000, 6, 40, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2700, 0, -1, 0, 0, 'Theater Avenue 6e', 80000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2701, 0, -1, 0, 0, 'Theater Avenue 6c', 25000, 6, 5, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2702, 0, -1, 0, 0, 'Theater Avenue 6a', 80000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2703, 0, -1, 0, 0, 'Theater Avenue, Tower', 300000, 6, 70, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2705, 0, -1, 0, 0, 'East Lane 2', 300000, 6, 108, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2706, 0, -1, 0, 0, 'Harbour Lane 2a (Shop)', 80000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2707, 0, -1, 0, 0, 'Harbour Lane 2b (Shop)', 80000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2708, 0, -1, 0, 0, 'Harbour Lane 3', 400000, 6, 84, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2709, 0, -1, 0, 0, 'Magician\'s Alley 8', 150000, 6, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2710, 0, -1, 0, 0, 'Lonely Sea Side Hostel', 400000, 6, 281, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2711, 0, -1, 0, 0, 'Suntower', 500000, 6, 232, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2712, 0, -1, 0, 0, 'House of Recreation', 500000, 6, 401, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2713, 0, -1, 0, 0, 'Carlin Clanhall', 250000, 6, 211, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2714, 0, -1, 0, 0, 'Magician\'s Alley 4', 200000, 6, 49, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2715, 0, -1, 0, 0, 'Theater Avenue 14 (Shop)', 200000, 6, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2716, 0, -1, 0, 0, 'Theater Avenue 12', 80000, 6, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2717, 0, -1, 0, 0, 'Magician\'s Alley 1', 100000, 6, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2718, 0, -1, 0, 0, 'Theater Avenue 10', 100000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2719, 0, -1, 0, 0, 'Magician\'s Alley 1b', 25000, 6, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2720, 0, -1, 0, 0, 'Magician\'s Alley 1a', 25000, 6, 12, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2721, 0, -1, 0, 0, 'Magician\'s Alley 1c', 25000, 6, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2722, 0, -1, 0, 0, 'Magician\'s Alley 1d', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2723, 0, -1, 0, 0, 'Magician\'s Alley 5c', 100000, 6, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2724, 0, -1, 0, 0, 'Magician\'s Alley 5f', 80000, 6, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2725, 0, -1, 0, 0, 'Magician\'s Alley 5b', 50000, 6, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2727, 0, -1, 0, 0, 'Magician\'s Alley 5a', 50000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2729, 0, -1, 0, 0, 'Central Plaza 3 (Shop)', 50000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2730, 0, -1, 0, 0, 'Central Plaza 2 (Shop)', 25000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2731, 0, -1, 0, 0, 'Central Plaza 1 (Shop)', 50000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2732, 0, -1, 0, 0, 'Theater Avenue 8b', 100000, 6, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2733, 0, -1, 0, 0, 'Harbour Lane 1 (Shop)', 100000, 6, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2734, 0, -1, 0, 0, 'Theater Avenue 6f', 80000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2735, 0, -1, 0, 0, 'Theater Avenue 6d', 25000, 6, 5, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2736, 0, -1, 0, 0, 'Theater Avenue 6b', 50000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2737, 0, -1, 0, 0, 'Northern Street 3a', 80000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2738, 0, -1, 0, 0, 'Northern Street 3b', 80000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2739, 0, -1, 0, 0, 'Northern Street 1b', 80000, 6, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2740, 0, -1, 0, 0, 'Northern Street 1c', 80000, 6, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2741, 0, -1, 0, 0, 'Theater Avenue 7, Flat 14', 25000, 6, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2742, 0, -1, 0, 0, 'Theater Avenue 7, Flat 13', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2743, 0, -1, 0, 0, 'Theater Avenue 7, Flat 15', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2744, 0, -1, 0, 0, 'Theater Avenue 7, Flat 12', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2745, 0, -1, 0, 0, 'Theater Avenue 7, Flat 11', 50000, 6, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2746, 0, -1, 0, 0, 'Theater Avenue 7, Flat 16', 25000, 6, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2747, 0, -1, 0, 0, 'Theater Avenue 5', 200000, 6, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2751, 0, -1, 0, 0, 'Harbour Flats, Flat 11', 25000, 6, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2752, 0, -1, 0, 0, 'Harbour Flats, Flat 13', 25000, 6, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2753, 0, -1, 0, 0, 'Harbour Flats, Flat 15', 50000, 6, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2755, 0, -1, 0, 0, 'Harbour Flats, Flat 12', 50000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2757, 0, -1, 0, 0, 'Harbour Flats, Flat 16', 50000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2759, 0, -1, 0, 0, 'Harbour Flats, Flat 21', 50000, 6, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2760, 0, -1, 0, 0, 'Harbour Flats, Flat 22', 80000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2761, 0, -1, 0, 0, 'Harbour Flats, Flat 23', 25000, 6, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2763, 0, -1, 0, 0, 'Park Lane 1b', 200000, 6, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2764, 0, -1, 0, 0, 'Theater Avenue 8a', 100000, 6, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2765, 0, -1, 0, 0, 'Theater Avenue 11a', 100000, 6, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2767, 0, -1, 0, 0, 'Theater Avenue 11b', 100000, 6, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2768, 0, -1, 0, 0, 'Caretaker\'s Residence', 600000, 6, 231, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2769, 0, -1, 0, 0, 'Moonkeep', 250000, 6, 289, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2770, 0, -1, 0, 0, 'Mangrove 1', 80000, 5, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2771, 0, -1, 0, 0, 'Coastwood 2', 50000, 5, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2772, 0, -1, 0, 0, 'Coastwood 1', 50000, 5, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2773, 0, -1, 0, 0, 'Coastwood 3', 50000, 5, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2774, 0, -1, 0, 0, 'Coastwood 4', 50000, 5, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2775, 0, -1, 0, 0, 'Mangrove 4', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2776, 0, -1, 0, 0, 'Coastwood 10', 80000, 5, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2777, 0, -1, 0, 0, 'Coastwood 5', 50000, 5, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2778, 0, -1, 0, 0, 'Coastwood 6 (Shop)', 80000, 5, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2779, 0, -1, 0, 0, 'Coastwood 7', 25000, 5, 12, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2780, 0, -1, 0, 0, 'Coastwood 8', 50000, 5, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2781, 0, -1, 0, 0, 'Coastwood 9', 50000, 5, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2782, 0, -1, 0, 0, 'Treetop 2', 25000, 5, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2783, 0, -1, 0, 0, 'Treetop 1', 25000, 5, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2784, 0, -1, 0, 0, 'Mangrove 3', 80000, 5, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2785, 0, -1, 0, 0, 'Mangrove 2', 50000, 5, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2786, 0, -1, 0, 0, 'The Hideout', 250000, 5, 378, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2787, 0, -1, 0, 0, 'Shadow Towers', 250000, 5, 402, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2788, 0, -1, 0, 0, 'Druids Retreat A', 50000, 6, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2789, 0, -1, 0, 0, 'Druids Retreat C', 50000, 6, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2790, 0, -1, 0, 0, 'Druids Retreat B', 50000, 6, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2791, 0, -1, 0, 0, 'Druids Retreat D', 80000, 6, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2792, 0, -1, 0, 0, 'East Lane 1b', 150000, 6, 40, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2793, 0, -1, 0, 0, 'East Lane 1a', 200000, 6, 54, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2794, 0, -1, 0, 0, 'Senja Village 11', 80000, 6, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2795, 0, -1, 0, 0, 'Senja Village 10', 50000, 6, 33, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2796, 0, -1, 0, 0, 'Senja Village 9', 80000, 6, 55, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2797, 0, -1, 0, 0, 'Senja Village 8', 50000, 6, 35, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2798, 0, -1, 0, 0, 'Senja Village 7', 25000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2799, 0, -1, 0, 0, 'Senja Village 6b', 25000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2800, 0, -1, 0, 0, 'Senja Village 6a', 50000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2801, 0, -1, 0, 0, 'Senja Village 5', 50000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2802, 0, -1, 0, 0, 'Senja Village 4', 50000, 6, 34, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2803, 0, -1, 0, 0, 'Senja Village 3', 50000, 6, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2804, 0, -1, 0, 0, 'Senja Village 1b', 50000, 6, 34, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2805, 0, -1, 0, 0, 'Senja Village 1a', 25000, 6, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2806, 0, -1, 0, 0, 'Rosebud C', 100000, 6, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2807, 0, -1, 0, 0, 'Rosebud B', 80000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2808, 0, -1, 0, 0, 'Rosebud A', 50000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2809, 0, -1, 0, 0, 'Park Lane 3b', 100000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2810, 0, -1, 0, 0, 'Northport Village 6', 80000, 6, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2811, 0, -1, 0, 0, 'Northport Village 5', 80000, 6, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2812, 0, -1, 0, 0, 'Northport Village 4', 100000, 6, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2813, 0, -1, 0, 0, 'Northport Village 3', 150000, 6, 97, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2814, 0, -1, 0, 0, 'Northport Village 2', 50000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2815, 0, -1, 0, 0, 'Northport Village 1', 50000, 6, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2816, 0, -1, 0, 0, 'Nautic Observer', 200000, 6, 156, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2817, 0, -1, 0, 0, 'Nordic Stronghold', 250000, 6, 410, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2818, 0, -1, 0, 0, 'Senja Clanhall', 250000, 6, 215, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2819, 0, -1, 0, 0, 'Seawatch', 250000, 6, 422, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2820, 0, -1, 0, 0, 'Dwarven Magnate\'s Estate', 300000, 7, 248, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2821, 0, -1, 0, 0, 'Forge Master\'s Quarters', 300000, 7, 352, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2822, 0, -1, 0, 0, 'Upper Barracks 13', 25000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2823, 0, -1, 0, 0, 'Upper Barracks 5', 80000, 7, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2824, 0, -1, 0, 0, 'Upper Barracks 3', 80000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2825, 0, -1, 0, 0, 'Upper Barracks 4', 50000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2826, 0, -1, 0, 0, 'Upper Barracks 2', 80000, 7, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2827, 0, -1, 0, 0, 'Upper Barracks 1', 50000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2828, 0, -1, 0, 0, 'Tunnel Gardens 9', 150000, 7, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2829, 0, -1, 0, 0, 'Tunnel Gardens 8', 25000, 7, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2830, 0, -1, 0, 0, 'Tunnel Gardens 7', 50000, 7, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2831, 0, -1, 0, 0, 'Tunnel Gardens 6', 25000, 7, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2832, 0, -1, 0, 0, 'Tunnel Gardens 5', 25000, 7, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2835, 0, -1, 0, 0, 'Tunnel Gardens 4', 80000, 7, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2836, 0, -1, 0, 0, 'Tunnel Gardens 2', 80000, 7, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2837, 0, -1, 0, 0, 'Tunnel Gardens 1', 80000, 7, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2838, 0, -1, 0, 0, 'Tunnel Gardens 3', 80000, 7, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2839, 0, -1, 0, 0, 'The Market 4 (Shop)', 80000, 7, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2840, 0, -1, 0, 0, 'The Market 3 (Shop)', 80000, 7, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2841, 0, -1, 0, 0, 'The Market 2 (Shop)', 50000, 7, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2842, 0, -1, 0, 0, 'The Market 1 (Shop)', 25000, 7, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2843, 0, -1, 0, 0, 'The Farms 6, Fishing Hut', 50000, 7, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2844, 0, -1, 0, 0, 'The Farms 5', 50000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2845, 0, -1, 0, 0, 'The Farms 4', 25000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2846, 0, -1, 0, 0, 'The Farms 3', 80000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2847, 0, -1, 0, 0, 'The Farms 2', 50000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2849, 0, -1, 0, 0, 'The Farms 1', 80000, 7, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2850, 0, -1, 0, 0, 'Outlaw Camp 14 (Shop)', 25000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2852, 0, -1, 0, 0, 'Outlaw Camp 13 (Shop)', 50000, 7, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2853, 0, -1, 0, 0, 'Outlaw Camp 9', 80000, 7, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2854, 0, -1, 0, 0, 'Outlaw Camp 7', 25000, 7, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2855, 0, -1, 0, 0, 'Outlaw Camp 4', 50000, 7, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2856, 0, -1, 0, 0, 'Outlaw Camp 2', 50000, 7, 14, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2857, 0, -1, 0, 0, 'Outlaw Camp 3', 50000, 7, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2858, 0, -1, 0, 0, 'Outlaw Camp 1', 80000, 7, 39, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2859, 0, -1, 0, 0, 'Nobility Quarter 5', 100000, 7, 79, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2860, 0, -1, 0, 0, 'Nobility Quarter 4', 50000, 7, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2861, 0, -1, 0, 0, 'Nobility Quarter 3', 80000, 7, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2862, 0, -1, 0, 0, 'Nobility Quarter 2', 50000, 7, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2863, 0, -1, 0, 0, 'Nobility Quarter 1', 80000, 7, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2864, 0, -1, 0, 0, 'Lower Barracks 10', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2865, 0, -1, 0, 0, 'Lower Barracks 9', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2866, 0, -1, 0, 0, 'Lower Barracks 8', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2867, 0, -1, 0, 0, 'Lower Barracks 1', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2868, 0, -1, 0, 0, 'Lower Barracks 2', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2869, 0, -1, 0, 0, 'Lower Barracks 3', 80000, 7, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2870, 0, -1, 0, 0, 'Lower Barracks 4', 50000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2871, 0, -1, 0, 0, 'Lower Barracks 5', 100000, 7, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2872, 0, -1, 0, 0, 'Lower Barracks 6', 100000, 7, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2873, 0, -1, 0, 0, 'Lower Barracks 7', 80000, 7, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2874, 0, -1, 0, 0, 'Wolftower', 500000, 7, 387, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2875, 0, -1, 0, 0, 'Riverspring', 250000, 7, 353, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2876, 0, -1, 0, 0, 'Outlaw Castle', 250000, 7, 180, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2877, 0, -1, 0, 0, 'Marble Guildhall', 250000, 7, 338, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2878, 0, -1, 0, 0, 'Iron Guildhall', 250000, 7, 308, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2879, 0, -1, 0, 0, 'Hill Hideout', 250000, 7, 251, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2880, 0, -1, 0, 0, 'Granite Guildhall', 250000, 7, 361, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2881, 0, -1, 0, 0, 'Alai Flats, Flat 01', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2882, 0, -1, 0, 0, 'Alai Flats, Flat 02', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2883, 0, -1, 0, 0, 'Alai Flats, Flat 03', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2884, 0, -1, 0, 0, 'Alai Flats, Flat 04', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2885, 0, -1, 0, 0, 'Alai Flats, Flat 05', 100000, 8, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2886, 0, -1, 0, 0, 'Alai Flats, Flat 06', 100000, 8, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2887, 0, -1, 0, 0, 'Alai Flats, Flat 07', 25000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2888, 0, -1, 0, 0, 'Alai Flats, Flat 08', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2889, 0, -1, 0, 0, 'Alai Flats, Flat 11', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2890, 0, -1, 0, 0, 'Alai Flats, Flat 12', 25000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2891, 0, -1, 0, 0, 'Alai Flats, Flat 13', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2892, 0, -1, 0, 0, 'Alai Flats, Flat 14', 80000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2893, 0, -1, 0, 0, 'Alai Flats, Flat 15', 100000, 8, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2894, 0, -1, 0, 0, 'Alai Flats, Flat 16', 100000, 8, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2895, 0, -1, 0, 0, 'Alai Flats, Flat 17', 80000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2896, 0, -1, 0, 0, 'Alai Flats, Flat 18', 50000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2897, 0, -1, 0, 0, 'Alai Flats, Flat 21', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2898, 0, -1, 0, 0, 'Alai Flats, Flat 22', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2899, 0, -1, 0, 0, 'Alai Flats, Flat 23', 25000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2900, 0, -1, 0, 0, 'Alai Flats, Flat 28', 80000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2901, 0, -1, 0, 0, 'Alai Flats, Flat 27', 80000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2902, 0, -1, 0, 0, 'Alai Flats, Flat 26', 100000, 8, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2903, 0, -1, 0, 0, 'Alai Flats, Flat 25', 100000, 8, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2904, 0, -1, 0, 0, 'Alai Flats, Flat 24', 80000, 8, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2905, 0, -1, 0, 0, 'Beach Home Apartments, Flat 01', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2906, 0, -1, 0, 0, 'Beach Home Apartments, Flat 02', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2907, 0, -1, 0, 0, 'Beach Home Apartments, Flat 03', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2908, 0, -1, 0, 0, 'Beach Home Apartments, Flat 04', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2909, 0, -1, 0, 0, 'Beach Home Apartments, Flat 05', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2910, 0, -1, 0, 0, 'Beach Home Apartments, Flat 06', 100000, 8, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2911, 0, -1, 0, 0, 'Beach Home Apartments, Flat 11', 25000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2912, 0, -1, 0, 0, 'Beach Home Apartments, Flat 12', 50000, 8, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2913, 0, -1, 0, 0, 'Beach Home Apartments, Flat 13', 80000, 8, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2914, 0, -1, 0, 0, 'Beach Home Apartments, Flat 14', 25000, 8, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2915, 0, -1, 0, 0, 'Beach Home Apartments, Flat 15', 25000, 8, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2916, 0, -1, 0, 0, 'Beach Home Apartments, Flat 16', 80000, 8, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2917, 0, -1, 0, 0, 'Demon Tower', 100000, 8, 72, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2918, 0, -1, 0, 0, 'Farm Lane, 1st floor (Shop)', 80000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2919, 0, -1, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 50000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2920, 0, -1, 0, 0, 'Farm Lane, Basement (Shop)', 50000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2921, 0, -1, 0, 0, 'Fibula Village 1', 25000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2922, 0, -1, 0, 0, 'Fibula Village 2', 25000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2923, 0, -1, 0, 0, 'Fibula Village 4', 25000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2924, 0, -1, 0, 0, 'Fibula Village 5', 50000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2925, 0, -1, 0, 0, 'Fibula Village 3', 80000, 8, 54, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2926, 0, -1, 0, 0, 'Fibula Village, Tower Flat', 100000, 8, 78, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2927, 0, -1, 0, 0, 'Guildhall of the Red Rose', 250000, 8, 405, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2928, 0, -1, 0, 0, 'Fibula Village, Bar (Shop)', 100000, 8, 79, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2929, 0, -1, 0, 0, 'Fibula Village, Villa', 200000, 8, 222, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2930, 0, -1, 0, 0, 'Greenshore Village 1', 80000, 8, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2931, 0, -1, 0, 0, 'Greenshore Clanhall', 250000, 8, 165, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2932, 0, -1, 0, 0, 'Castle of Greenshore', 250000, 8, 296, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2933, 0, -1, 0, 0, 'Greenshore Village, Shop', 80000, 8, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2934, 0, -1, 0, 0, 'Greenshore Village, Villa', 300000, 8, 155, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2935, 0, -1, 0, 0, 'Greenshore Village 7', 25000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2936, 0, -1, 0, 0, 'Greenshore Village 3', 50000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2939, 0, -1, 0, 0, 'Greenshore Village 2', 50000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2940, 0, -1, 0, 0, 'Greenshore Village 6', 150000, 8, 71, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2941, 0, -1, 0, 0, 'Harbour Place 1 (Shop)', 800000, 8, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2942, 0, -1, 0, 0, 'Harbour Place 2 (Shop)', 600000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2943, 0, -1, 0, 0, 'Harbour Place 3', 800000, 8, 87, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2944, 0, -1, 0, 0, 'Harbour Place 4', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2945, 0, -1, 0, 0, 'Lower Swamp Lane 1', 400000, 8, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2946, 0, -1, 0, 0, 'Lower Swamp Lane 3', 400000, 8, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2947, 0, -1, 0, 0, 'Main Street 9, 1st floor (Shop)', 200000, 8, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2948, 0, -1, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 100000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2949, 0, -1, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 150000, 8, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2950, 0, -1, 0, 0, 'Mill Avenue 1 (Shop)', 200000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2951, 0, -1, 0, 0, 'Mill Avenue 2 (Shop)', 200000, 8, 45, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2952, 0, -1, 0, 0, 'Mill Avenue 3', 100000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2953, 0, -1, 0, 0, 'Mill Avenue 4', 100000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2954, 0, -1, 0, 0, 'Mill Avenue 5', 300000, 8, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2955, 0, -1, 0, 0, 'Open-Air Theatre', 150000, 8, 60, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2956, 0, -1, 0, 0, 'Smuggler\'s Den', 400000, 8, 219, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2957, 0, -1, 0, 0, 'Sorcerer\'s Avenue 1a', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2958, 0, -1, 0, 0, 'Sorcerer\'s Avenue 5 (Shop)', 150000, 8, 49, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2959, 0, -1, 0, 0, 'Sorcerer\'s Avenue 1b', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2960, 0, -1, 0, 0, 'Sorcerer\'s Avenue 1c', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2961, 0, -1, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 50000, 8, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2962, 0, -1, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 50000, 8, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2963, 0, -1, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 50000, 8, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2964, 0, -1, 0, 0, 'Sunset Homes, Flat 01', 100000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2965, 0, -1, 0, 0, 'Sunset Homes, Flat 02', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2966, 0, -1, 0, 0, 'Sunset Homes, Flat 03', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2967, 0, -1, 0, 0, 'Sunset Homes, Flat 11', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2968, 0, -1, 0, 0, 'Sunset Homes, Flat 12', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2969, 0, -1, 0, 0, 'Sunset Homes, Flat 13', 100000, 8, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2970, 0, -1, 0, 0, 'Sunset Homes, Flat 14', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2971, 0, -1, 0, 0, 'Sunset Homes, Flat 21', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2972, 0, -1, 0, 0, 'Sunset Homes, Flat 22', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2973, 0, -1, 0, 0, 'Sunset Homes, Flat 23', 80000, 8, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2974, 0, -1, 0, 0, 'Sunset Homes, Flat 24', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2975, 0, -1, 0, 0, 'Thais Hostel', 200000, 8, 117, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2976, 0, -1, 0, 0, 'The City Wall 1a', 150000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2977, 0, -1, 0, 0, 'The City Wall 1b', 100000, 8, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2978, 0, -1, 0, 0, 'The City Wall 3a', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2979, 0, -1, 0, 0, 'The City Wall 3b', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2980, 0, -1, 0, 0, 'The City Wall 3c', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2981, 0, -1, 0, 0, 'The City Wall 3d', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2982, 0, -1, 0, 0, 'The City Wall 3e', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2983, 0, -1, 0, 0, 'The City Wall 3f', 100000, 8, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2984, 0, -1, 0, 0, 'Upper Swamp Lane 12', 300000, 8, 60, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2985, 0, -1, 0, 0, 'Upper Swamp Lane 10', 150000, 8, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2986, 0, -1, 0, 0, 'Upper Swamp Lane 8', 600000, 8, 132, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2987, 0, -1, 0, 0, 'Upper Swamp Lane 4', 600000, 8, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2988, 0, -1, 0, 0, 'Upper Swamp Lane 2', 600000, 8, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2989, 0, -1, 0, 0, 'The City Wall 9', 80000, 8, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2990, 0, -1, 0, 0, 'The City Wall 7h', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2991, 0, -1, 0, 0, 'The City Wall 7b', 25000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2992, 0, -1, 0, 0, 'The City Wall 7d', 50000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2993, 0, -1, 0, 0, 'The City Wall 7f', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2994, 0, -1, 0, 0, 'The City Wall 7c', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2995, 0, -1, 0, 0, 'The City Wall 7a', 80000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2996, 0, -1, 0, 0, 'The City Wall 7g', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2997, 0, -1, 0, 0, 'The City Wall 7e', 80000, 8, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2998, 0, -1, 0, 0, 'The City Wall 5b', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(2999, 0, -1, 0, 0, 'The City Wall 5d', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3000, 0, -1, 0, 0, 'The City Wall 5f', 25000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3001, 0, -1, 0, 0, 'The City Wall 5a', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3002, 0, -1, 0, 0, 'The City Wall 5c', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3003, 0, -1, 0, 0, 'The City Wall 5e', 50000, 8, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3004, 0, -1, 0, 0, 'Warriors\' Guildhall', 5000000, 8, 307, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3005, 0, -1, 0, 0, 'The Tibianic', 500000, 8, 540, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3006, 0, -1, 0, 0, 'Bloodhall', 500000, 8, 306, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3007, 0, -1, 0, 0, 'Fibula Clanhall', 250000, 8, 162, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3008, 0, -1, 0, 0, 'Dark Mansion', 1000000, 8, 361, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3009, 0, -1, 0, 0, 'Halls of the Adventurers', 250000, 8, 304, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3010, 0, -1, 0, 0, 'Mercenary Tower', 250000, 8, 607, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3011, 0, -1, 0, 0, 'Snake Tower', 500000, 8, 616, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3012, 0, -1, 0, 0, 'Southern Thais Guildhall', 1000000, 8, 349, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3013, 0, -1, 0, 0, 'Spiritkeep', 500000, 8, 382, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3014, 0, -1, 0, 0, 'Thais Clanhall', 500000, 8, 188, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3015, 0, -1, 0, 0, 'The Lair', 200000, 9, 166, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3016, 0, -1, 0, 0, 'Silver Street 4', 300000, 9, 71, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3017, 0, -1, 0, 0, 'Dream Street 1 (Shop)', 600000, 9, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3018, 0, -1, 0, 0, 'Dagger Alley 1', 200000, 9, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3019, 0, -1, 0, 0, 'Dream Street 2', 400000, 9, 72, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3020, 0, -1, 0, 0, 'Dream Street 3', 300000, 9, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3021, 0, -1, 0, 0, 'Elm Street 1', 300000, 9, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3022, 0, -1, 0, 0, 'Elm Street 3', 300000, 9, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3023, 0, -1, 0, 0, 'Elm Street 2', 300000, 9, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3024, 0, -1, 0, 0, 'Elm Street 4', 300000, 9, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3025, 0, -1, 0, 0, 'Seagull Walk 1', 800000, 9, 111, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3026, 0, -1, 0, 0, 'Seagull Walk 2', 300000, 9, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3027, 0, -1, 0, 0, 'Dream Street 4', 400000, 9, 77, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3028, 0, -1, 0, 0, 'Old Lighthouse', 200000, 9, 78, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3029, 0, -1, 0, 0, 'Market Street 1', 600000, 9, 144, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3030, 0, -1, 0, 0, 'Market Street 3', 600000, 9, 75, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3031, 0, -1, 0, 0, 'Market Street 4 (Shop)', 800000, 9, 109, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3032, 0, -1, 0, 0, 'Market Street 5 (Shop)', 800000, 9, 135, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3033, 0, -1, 0, 0, 'Market Street 2', 600000, 9, 105, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3034, 0, -1, 0, 0, 'Loot Lane 1 (Shop)', 600000, 9, 97, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3035, 0, -1, 0, 0, 'Mystic Lane 1', 300000, 9, 61, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3036, 0, -1, 0, 0, 'Mystic Lane 2', 200000, 9, 64, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3037, 0, -1, 0, 0, 'Lucky Lane 2 (Tower)', 600000, 9, 118, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3038, 0, -1, 0, 0, 'Lucky Lane 3 (Tower)', 600000, 9, 118, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3039, 0, -1, 0, 0, 'Iron Alley 1', 300000, 9, 70, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3040, 0, -1, 0, 0, 'Iron Alley 2', 300000, 9, 70, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3041, 0, -1, 0, 0, 'Swamp Watch', 500000, 9, 222, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3042, 0, -1, 0, 0, 'Golden Axe Guildhall', 500000, 9, 213, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3043, 0, -1, 0, 0, 'Silver Street 1', 200000, 9, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3044, 0, -1, 0, 0, 'Valorous Venore', 500000, 9, 303, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3045, 0, -1, 0, 0, 'Salvation Street 2', 300000, 9, 82, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3046, 0, -1, 0, 0, 'Salvation Street 3', 300000, 9, 82, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3047, 0, -1, 0, 0, 'Silver Street 2', 200000, 9, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3048, 0, -1, 0, 0, 'Silver Street 3', 200000, 9, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3049, 0, -1, 0, 0, 'Mystic Lane 3 (Tower)', 800000, 9, 118, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3050, 0, -1, 0, 0, 'Market Street 7', 200000, 9, 49, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3051, 0, -1, 0, 0, 'Market Street 6', 600000, 9, 113, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3052, 0, -1, 0, 0, 'Iron Alley Watch, Upper', 600000, 9, 114, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3053, 0, -1, 0, 0, 'Iron Alley Watch, Lower', 600000, 9, 115, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3054, 0, -1, 0, 0, 'Blessed Shield Guildhall', 500000, 9, 162, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3055, 0, -1, 0, 0, 'Steel Home', 500000, 9, 281, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3056, 0, -1, 0, 0, 'Salvation Street 1 (Shop)', 600000, 9, 132, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3057, 0, -1, 0, 0, 'Lucky Lane 1 (Shop)', 800000, 9, 148, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3058, 0, -1, 0, 0, 'Paupers Palace, Flat 34', 100000, 9, 35, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3059, 0, -1, 0, 0, 'Paupers Palace, Flat 33', 50000, 9, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3060, 0, -1, 0, 0, 'Paupers Palace, Flat 32', 100000, 9, 23, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3061, 0, -1, 0, 0, 'Paupers Palace, Flat 31', 80000, 9, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3062, 0, -1, 0, 0, 'Paupers Palace, Flat 28', 25000, 9, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3063, 0, -1, 0, 0, 'Paupers Palace, Flat 26', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3064, 0, -1, 0, 0, 'Paupers Palace, Flat 24', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3065, 0, -1, 0, 0, 'Paupers Palace, Flat 22', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3066, 0, -1, 0, 0, 'Paupers Palace, Flat 21', 25000, 9, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3067, 0, -1, 0, 0, 'Paupers Palace, Flat 27', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3068, 0, -1, 0, 0, 'Paupers Palace, Flat 25', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3069, 0, -1, 0, 0, 'Paupers Palace, Flat 23', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3070, 0, -1, 0, 0, 'Paupers Palace, Flat 11', 25000, 9, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3071, 0, -1, 0, 0, 'Paupers Palace, Flat 13', 50000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3072, 0, -1, 0, 0, 'Paupers Palace, Flat 15', 50000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3073, 0, -1, 0, 0, 'Paupers Palace, Flat 17', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3074, 0, -1, 0, 0, 'Paupers Palace, Flat 18', 25000, 9, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3075, 0, -1, 0, 0, 'Paupers Palace, Flat 12', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3076, 0, -1, 0, 0, 'Paupers Palace, Flat 14', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3077, 0, -1, 0, 0, 'Paupers Palace, Flat 16', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3078, 0, -1, 0, 0, 'Paupers Palace, Flat 06', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3079, 0, -1, 0, 0, 'Paupers Palace, Flat 05', 25000, 9, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3080, 0, -1, 0, 0, 'Paupers Palace, Flat 04', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3081, 0, -1, 0, 0, 'Paupers Palace, Flat 07', 50000, 9, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3082, 0, -1, 0, 0, 'Paupers Palace, Flat 03', 25000, 9, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3083, 0, -1, 0, 0, 'Paupers Palace, Flat 02', 25000, 9, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3084, 0, -1, 0, 0, 'Paupers Palace, Flat 01', 25000, 9, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3085, 0, -1, 0, 0, 'Castle, Residence', 600000, 11, 104, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3086, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 07', 80000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3087, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 04', 25000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3088, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 03', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3089, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 06', 100000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3090, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 05', 80000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3091, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 02', 80000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3092, 0, -1, 0, 0, 'Castle, 3rd Floor, Flat 01', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3093, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 09', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3094, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 08', 80000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3095, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 07', 80000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3096, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 04', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3097, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 03', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3098, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 06', 100000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3099, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 05', 80000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3100, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 02', 80000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3101, 0, -1, 0, 0, 'Castle, 4th Floor, Flat 01', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3102, 0, -1, 0, 0, 'Castle Street 2', 150000, 11, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3103, 0, -1, 0, 0, 'Castle Street 3', 150000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3104, 0, -1, 0, 0, 'Castle Street 4', 150000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3105, 0, -1, 0, 0, 'Castle Street 5', 150000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3106, 0, -1, 0, 0, 'Castle Street 1', 300000, 11, 60, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3107, 0, -1, 0, 0, 'Edron Flats, Flat 08', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3108, 0, -1, 0, 0, 'Edron Flats, Flat 05', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3109, 0, -1, 0, 0, 'Edron Flats, Flat 04', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3110, 0, -1, 0, 0, 'Edron Flats, Flat 01', 50000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3111, 0, -1, 0, 0, 'Edron Flats, Flat 07', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3112, 0, -1, 0, 0, 'Edron Flats, Flat 06', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3113, 0, -1, 0, 0, 'Edron Flats, Flat 03', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3114, 0, -1, 0, 0, 'Edron Flats, Flat 02', 100000, 11, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3115, 0, -1, 0, 0, 'Edron Flats, Basement Flat 2', 100000, 11, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3116, 0, -1, 0, 0, 'Edron Flats, Basement Flat 1', 100000, 11, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3119, 0, -1, 0, 0, 'Edron Flats, Flat 13', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3121, 0, -1, 0, 0, 'Edron Flats, Flat 14', 100000, 11, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3123, 0, -1, 0, 0, 'Edron Flats, Flat 12', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3124, 0, -1, 0, 0, 'Edron Flats, Flat 11', 100000, 11, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3125, 0, -1, 0, 0, 'Edron Flats, Flat 25', 80000, 11, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3127, 0, -1, 0, 0, 'Edron Flats, Flat 24', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3128, 0, -1, 0, 0, 'Edron Flats, Flat 21', 80000, 11, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3131, 0, -1, 0, 0, 'Edron Flats, Flat 23', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3133, 0, -1, 0, 0, 'Castle Shop 1', 400000, 11, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3134, 0, -1, 0, 0, 'Castle Shop 2', 400000, 11, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3135, 0, -1, 0, 0, 'Castle Shop 3', 300000, 11, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3136, 0, -1, 0, 0, 'Central Circle 1', 800000, 11, 73, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3137, 0, -1, 0, 0, 'Central Circle 2', 800000, 11, 80, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3138, 0, -1, 0, 0, 'Central Circle 3', 800000, 11, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3139, 0, -1, 0, 0, 'Central Circle 4', 800000, 11, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3140, 0, -1, 0, 0, 'Central Circle 5', 800000, 11, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3141, 0, -1, 0, 0, 'Central Circle 8 (Shop)', 400000, 11, 97, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3142, 0, -1, 0, 0, 'Central Circle 7 (Shop)', 400000, 11, 97, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3143, 0, -1, 0, 0, 'Central Circle 6 (Shop)', 400000, 11, 97, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3144, 0, -1, 0, 0, 'Central Circle 9a', 150000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3145, 0, -1, 0, 0, 'Central Circle 9b', 150000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3146, 0, -1, 0, 0, 'Sky Lane, Guild 1', 1000000, 11, 421, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3147, 0, -1, 0, 0, 'Sky Lane, Sea Tower', 300000, 11, 95, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3148, 0, -1, 0, 0, 'Sky Lane, Guild 3', 1000000, 11, 347, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3149, 0, -1, 0, 0, 'Sky Lane, Guild 2', 1000000, 11, 400, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3150, 0, -1, 0, 0, 'Wood Avenue 11', 600000, 11, 149, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3151, 0, -1, 0, 0, 'Wood Avenue 8', 800000, 11, 128, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3152, 0, -1, 0, 0, 'Wood Avenue 7', 800000, 11, 128, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3153, 0, -1, 0, 0, 'Wood Avenue 10a', 200000, 11, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3154, 0, -1, 0, 0, 'Wood Avenue 9a', 200000, 11, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3155, 0, -1, 0, 0, 'Wood Avenue 6a', 300000, 11, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3156, 0, -1, 0, 0, 'Wood Avenue 6b', 200000, 11, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3157, 0, -1, 0, 0, 'Wood Avenue 9b', 200000, 11, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3158, 0, -1, 0, 0, 'Wood Avenue 10b', 200000, 11, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3159, 0, -1, 0, 0, 'Stronghold', 800000, 11, 215, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3160, 0, -1, 0, 0, 'Wood Avenue 5', 300000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3161, 0, -1, 0, 0, 'Wood Avenue 3', 200000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3162, 0, -1, 0, 0, 'Wood Avenue 4', 200000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3163, 0, -1, 0, 0, 'Wood Avenue 2', 200000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3164, 0, -1, 0, 0, 'Wood Avenue 1', 200000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3165, 0, -1, 0, 0, 'Wood Avenue 4c', 200000, 11, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3166, 0, -1, 0, 0, 'Wood Avenue 4a', 150000, 11, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3167, 0, -1, 0, 0, 'Wood Avenue 4b', 150000, 11, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3168, 0, -1, 0, 0, 'Stonehome Village 1', 150000, 11, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3169, 0, -1, 0, 0, 'Stonehome Flats, Flat 04', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3171, 0, -1, 0, 0, 'Stonehome Flats, Flat 03', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3173, 0, -1, 0, 0, 'Stonehome Flats, Flat 02', 25000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3174, 0, -1, 0, 0, 'Stonehome Flats, Flat 01', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3175, 0, -1, 0, 0, 'Stonehome Flats, Flat 13', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3177, 0, -1, 0, 0, 'Stonehome Flats, Flat 11', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3178, 0, -1, 0, 0, 'Stonehome Flats, Flat 14', 80000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3180, 0, -1, 0, 0, 'Stonehome Flats, Flat 12', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3181, 0, -1, 0, 0, 'Stonehome Village 2', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3182, 0, -1, 0, 0, 'Stonehome Village 3', 50000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3183, 0, -1, 0, 0, 'Stonehome Village 4', 80000, 11, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3184, 0, -1, 0, 0, 'Stonehome Village 6', 100000, 11, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3185, 0, -1, 0, 0, 'Stonehome Village 5', 80000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3186, 0, -1, 0, 0, 'Stonehome Village 7', 100000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3187, 0, -1, 0, 0, 'Stonehome Village 8', 25000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3188, 0, -1, 0, 0, 'Stonehome Village 9', 50000, 11, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3189, 0, -1, 0, 0, 'Stonehome Clanhall', 250000, 11, 192, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3190, 0, -1, 0, 0, 'Mad Scientist\'s Lab', 600000, 17, 169, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3191, 0, -1, 0, 0, 'Radiant Plaza 4', 800000, 17, 186, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3192, 0, -1, 0, 0, 'Radiant Plaza 3', 800000, 17, 120, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3193, 0, -1, 0, 0, 'Radiant Plaza 2', 600000, 17, 93, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3194, 0, -1, 0, 0, 'Radiant Plaza 1', 800000, 17, 133, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3195, 0, -1, 0, 0, 'Aureate Court 3', 400000, 17, 105, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3196, 0, -1, 0, 0, 'Aureate Court 4', 400000, 17, 92, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3197, 0, -1, 0, 0, 'Aureate Court 5', 600000, 17, 142, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3198, 0, -1, 0, 0, 'Aureate Court 2', 400000, 17, 119, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3199, 0, -1, 0, 0, 'Aureate Court 1', 600000, 17, 126, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3205, 0, -1, 0, 0, 'Halls of Serenity', 5000000, 17, 504, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3206, 0, -1, 0, 0, 'Fortune Wing 3', 600000, 17, 141, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3207, 0, -1, 0, 0, 'Fortune Wing 4', 600000, 17, 141, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3208, 0, -1, 0, 0, 'Fortune Wing 2', 600000, 17, 137, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3209, 0, -1, 0, 0, 'Fortune Wing 1', 800000, 17, 247, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3211, 0, -1, 0, 0, 'Cascade Towers', 5000000, 17, 405, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3212, 0, -1, 0, 0, 'Luminous Arc 5', 800000, 17, 117, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3213, 0, -1, 0, 0, 'Luminous Arc 2', 600000, 17, 154, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3214, 0, -1, 0, 0, 'Luminous Arc 1', 800000, 17, 159, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3215, 0, -1, 0, 0, 'Luminous Arc 3', 600000, 17, 130, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3216, 0, -1, 0, 0, 'Luminous Arc 4', 800000, 17, 190, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3217, 0, -1, 0, 0, 'Harbour Promenade 1', 800000, 17, 129, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3218, 0, -1, 0, 0, 'Sun Palace', 5000000, 17, 513, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3219, 0, -1, 0, 0, 'Haggler\'s Hangout 3', 300000, 15, 145, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3220, 0, -1, 0, 0, 'Haggler\'s Hangout 7', 400000, 15, 141, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3221, 0, -1, 0, 0, 'Big Game Hunter\'s Lodge', 600000, 15, 164, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3222, 0, -1, 0, 0, 'Haggler\'s Hangout 6', 400000, 15, 123, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3223, 0, -1, 0, 0, 'Haggler\'s Hangout 5 (Shop)', 200000, 15, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3224, 0, -1, 0, 0, 'Haggler\'s Hangout 4b (Shop)', 150000, 15, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3225, 0, -1, 0, 0, 'Haggler\'s Hangout 4a (Shop)', 200000, 15, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3226, 0, -1, 0, 0, 'Haggler\'s Hangout 2', 100000, 15, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3227, 0, -1, 0, 0, 'Haggler\'s Hangout 1', 100000, 15, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3228, 0, -1, 0, 0, 'Bamboo Garden 3', 150000, 15, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3229, 0, -1, 0, 0, 'Bamboo Fortress', 500000, 15, 446, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3230, 0, -1, 0, 0, 'Bamboo Garden 2', 80000, 15, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3231, 0, -1, 0, 0, 'Bamboo Garden 1', 100000, 15, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3232, 0, -1, 0, 0, 'Banana Bay 4', 25000, 15, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3233, 0, -1, 0, 0, 'Banana Bay 2', 50000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3234, 0, -1, 0, 0, 'Banana Bay 3', 50000, 15, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3235, 0, -1, 0, 0, 'Banana Bay 1', 25000, 15, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3236, 0, -1, 0, 0, 'Crocodile Bridge 1', 80000, 15, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3237, 0, -1, 0, 0, 'Crocodile Bridge 2', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3238, 0, -1, 0, 0, 'Crocodile Bridge 3', 100000, 15, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3239, 0, -1, 0, 0, 'Crocodile Bridge 4', 300000, 15, 99, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3240, 0, -1, 0, 0, 'Crocodile Bridge 5', 200000, 15, 86, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3241, 0, -1, 0, 0, 'Woodway 1', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3242, 0, -1, 0, 0, 'Woodway 2', 50000, 15, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3243, 0, -1, 0, 0, 'Woodway 3', 150000, 15, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3244, 0, -1, 0, 0, 'Woodway 4', 25000, 15, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3245, 0, -1, 0, 0, 'Flamingo Flats 5', 150000, 15, 41, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3246, 0, -1, 0, 0, 'Flamingo Flats 4', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3247, 0, -1, 0, 0, 'Flamingo Flats 1', 50000, 15, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3248, 0, -1, 0, 0, 'Flamingo Flats 2', 80000, 15, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3249, 0, -1, 0, 0, 'Flamingo Flats 3', 50000, 15, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3250, 0, -1, 0, 0, 'Jungle Edge 1', 200000, 15, 51, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3251, 0, -1, 0, 0, 'Jungle Edge 2', 200000, 15, 66, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3252, 0, -1, 0, 0, 'Jungle Edge 4', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3253, 0, -1, 0, 0, 'Jungle Edge 5', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3254, 0, -1, 0, 0, 'Jungle Edge 6', 25000, 15, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3255, 0, -1, 0, 0, 'Jungle Edge 3', 80000, 15, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3256, 0, -1, 0, 0, 'River Homes 3', 200000, 15, 99, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3257, 0, -1, 0, 0, 'River Homes 2b', 150000, 15, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3258, 0, -1, 0, 0, 'River Homes 2a', 100000, 15, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3259, 0, -1, 0, 0, 'River Homes 1', 300000, 15, 73, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3260, 0, -1, 0, 0, 'Coconut Quay 4', 150000, 15, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3261, 0, -1, 0, 0, 'Coconut Quay 3', 200000, 15, 41, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3262, 0, -1, 0, 0, 'Coconut Quay 2', 100000, 15, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3263, 0, -1, 0, 0, 'Coconut Quay 1', 150000, 15, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `houses` (`id`, `owner`, `new_owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `size`, `guildid`, `beds`, `bidder`, `bidder_name`, `highest_bid`, `internal_bid`, `bid_end_date`, `state`, `transfer_status`) VALUES
(3264, 0, -1, 0, 0, 'Shark Manor', 250000, 15, 164, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3265, 0, -1, 0, 0, 'Glacier Side 2', 300000, 16, 91, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3266, 0, -1, 0, 0, 'Glacier Side 1', 150000, 16, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3267, 0, -1, 0, 0, 'Glacier Side 3', 150000, 16, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3268, 0, -1, 0, 0, 'Glacier Side 4', 150000, 16, 41, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3269, 0, -1, 0, 0, 'Shelf Site', 300000, 16, 92, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3270, 0, -1, 0, 0, 'Spirit Homes 5', 150000, 16, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3271, 0, -1, 0, 0, 'Spirit Homes 4', 80000, 16, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3272, 0, -1, 0, 0, 'Spirit Homes 1', 150000, 16, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3273, 0, -1, 0, 0, 'Spirit Homes 2', 150000, 16, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3274, 0, -1, 0, 0, 'Spirit Homes 3', 300000, 16, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3275, 0, -1, 0, 0, 'Arena Walk 3', 300000, 16, 67, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3276, 0, -1, 0, 0, 'Arena Walk 2', 150000, 16, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3277, 0, -1, 0, 0, 'Arena Walk 1', 300000, 16, 61, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3278, 0, -1, 0, 0, 'Bears Paw 2', 300000, 16, 49, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3279, 0, -1, 0, 0, 'Bears Paw 1', 200000, 16, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3280, 0, -1, 0, 0, 'Crystal Glance', 1000000, 16, 315, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3281, 0, -1, 0, 0, 'Shady Rocks 2', 200000, 16, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3282, 0, -1, 0, 0, 'Shady Rocks 1', 300000, 16, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3283, 0, -1, 0, 0, 'Shady Rocks 3', 300000, 16, 87, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3284, 0, -1, 0, 0, 'Shady Rocks 4 (Shop)', 200000, 16, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3285, 0, -1, 0, 0, 'Shady Rocks 5', 300000, 16, 62, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3286, 0, -1, 0, 0, 'Tusk Flats 2', 80000, 16, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3287, 0, -1, 0, 0, 'Tusk Flats 1', 80000, 16, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3288, 0, -1, 0, 0, 'Tusk Flats 3', 80000, 16, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3289, 0, -1, 0, 0, 'Tusk Flats 4', 25000, 16, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3290, 0, -1, 0, 0, 'Tusk Flats 6', 50000, 16, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3291, 0, -1, 0, 0, 'Tusk Flats 5', 25000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3292, 0, -1, 0, 0, 'Corner Shop (Shop)', 200000, 16, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3293, 0, -1, 0, 0, 'Bears Paw 5', 200000, 16, 41, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3294, 0, -1, 0, 0, 'Bears Paw 4', 400000, 16, 109, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3295, 0, -1, 0, 0, 'Trout Plaza 2', 150000, 16, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3296, 0, -1, 0, 0, 'Trout Plaza 1', 200000, 16, 51, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3297, 0, -1, 0, 0, 'Trout Plaza 5 (Shop)', 300000, 16, 84, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3298, 0, -1, 0, 0, 'Trout Plaza 3', 80000, 16, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3299, 0, -1, 0, 0, 'Trout Plaza 4', 80000, 16, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3300, 0, -1, 0, 0, 'Skiffs End 2', 80000, 16, 18, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3301, 0, -1, 0, 0, 'Skiffs End 1', 100000, 16, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3302, 0, -1, 0, 0, 'Furrier Quarter 3', 100000, 16, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3303, 0, -1, 0, 0, 'Fimbul Shelf 4', 100000, 16, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3304, 0, -1, 0, 0, 'Fimbul Shelf 3', 100000, 16, 33, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3305, 0, -1, 0, 0, 'Furrier Quarter 2', 80000, 16, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3306, 0, -1, 0, 0, 'Furrier Quarter 1', 150000, 16, 41, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3307, 0, -1, 0, 0, 'Fimbul Shelf 2', 100000, 16, 27, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3308, 0, -1, 0, 0, 'Fimbul Shelf 1', 80000, 16, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3309, 0, -1, 0, 0, 'Bears Paw 3', 200000, 16, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3310, 0, -1, 0, 0, 'Raven Corner 2', 150000, 16, 33, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3311, 0, -1, 0, 0, 'Raven Corner 1', 80000, 16, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3312, 0, -1, 0, 0, 'Raven Corner 3', 100000, 16, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3313, 0, -1, 0, 0, 'Mammoth Belly', 1000000, 16, 362, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3314, 0, -1, 0, 0, 'Darashia 3, Flat 01', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3315, 0, -1, 0, 0, 'Darashia 3, Flat 05', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3316, 0, -1, 0, 0, 'Darashia 3, Flat 02', 200000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3317, 0, -1, 0, 0, 'Darashia 3, Flat 04', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3318, 0, -1, 0, 0, 'Darashia 3, Flat 03', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3319, 0, -1, 0, 0, 'Darashia 3, Flat 12', 200000, 13, 55, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3320, 0, -1, 0, 0, 'Darashia 3, Flat 11', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3321, 0, -1, 0, 0, 'Darashia 3, Flat 14', 200000, 13, 55, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3322, 0, -1, 0, 0, 'Darashia 3, Flat 13', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3323, 0, -1, 0, 0, 'Darashia 8, Flat 01', 300000, 13, 53, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3325, 0, -1, 0, 0, 'Darashia 8, Flat 05', 300000, 13, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3326, 0, -1, 0, 0, 'Darashia 8, Flat 04', 200000, 13, 61, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3327, 0, -1, 0, 0, 'Darashia 8, Flat 03', 300000, 13, 100, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3328, 0, -1, 0, 0, 'Darashia 8, Flat 12', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3329, 0, -1, 0, 0, 'Darashia 8, Flat 11', 200000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3330, 0, -1, 0, 0, 'Darashia 8, Flat 14', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3331, 0, -1, 0, 0, 'Darashia 8, Flat 13', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3332, 0, -1, 0, 0, 'Darashia, Villa', 800000, 13, 113, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3333, 0, -1, 0, 0, 'Darashia, Eastern Guildhall', 1000000, 13, 248, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3334, 0, -1, 0, 0, 'Darashia, Western Guildhall', 500000, 13, 203, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3335, 0, -1, 0, 0, 'Darashia 2, Flat 03', 100000, 13, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3336, 0, -1, 0, 0, 'Darashia 2, Flat 02', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3337, 0, -1, 0, 0, 'Darashia 2, Flat 01', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3338, 0, -1, 0, 0, 'Darashia 2, Flat 04', 80000, 13, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3339, 0, -1, 0, 0, 'Darashia 2, Flat 05', 150000, 13, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3340, 0, -1, 0, 0, 'Darashia 2, Flat 06', 80000, 13, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3341, 0, -1, 0, 0, 'Darashia 2, Flat 07', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3342, 0, -1, 0, 0, 'Darashia 2, Flat 13', 100000, 13, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3343, 0, -1, 0, 0, 'Darashia 2, Flat 14', 50000, 13, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3344, 0, -1, 0, 0, 'Darashia 2, Flat 15', 100000, 13, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3345, 0, -1, 0, 0, 'Darashia 2, Flat 16', 80000, 13, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3346, 0, -1, 0, 0, 'Darashia 2, Flat 17', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3347, 0, -1, 0, 0, 'Darashia 2, Flat 18', 100000, 13, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3348, 0, -1, 0, 0, 'Darashia 2, Flat 11', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3349, 0, -1, 0, 0, 'Darashia 2, Flat 12', 80000, 13, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3350, 0, -1, 0, 0, 'Darashia 1, Flat 03', 300000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3351, 0, -1, 0, 0, 'Darashia 1, Flat 04', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3352, 0, -1, 0, 0, 'Darashia 1, Flat 02', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3353, 0, -1, 0, 0, 'Darashia 1, Flat 01', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3354, 0, -1, 0, 0, 'Darashia 1, Flat 05', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3355, 0, -1, 0, 0, 'Darashia 1, Flat 12', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3356, 0, -1, 0, 0, 'Darashia 1, Flat 13', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3357, 0, -1, 0, 0, 'Darashia 1, Flat 14', 200000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3358, 0, -1, 0, 0, 'Darashia 1, Flat 11', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3359, 0, -1, 0, 0, 'Darashia 5, Flat 02', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3360, 0, -1, 0, 0, 'Darashia 5, Flat 01', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3361, 0, -1, 0, 0, 'Darashia 5, Flat 05', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3362, 0, -1, 0, 0, 'Darashia 5, Flat 04', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3363, 0, -1, 0, 0, 'Darashia 5, Flat 03', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3364, 0, -1, 0, 0, 'Darashia 5, Flat 11', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3365, 0, -1, 0, 0, 'Darashia 5, Flat 12', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3366, 0, -1, 0, 0, 'Darashia 5, Flat 13', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3367, 0, -1, 0, 0, 'Darashia 5, Flat 14', 150000, 13, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3368, 0, -1, 0, 0, 'Darashia 6a', 300000, 13, 67, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3369, 0, -1, 0, 0, 'Darashia 6b', 300000, 13, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3370, 0, -1, 0, 0, 'Darashia 4, Flat 02', 200000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3371, 0, -1, 0, 0, 'Darashia 4, Flat 03', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3372, 0, -1, 0, 0, 'Darashia 4, Flat 04', 200000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3373, 0, -1, 0, 0, 'Darashia 4, Flat 05', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3374, 0, -1, 0, 0, 'Darashia 4, Flat 01', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3375, 0, -1, 0, 0, 'Darashia 4, Flat 12', 200000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3376, 0, -1, 0, 0, 'Darashia 4, Flat 11', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3377, 0, -1, 0, 0, 'Darashia 4, Flat 13', 200000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3378, 0, -1, 0, 0, 'Darashia 4, Flat 14', 150000, 13, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3379, 0, -1, 0, 0, 'Darashia 7, Flat 01', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3380, 0, -1, 0, 0, 'Darashia 7, Flat 02', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3381, 0, -1, 0, 0, 'Darashia 7, Flat 03', 200000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3382, 0, -1, 0, 0, 'Darashia 7, Flat 05', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3383, 0, -1, 0, 0, 'Darashia 7, Flat 04', 150000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3384, 0, -1, 0, 0, 'Darashia 7, Flat 12', 200000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3385, 0, -1, 0, 0, 'Darashia 7, Flat 11', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3386, 0, -1, 0, 0, 'Darashia 7, Flat 14', 200000, 13, 59, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3387, 0, -1, 0, 0, 'Darashia 7, Flat 13', 100000, 13, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3388, 0, -1, 0, 0, 'Pirate Shipwreck 1', 800000, 13, 147, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3389, 0, -1, 0, 0, 'Pirate Shipwreck 2', 800000, 13, 177, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3390, 0, -1, 0, 0, 'The Shelter', 250000, 14, 353, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3391, 0, -1, 0, 0, 'Litter Promenade 1', 25000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3392, 0, -1, 0, 0, 'Litter Promenade 2', 50000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3394, 0, -1, 0, 0, 'Litter Promenade 3', 25000, 14, 15, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3395, 0, -1, 0, 0, 'Litter Promenade 4', 25000, 14, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3396, 0, -1, 0, 0, 'Rum Alley 3', 25000, 14, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3397, 0, -1, 0, 0, 'Straycat\'s Corner 5', 80000, 14, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3398, 0, -1, 0, 0, 'Straycat\'s Corner 6', 25000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3399, 0, -1, 0, 0, 'Litter Promenade 5', 25000, 14, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3401, 0, -1, 0, 0, 'Straycat\'s Corner 4', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3402, 0, -1, 0, 0, 'Straycat\'s Corner 2', 50000, 14, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3403, 0, -1, 0, 0, 'Straycat\'s Corner 1', 25000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3404, 0, -1, 0, 0, 'Rum Alley 2', 25000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3405, 0, -1, 0, 0, 'Rum Alley 1', 25000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3406, 0, -1, 0, 0, 'Smuggler Backyard 3', 50000, 14, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3407, 0, -1, 0, 0, 'Shady Trail 3', 25000, 14, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3408, 0, -1, 0, 0, 'Shady Trail 1', 100000, 14, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3409, 0, -1, 0, 0, 'Shady Trail 2', 25000, 14, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3410, 0, -1, 0, 0, 'Smuggler Backyard 4', 25000, 14, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3411, 0, -1, 0, 0, 'Smuggler Backyard 2', 25000, 14, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3412, 0, -1, 0, 0, 'Smuggler Backyard 1', 25000, 14, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3413, 0, -1, 0, 0, 'Smuggler Backyard 5', 25000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3414, 0, -1, 0, 0, 'Sugar Street 1', 200000, 14, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3415, 0, -1, 0, 0, 'Sugar Street 2', 150000, 14, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3416, 0, -1, 0, 0, 'Sugar Street 3a', 100000, 14, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3417, 0, -1, 0, 0, 'Sugar Street 3b', 150000, 14, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3418, 0, -1, 0, 0, 'Sugar Street 4d', 50000, 14, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3419, 0, -1, 0, 0, 'Sugar Street 4c', 25000, 14, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3420, 0, -1, 0, 0, 'Sugar Street 4b', 100000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3421, 0, -1, 0, 0, 'Sugar Street 4a', 80000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3422, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 01', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3423, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 03', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3424, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 05', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3425, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 06', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3426, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 04', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3427, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 02', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3428, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 07', 80000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3429, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 09', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3430, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 11', 25000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3431, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 08', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3432, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 10', 50000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3433, 0, -1, 0, 0, 'Harvester\'s Haven, Flat 12', 25000, 14, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3434, 0, -1, 0, 0, 'Marble Lane 3', 600000, 14, 141, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3435, 0, -1, 0, 0, 'Marble Lane 2', 400000, 14, 113, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3436, 0, -1, 0, 0, 'Marble Lane 4', 400000, 14, 110, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3437, 0, -1, 0, 0, 'Admiral\'s Avenue 1', 400000, 14, 91, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3438, 0, -1, 0, 0, 'Admiral\'s Avenue 2', 400000, 14, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3439, 0, -1, 0, 0, 'Admiral\'s Avenue 3', 300000, 14, 73, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3440, 0, -1, 0, 0, 'Ivory Circle 1', 400000, 14, 76, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3441, 0, -1, 0, 0, 'Sugar Street 5', 150000, 14, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3442, 0, -1, 0, 0, 'Freedom Street 1', 200000, 14, 47, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3443, 0, -1, 0, 0, 'Trader\'s Point 1', 200000, 14, 42, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3444, 0, -1, 0, 0, 'Trader\'s Point 2 (Shop)', 600000, 14, 105, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3445, 0, -1, 0, 0, 'Trader\'s Point 3 (Shop)', 600000, 14, 117, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3446, 0, -1, 0, 0, 'Ivory Mansion', 800000, 14, 265, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3447, 0, -1, 0, 0, 'Ivory Circle 2', 400000, 14, 126, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3448, 0, -1, 0, 0, 'Ivy Cottage', 500000, 14, 563, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3449, 0, -1, 0, 0, 'Marble Lane 1', 600000, 14, 192, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3450, 0, -1, 0, 0, 'Freedom Street 2', 400000, 14, 115, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3452, 0, -1, 0, 0, 'Meriana Beach', 150000, 14, 146, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3453, 0, -1, 0, 0, 'The Tavern 1a', 150000, 14, 49, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3454, 0, -1, 0, 0, 'The Tavern 1b', 100000, 14, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3455, 0, -1, 0, 0, 'The Tavern 1c', 200000, 14, 79, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3456, 0, -1, 0, 0, 'The Tavern 1d', 100000, 14, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3457, 0, -1, 0, 0, 'The Tavern 2a', 300000, 14, 103, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3458, 0, -1, 0, 0, 'The Tavern 2b', 100000, 14, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3459, 0, -1, 0, 0, 'The Tavern 2d', 100000, 14, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3460, 0, -1, 0, 0, 'The Tavern 2c', 50000, 14, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3461, 0, -1, 0, 0, 'The Yeah Beach Project', 150000, 14, 115, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3462, 0, -1, 0, 0, 'Mountain Hideout', 500000, 14, 279, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3463, 0, -1, 0, 0, 'Darashia 8, Flat 02', 300000, 13, 73, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3464, 0, -1, 0, 0, 'Castle, Basement, Flat 01', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3465, 0, -1, 0, 0, 'Castle, Basement, Flat 02', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3466, 0, -1, 0, 0, 'Castle, Basement, Flat 03', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3467, 0, -1, 0, 0, 'Castle, Basement, Flat 05', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3468, 0, -1, 0, 0, 'Castle, Basement, Flat 04', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3469, 0, -1, 0, 0, 'Castle, Basement, Flat 06', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3470, 0, -1, 0, 0, 'Castle, Basement, Flat 07', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3471, 0, -1, 0, 0, 'Castle, Basement, Flat 09', 25000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3472, 0, -1, 0, 0, 'Castle, Basement, Flat 08', 50000, 11, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3473, 0, -1, 0, 0, 'Cormaya 1', 150000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3474, 0, -1, 0, 0, 'Cormaya Flats, Flat 01', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3475, 0, -1, 0, 0, 'Cormaya Flats, Flat 02', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3476, 0, -1, 0, 0, 'Cormaya Flats, Flat 03', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3477, 0, -1, 0, 0, 'Cormaya Flats, Flat 06', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3478, 0, -1, 0, 0, 'Cormaya Flats, Flat 05', 25000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3479, 0, -1, 0, 0, 'Cormaya Flats, Flat 04', 50000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3480, 0, -1, 0, 0, 'Cormaya Flats, Flat 11', 100000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3482, 0, -1, 0, 0, 'Cormaya Flats, Flat 13', 25000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3483, 0, -1, 0, 0, 'Cormaya Flats, Flat 12', 100000, 11, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3485, 0, -1, 0, 0, 'Cormaya Flats, Flat 14', 25000, 11, 16, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3486, 0, -1, 0, 0, 'Cormaya 2', 300000, 11, 78, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3487, 0, -1, 0, 0, 'Cormaya 4', 150000, 11, 36, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3488, 0, -1, 0, 0, 'Cormaya 3', 200000, 11, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3489, 0, -1, 0, 0, 'Cormaya 6', 200000, 11, 51, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3490, 0, -1, 0, 0, 'Cormaya 7', 200000, 11, 51, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3491, 0, -1, 0, 0, 'Cormaya 8', 200000, 11, 58, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3492, 0, -1, 0, 0, 'Cormaya 5', 300000, 11, 115, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3493, 0, -1, 0, 0, 'Castle of the White Dragon', 1000000, 11, 518, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3494, 0, -1, 0, 0, 'Cormaya 9b', 150000, 11, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3495, 0, -1, 0, 0, 'Cormaya 9a', 80000, 11, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3496, 0, -1, 0, 0, 'Cormaya 9d', 150000, 11, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3497, 0, -1, 0, 0, 'Cormaya 9c', 80000, 11, 25, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3498, 0, -1, 0, 0, 'Cormaya 10', 300000, 11, 80, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3499, 0, -1, 0, 0, 'Cormaya 11', 150000, 11, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3500, 0, -1, 0, 0, 'Edron Flats, Flat 22', 50000, 11, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3501, 0, -1, 0, 0, 'Magic Academy, Shop', 150000, 11, 29, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3502, 0, -1, 0, 0, 'Magic Academy, Flat 1', 100000, 11, 23, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3503, 0, -1, 0, 0, 'Magic Academy, Guild', 500000, 11, 195, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3504, 0, -1, 0, 0, 'Magic Academy, Flat 2', 80000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3505, 0, -1, 0, 0, 'Magic Academy, Flat 3', 100000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3506, 0, -1, 0, 0, 'Magic Academy, Flat 4', 100000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3507, 0, -1, 0, 0, 'Magic Academy, Flat 5', 80000, 11, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3508, 0, -1, 0, 0, 'Oskahl I f', 100000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3509, 0, -1, 0, 0, 'Oskahl I g', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3510, 0, -1, 0, 0, 'Oskahl I h', 150000, 10, 39, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3511, 0, -1, 0, 0, 'Oskahl I i', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3512, 0, -1, 0, 0, 'Oskahl I j', 80000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3513, 0, -1, 0, 0, 'Oskahl I b', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3514, 0, -1, 0, 0, 'Oskahl I d', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3515, 0, -1, 0, 0, 'Oskahl I e', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3516, 0, -1, 0, 0, 'Oskahl I c', 80000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3517, 0, -1, 0, 0, 'Chameken I', 100000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3518, 0, -1, 0, 0, 'Chameken II', 80000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3519, 0, -1, 0, 0, 'Charsirakh III', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3520, 0, -1, 0, 0, 'Charsirakh II', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3521, 0, -1, 0, 0, 'Murkhol I a', 80000, 10, 23, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3523, 0, -1, 0, 0, 'Murkhol I c', 50000, 10, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3524, 0, -1, 0, 0, 'Murkhol I b', 50000, 10, 11, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3525, 0, -1, 0, 0, 'Charsirakh I b', 150000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3526, 0, -1, 0, 0, 'Harrah I', 250000, 10, 121, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3527, 0, -1, 0, 0, 'Thanah I d', 200000, 10, 52, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3528, 0, -1, 0, 0, 'Thanah I c', 200000, 10, 61, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3529, 0, -1, 0, 0, 'Thanah I b', 150000, 10, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3530, 0, -1, 0, 0, 'Thanah I a', 25000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3531, 0, -1, 0, 0, 'Othehothep I c', 150000, 10, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3532, 0, -1, 0, 0, 'Othehothep I d', 150000, 10, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3533, 0, -1, 0, 0, 'Othehothep I b', 100000, 10, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3534, 0, -1, 0, 0, 'Othehothep II c', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3535, 0, -1, 0, 0, 'Othehothep II d', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3536, 0, -1, 0, 0, 'Othehothep II e', 150000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3537, 0, -1, 0, 0, 'Othehothep II f', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3538, 0, -1, 0, 0, 'Othehothep II b', 150000, 10, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3539, 0, -1, 0, 0, 'Othehothep II a', 25000, 10, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3540, 0, -1, 0, 0, 'Mothrem I', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3541, 0, -1, 0, 0, 'Arakmehn I', 100000, 10, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3542, 0, -1, 0, 0, 'Arakmehn II', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3543, 0, -1, 0, 0, 'Arakmehn III', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3544, 0, -1, 0, 0, 'Arakmehn IV', 100000, 10, 28, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3545, 0, -1, 0, 0, 'Unklath II b', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3546, 0, -1, 0, 0, 'Unklath II c', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3547, 0, -1, 0, 0, 'Unklath II d', 100000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3548, 0, -1, 0, 0, 'Unklath II a', 50000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3549, 0, -1, 0, 0, 'Rathal I b', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3550, 0, -1, 0, 0, 'Rathal I c', 25000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3551, 0, -1, 0, 0, 'Rathal I d', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3552, 0, -1, 0, 0, 'Rathal I e', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3553, 0, -1, 0, 0, 'Rathal I a', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3554, 0, -1, 0, 0, 'Rathal II b', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3555, 0, -1, 0, 0, 'Rathal II c', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3556, 0, -1, 0, 0, 'Rathal II d', 100000, 10, 34, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3557, 0, -1, 0, 0, 'Rathal II a', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3558, 0, -1, 0, 0, 'Esuph I', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3559, 0, -1, 0, 0, 'Esuph II b', 100000, 10, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3560, 0, -1, 0, 0, 'Esuph II a', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3561, 0, -1, 0, 0, 'Esuph III b', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3562, 0, -1, 0, 0, 'Esuph III a', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3564, 0, -1, 0, 0, 'Esuph IV c', 80000, 10, 23, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3565, 0, -1, 0, 0, 'Esuph IV d', 25000, 10, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3566, 0, -1, 0, 0, 'Esuph IV a', 25000, 10, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3567, 0, -1, 0, 0, 'Horakhal', 250000, 10, 203, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3568, 0, -1, 0, 0, 'Botham II d', 100000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3569, 0, -1, 0, 0, 'Botham II e', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3570, 0, -1, 0, 0, 'Botham II f', 80000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3571, 0, -1, 0, 0, 'Botham II g', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3572, 0, -1, 0, 0, 'Botham II c', 100000, 10, 23, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3573, 0, -1, 0, 0, 'Botham II b', 100000, 10, 30, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3574, 0, -1, 0, 0, 'Botham II a', 25000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3575, 0, -1, 0, 0, 'Botham III f', 150000, 10, 43, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3576, 0, -1, 0, 0, 'Botham III h', 200000, 10, 71, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3577, 0, -1, 0, 0, 'Botham III g', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3578, 0, -1, 0, 0, 'Botham III b', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3579, 0, -1, 0, 0, 'Botham III c', 25000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3581, 0, -1, 0, 0, 'Botham III e', 100000, 10, 38, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3582, 0, -1, 0, 0, 'Botham III a', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3583, 0, -1, 0, 0, 'Botham IV f', 100000, 10, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3584, 0, -1, 0, 0, 'Botham IV h', 100000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3585, 0, -1, 0, 0, 'Botham IV i', 150000, 10, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3586, 0, -1, 0, 0, 'Botham IV g', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3587, 0, -1, 0, 0, 'Botham IV e', 100000, 10, 84, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3591, 0, -1, 0, 0, 'Botham IV a', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3592, 0, -1, 0, 0, 'Ramen Tah', 250000, 10, 124, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3593, 0, -1, 0, 0, 'Botham I c', 150000, 10, 32, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3594, 0, -1, 0, 0, 'Botham I e', 80000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3595, 0, -1, 0, 0, 'Botham I d', 150000, 10, 57, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3596, 0, -1, 0, 0, 'Botham I b', 150000, 10, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3597, 0, -1, 0, 0, 'Botham I a', 50000, 10, 19, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3598, 0, -1, 0, 0, 'Charsirakh I a', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3599, 0, -1, 0, 0, 'Low Waters Observatory', 400000, 10, 480, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3600, 0, -1, 0, 0, 'Oskahl I a', 150000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3601, 0, -1, 0, 0, 'Othehothep I a', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3602, 0, -1, 0, 0, 'Othehothep III a', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3603, 0, -1, 0, 0, 'Othehothep III b', 80000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3604, 0, -1, 0, 0, 'Othehothep III c', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3605, 0, -1, 0, 0, 'Othehothep III d', 80000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3606, 0, -1, 0, 0, 'Othehothep III e', 50000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3607, 0, -1, 0, 0, 'Othehothep III f', 50000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3608, 0, -1, 0, 0, 'Unklath I f', 100000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3609, 0, -1, 0, 0, 'Unklath I g', 100000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3610, 0, -1, 0, 0, 'Unklath I d', 150000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3611, 0, -1, 0, 0, 'Unklath I e', 150000, 10, 37, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3612, 0, -1, 0, 0, 'Unklath I b', 100000, 10, 34, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3613, 0, -1, 0, 0, 'Unklath I c', 100000, 10, 34, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3614, 0, -1, 0, 0, 'Unklath I a', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3615, 0, -1, 0, 0, 'Thanah II a', 25000, 10, 17, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3616, 0, -1, 0, 0, 'Thanah II b', 50000, 10, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3617, 0, -1, 0, 0, 'Thanah II d', 50000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3618, 0, -1, 0, 0, 'Thanah II e', 25000, 10, 7, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3619, 0, -1, 0, 0, 'Thanah II c', 25000, 10, 9, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3620, 0, -1, 0, 0, 'Thanah II f', 150000, 10, 53, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3621, 0, -1, 0, 0, 'Thanah II g', 100000, 10, 31, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3622, 0, -1, 0, 0, 'Thanah II h', 100000, 10, 26, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3623, 0, -1, 0, 0, 'Thrarhor I a (Shop)', 50000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3624, 0, -1, 0, 0, 'Thrarhor I c (Shop)', 50000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3625, 0, -1, 0, 0, 'Thrarhor I d (Shop)', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3626, 0, -1, 0, 0, 'Thrarhor I b (Shop)', 50000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3627, 0, -1, 0, 0, 'Uthemath I a', 25000, 10, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3628, 0, -1, 0, 0, 'Uthemath I b', 50000, 10, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3629, 0, -1, 0, 0, 'Uthemath I c', 80000, 10, 20, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3630, 0, -1, 0, 0, 'Uthemath I d', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3631, 0, -1, 0, 0, 'Uthemath I e', 80000, 10, 21, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3632, 0, -1, 0, 0, 'Uthemath I f', 150000, 10, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3633, 0, -1, 0, 0, 'Uthemath II', 250000, 10, 94, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3634, 0, -1, 0, 0, 'Marketplace 1', 400000, 22, 74, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3635, 0, -1, 0, 0, 'Marketplace 2', 400000, 22, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3636, 0, -1, 0, 0, 'Quay 1', 200000, 22, 124, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3637, 0, -1, 0, 0, 'Quay 2', 200000, 22, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3638, 0, -1, 0, 0, 'Halls of Sun and Sea', 1000000, 22, 369, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3639, 0, -1, 0, 0, 'Palace Vicinity', 200000, 22, 114, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3640, 0, -1, 0, 0, 'Wave Tower', 400000, 22, 178, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3641, 0, -1, 0, 0, 'Old Sanctuary of God King Qjell', 300000, 18, 537, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3642, 0, -1, 0, 0, 'Old Heritage Estate', 600000, 20, 255, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3643, 0, -1, 0, 0, 'Rathleton Plaza 4', 400000, 20, 109, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3644, 0, -1, 0, 0, 'Rathleton Plaza 3', 400000, 20, 123, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3645, 0, -1, 0, 0, 'Rathleton Plaza 2', 400000, 20, 56, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3646, 0, -1, 0, 0, 'Rathleton Plaza 1', 300000, 20, 62, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3647, 0, -1, 0, 0, 'Antimony Lane 2', 400000, 20, 101, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3648, 0, -1, 0, 0, 'Antimony Lane 1', 400000, 20, 149, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3649, 0, -1, 0, 0, 'Wallside Residence', 400000, 20, 144, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3650, 0, -1, 0, 0, 'Wallside Lane 1', 800000, 20, 162, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3651, 0, -1, 0, 0, 'Wallside Lane 2', 600000, 20, 181, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3652, 0, -1, 0, 0, 'Vanward Flats B', 400000, 20, 158, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3653, 0, -1, 0, 0, 'Vanward Flats A', 400000, 20, 158, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3654, 0, -1, 0, 0, 'Bronze Brothers Bastion', 5000000, 20, 749, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3655, 0, -1, 0, 0, 'Cistern Ave', 300000, 20, 81, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3656, 0, -1, 0, 0, 'Antimony Lane 4', 400000, 20, 110, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3657, 0, -1, 0, 0, 'Antimony Lane 3', 400000, 20, 77, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3658, 0, -1, 0, 0, 'Rathleton Hills Residence', 400000, 20, 155, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3659, 0, -1, 0, 0, 'Rathleton Hills Estate', 1000000, 20, 433, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3660, 0, -1, 0, 0, 'Lion\'s Head Reef', 400000, 14, 149, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3661, 0, -1, 0, 0, 'Shadow Caves 1', 50000, 5, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3662, 0, -1, 0, 0, 'Shadow Caves 2', 50000, 5, 22, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3663, 0, -1, 0, 0, 'Shadow Caves 3', 100000, 5, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3664, 0, -1, 0, 0, 'Shadow Caves 4', 100000, 5, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3665, 0, -1, 0, 0, 'Shadow Caves 5', 100000, 5, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3666, 0, -1, 0, 0, 'Shadow Caves 6', 100000, 5, 44, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3667, 0, -1, 0, 0, 'Northport Clanhall', 250000, 6, 162, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3668, 0, -1, 0, 0, 'The Treehouse', 250000, 15, 548, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3669, 0, -1, 0, 0, 'Frost Manor', 500000, 16, 434, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3670, 0, -1, 0, 0, 'Hare\'s Den', 150000, 7, 180, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3671, 0, -1, 0, 0, 'Lost Cavern', 200000, 7, 471, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3673, 0, -1, 0, 0, 'Caveman Shelter', 150000, 12, 87, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3674, 0, -1, 0, 0, 'Eastern House of Tranquility', 200000, 12, 268, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3675, 0, -1, 0, 0, 'Lakeside Mansion', 300000, 16, 149, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3676, 0, -1, 0, 0, 'Pilchard Bin 1', 80000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3677, 0, -1, 0, 0, 'Pilchard Bin 2', 50000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3678, 0, -1, 0, 0, 'Pilchard Bin 3', 50000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3679, 0, -1, 0, 0, 'Pilchard Bin 4', 50000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3680, 0, -1, 0, 0, 'Pilchard Bin 5', 80000, 16, 13, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3681, 0, -1, 0, 0, 'Pilchard Bin 6', 25000, 16, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3682, 0, -1, 0, 0, 'Pilchard Bin 7', 25000, 16, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3683, 0, -1, 0, 0, 'Pilchard Bin 8', 25000, 16, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3684, 0, -1, 0, 0, 'Pilchard Bin 9', 50000, 16, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3685, 0, -1, 0, 0, 'Pilchard Bin 10', 50000, 16, 10, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3686, 0, -1, 0, 0, 'Mammoth House', 300000, 16, 176, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3687, 0, -1, 0, 0, 'Cherry Cake Tower', 800000, 29, 153, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3688, 0, -1, 0, 0, 'Blueberry Bay', 600000, 29, 130, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3689, 0, -1, 0, 0, 'Vanilla Beach', 600000, 29, 129, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3690, 0, -1, 0, 0, 'Centre 1', 600000, 30, 126, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3691, 0, -1, 0, 0, 'Centre 2', 600000, 30, 139, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3693, 0, -1, 0, 0, 'Cliffside', 600000, 31, 203, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3694, 0, -1, 0, 0, 'House of the Rising Moon', 1000000, 31, 340, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3695, 0, -1, 0, 0, 'Marketplace 3', 400000, 22, 130, NULL, 0, 0, '', 0, 0, 0, 0, 0),
(3696, 0, -1, 0, 0, 'Hanging Gardens 1', 400000, 22, 178, NULL, 0, 0, '', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `version` bigint(20) NOT NULL DEFAULT 0,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `kv_store`
--

CREATE TABLE `kv_store` (
  `key_name` varchar(191) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `value` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `kv_store`
--

INSERT INTO `kv_store` (`key_name`, `timestamp`, `value`) VALUES
('migrations.20231128213158_move_hireling_data_to_kv', 1755460294948, 0x3001),
('migrations.20241708000535_move_achievement_to_kv', 1755460295124, 0x3001),
('migrations.20241708362079_move_vip_system_to_kv', 1755460295279, 0x3001),
('migrations.20241708485868_move_some_storages_to_kv', 1755460295425, 0x3001),
('migrations.20241715984279_move_wheel_scrolls_from_storagename_to_kv', 1755460295617, 0x3001),
('migrations.20241715984294_quests_storages_to_kv', 1755460295767, 0x3001),
('migrations.20251737599334_reset_charms', 1755460295918, 0x3001),
('player.6.summary.hirelings.amount', 1755460329884, 0x1000),
('player.6.titles.unlocked.Admirer of the Crown', 1755460329884, 0x10e9e588c506),
('player.6.titles.unlocked.Beaststrider (Grade 1)', 1755460329882, 0x10e9e588c506),
('player.6.titles.unlocked.Beaststrider (Grade 2)', 1755460329882, 0x10e9e588c506),
('player.6.titles.unlocked.Beaststrider (Grade 3)', 1755460329882, 0x10e9e588c506),
('player.6.titles.unlocked.Beaststrider (Grade 4)', 1755460329882, 0x10e9e588c506),
('player.6.titles.unlocked.Beaststrider (Grade 5)', 1755460329882, 0x10e9e588c506),
('player.6.titles.unlocked.Big Spender', 1755460329884, 0x10e9e588c506),
('player.6.titles.unlocked.Royal Bounacean Advisor', 1755460329884, 0x10e9e588c506),
('quest.soul-war.ebb-and-flow-maps.is-active', 1755460296394, 0x3000),
('quest.soul-war.ebb-and-flow-maps.is-loaded-empty-map', 1755460296394, 0x3001);

-- --------------------------------------------------------

--
-- Estrutura para tabela `market_history`
--

CREATE TABLE `market_history` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL,
  `tier` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `price` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tier` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_account_actions`
--

CREATE TABLE `myaac_account_actions` (
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `date` int(11) NOT NULL DEFAULT 0,
  `action` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_account_actions`
--

INSERT INTO `myaac_account_actions` (`account_id`, `ip`, `ipv6`, `date`, `action`) VALUES
(2, 0, 0x00000000000000000000000000000001, 1755434081, 'Account created.'),
(2, 0, 0x00000000000000000000000000000001, 1755434196, 'Created character <b>Tester</b>.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_admin_menu`
--

CREATE TABLE `myaac_admin_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `flags` int(11) NOT NULL DEFAULT 0,
  `enabled` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_changelog`
--

CREATE TABLE `myaac_changelog` (
  `id` int(11) NOT NULL,
  `body` varchar(500) NOT NULL DEFAULT '',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',
  `where` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - server, 2 - site',
  `date` int(11) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_changelog`
--

INSERT INTO `myaac_changelog` (`id`, `body`, `type`, `where`, `date`, `player_id`, `hide`) VALUES
(1, 'MyAAC installed. (:', 3, 2, 1755434054, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_config`
--

CREATE TABLE `myaac_config` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_config`
--

INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES
(1, 'database_version', '45'),
(2, 'status_online', '1'),
(3, 'status_players', '0'),
(4, 'status_playersMax', '0'),
(5, 'status_lastCheck', '1755460532'),
(6, 'status_uptime', '14'),
(7, 'status_monsters', '81854'),
(8, 'status_uptimeReadable', 'month, day, 01h 00m'),
(9, 'status_motd', 'Welcome to the OTServBR-Global!'),
(10, 'status_mapAuthor', 'OpenTibiaBR'),
(11, 'status_mapName', 'otservbr'),
(12, 'status_mapWidth', '35143'),
(13, 'status_mapHeight', '34812'),
(14, 'status_server', 'Canary'),
(15, 'status_serverVersion', '3.0'),
(16, 'status_clientVersion', '14.12'),
(17, 'views_counter', '2'),
(18, 'last_usage_report', '1753446980');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_faq`
--

CREATE TABLE `myaac_faq` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(1020) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_faq`
--

INSERT INTO `myaac_faq` (`id`, `question`, `answer`, `ordering`, `hide`) VALUES
(1, 'What is this?', 'This is website for OTS powered by MyAAC.', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_forum`
--

CREATE TABLE `myaac_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT 0,
  `last_post` int(11) NOT NULL DEFAULT 0,
  `section` int(11) NOT NULL DEFAULT 0,
  `replies` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `author_aid` int(11) NOT NULL DEFAULT 0,
  `author_guid` int(11) NOT NULL DEFAULT 0,
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL DEFAULT '',
  `post_smile` tinyint(4) NOT NULL DEFAULT 0,
  `post_html` tinyint(4) NOT NULL DEFAULT 0,
  `post_date` int(11) NOT NULL DEFAULT 0,
  `last_edit_aid` int(11) NOT NULL DEFAULT 0,
  `edit_date` int(11) NOT NULL DEFAULT 0,
  `post_ip` varchar(45) NOT NULL DEFAULT '0.0.0.0',
  `sticked` tinyint(4) NOT NULL DEFAULT 0,
  `closed` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_forum_boards`
--

CREATE TABLE `myaac_forum_boards` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `guild` int(11) NOT NULL DEFAULT 0,
  `access` int(11) NOT NULL DEFAULT 0,
  `closed` tinyint(4) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_forum_boards`
--

INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hide`) VALUES
(1, 'News', 'News commenting', 0, 0, 0, 1, 0),
(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),
(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),
(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),
(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_gallery`
--

CREATE TABLE `myaac_gallery` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_gallery`
--

INSERT INTO `myaac_gallery` (`id`, `comment`, `image`, `thumb`, `author`, `ordering`, `hide`) VALUES
(1, 'Demon', 'images/gallery/demon.jpg', 'images/gallery/demon_thumb.gif', 'MyAAC', 1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_menu`
--

CREATE TABLE `myaac_menu` (
  `id` int(11) NOT NULL,
  `template` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `blank` tinyint(4) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '',
  `category` int(11) NOT NULL DEFAULT 1,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `enabled` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_menu`
--

INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES
(1, 'kathrine', 'Latest News', 'news', 0, '', 1, 0, 1),
(2, 'kathrine', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(3, 'kathrine', 'Changelog', 'change-log', 0, '', 1, 2, 1),
(4, 'kathrine', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(5, 'kathrine', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(6, 'kathrine', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(7, 'kathrine', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(8, 'kathrine', 'Downloads', 'downloads', 0, '', 2, 4, 1),
(9, 'kathrine', 'Characters', 'characters', 0, '', 3, 0, 1),
(10, 'kathrine', 'Who is Online?', 'online', 0, '', 3, 1, 1),
(11, 'kathrine', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(12, 'kathrine', 'Last Kills', 'last-kills', 0, '', 3, 3, 1),
(13, 'kathrine', 'Houses', 'houses', 0, '', 3, 4, 1),
(14, 'kathrine', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(15, 'kathrine', 'Polls', 'polls', 0, '', 3, 6, 1),
(16, 'kathrine', 'Bans', 'bans', 0, '', 3, 7, 1),
(17, 'kathrine', 'Forum', 'forum', 0, '', 3, 8, 1),
(18, 'kathrine', 'Team', 'team', 0, '', 3, 9, 1),
(19, 'kathrine', 'Monsters', 'monsters', 0, '', 5, 0, 1),
(20, 'kathrine', 'Spells', 'spells', 0, '', 5, 1, 1),
(21, 'kathrine', 'Server Info', 'ots-info', 0, '', 5, 2, 1),
(22, 'kathrine', 'Commands', 'commands', 0, '', 5, 3, 1),
(23, 'kathrine', 'Exp Stages', 'exp-stages', 0, '', 5, 4, 1),
(24, 'kathrine', 'Gallery', 'gallery', 0, '', 5, 5, 1),
(25, 'kathrine', 'Exp Table', 'exp-table', 0, '', 5, 6, 1),
(26, 'kathrine', 'FAQ', 'faq', 0, '', 5, 7, 1),
(27, 'kathrine', 'Buy Points', 'points', 0, '', 6, 0, 1),
(28, 'kathrine', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(29, 'kathrine', 'Shop History', 'gifts/history', 0, '', 6, 2, 1),
(30, 'tibiacom', 'Latest News', 'news', 0, '', 1, 0, 1),
(31, 'tibiacom', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(32, 'tibiacom', 'Changelog', 'change-log', 0, '', 1, 2, 1),
(33, 'tibiacom', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(34, 'tibiacom', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(35, 'tibiacom', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(36, 'tibiacom', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(37, 'tibiacom', 'Downloads', 'downloads', 0, '', 2, 4, 1),
(38, 'tibiacom', 'Characters', 'characters', 0, '', 3, 0, 1),
(39, 'tibiacom', 'Who is Online?', 'online', 0, '', 3, 1, 1),
(40, 'tibiacom', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(41, 'tibiacom', 'Last Kills', 'last-kills', 0, '', 3, 3, 1),
(42, 'tibiacom', 'Houses', 'houses', 0, '', 3, 4, 1),
(43, 'tibiacom', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(44, 'tibiacom', 'Polls', 'polls', 0, '', 3, 6, 1),
(45, 'tibiacom', 'Bans', 'bans', 0, '', 3, 7, 1),
(46, 'tibiacom', 'Support List', 'team', 0, '', 3, 8, 1),
(47, 'tibiacom', 'Forum', 'forum', 0, '', 4, 0, 1),
(48, 'tibiacom', 'Monsters', 'monsters', 0, '', 5, 0, 1),
(49, 'tibiacom', 'Spells', 'spells', 0, '', 5, 1, 1),
(50, 'tibiacom', 'Commands', 'commands', 0, '', 5, 2, 1),
(51, 'tibiacom', 'Exp Stages', 'exp-stages', 0, '', 5, 3, 1),
(52, 'tibiacom', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(53, 'tibiacom', 'Server Info', 'ots-info', 0, '', 5, 5, 1),
(54, 'tibiacom', 'Exp Table', 'exp-table', 0, '', 5, 6, 1),
(55, 'tibiacom', 'FAQ', 'faq', 0, '', 5, 7, 1),
(56, 'tibiacom', 'Buy Points', 'points', 0, '', 6, 0, 1),
(57, 'tibiacom', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(58, 'tibiacom', 'Shop History', 'gifts/history', 0, '', 6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_monsters`
--

CREATE TABLE `myaac_monsters` (
  `id` int(11) NOT NULL,
  `hide` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT 0,
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `look` varchar(255) NOT NULL DEFAULT '',
  `speed_lvl` int(11) NOT NULL DEFAULT 1,
  `use_haste` tinyint(4) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `elements` text NOT NULL,
  `summonable` tinyint(4) NOT NULL,
  `convinceable` tinyint(4) NOT NULL,
  `pushable` tinyint(4) NOT NULL DEFAULT 0,
  `canpushitems` tinyint(4) NOT NULL DEFAULT 0,
  `canwalkonenergy` tinyint(4) NOT NULL DEFAULT 0,
  `canwalkonpoison` tinyint(4) NOT NULL DEFAULT 0,
  `canwalkonfire` tinyint(4) NOT NULL DEFAULT 0,
  `runonhealth` tinyint(4) NOT NULL DEFAULT 0,
  `hostile` tinyint(4) NOT NULL DEFAULT 0,
  `attackable` tinyint(4) NOT NULL DEFAULT 0,
  `rewardboss` tinyint(4) NOT NULL DEFAULT 0,
  `defense` int(11) NOT NULL DEFAULT 0,
  `armor` int(11) NOT NULL DEFAULT 0,
  `canpushcreatures` tinyint(4) NOT NULL DEFAULT 0,
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL,
  `summons` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_news`
--

CREATE TABLE `myaac_news` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - news, 2 - ticker, 3 - article',
  `date` int(11) NOT NULL DEFAULT 0,
  `category` tinyint(4) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `last_modified_by` int(11) NOT NULL DEFAULT 0,
  `last_modified_date` int(11) NOT NULL DEFAULT 0,
  `comments` varchar(50) NOT NULL DEFAULT '',
  `article_text` varchar(300) NOT NULL DEFAULT '',
  `article_image` varchar(100) NOT NULL DEFAULT '',
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_news`
--

INSERT INTO `myaac_news` (`id`, `title`, `body`, `type`, `date`, `category`, `player_id`, `last_modified_by`, `last_modified_date`, `comments`, `article_text`, `article_image`, `hide`) VALUES
(1, 'Hello!', 'MyAAC is just READY to use!', 1, 1755434081, 2, 7, 0, 0, 'https://my-aac.org', '', '', 0),
(2, 'Hello tickers!', 'https://my-aac.org', 2, 1755434081, 4, 7, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_news_categories`
--

CREATE TABLE `myaac_news_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `icon_id` int(11) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_news_categories`
--

INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hide`) VALUES
(1, '', '', 0, 0),
(2, '', '', 1, 0),
(3, '', '', 2, 0),
(4, '', '', 3, 0),
(5, '', '', 4, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_notepad`
--

CREATE TABLE `myaac_notepad` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_pages`
--

CREATE TABLE `myaac_pages` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` text NOT NULL,
  `date` int(11) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `php` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 - plain html, 1 - php',
  `enable_tinymce` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 - enabled, 0 - disabled',
  `access` tinyint(4) NOT NULL DEFAULT 0,
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_pages`
--

INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hide`) VALUES
(1, 'downloads', 'Downloads', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<div style=\"text-align: center;\">We\'re using official Tibia Client <strong>{{ config.client / 100 }}</strong><br>\n	<p>Download Tibia Client <strong>{{ config.client / 100 }}</strong>&nbsp;for Windows <a href=\"https://drive.google.com/drive/folders/0B2-sMQkWYzhGSFhGVlY2WGk5czQ\" target=\"_blank\" rel=\"noopener\">HERE</a>.</p>\n	<h2>IP Changer:</h2>\n	<a href=\"https://static.otland.net/ipchanger.exe\" target=\"_blank\" rel=\"noopener\">HERE</a></div>\n', 1755434119, 1, 0, 1, 0, 0),
(2, 'commands', 'Commands', '<table class=\"myaac-table\" style=\"border-collapse: collapse; width: 100%; height: 72px; border-width: 1px;\" border=\"1\"><colgroup><col style=\"width: 50%;\"><col style=\"width: 50%;\"></colgroup>\n	<thead>\n	<tr style=\"height: 18px;\">\n		<td style=\"height: 18px; border-width: 1px; text-align: center;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\n		<td style=\"height: 18px; border-width: 1px; text-align: center;\"><strong>Description</strong></td>\n	</tr>\n	</thead>\n	<tbody>\n	<tr style=\"height: 18px;\">\n		<td style=\"height: 18px; border-width: 1px;\">!example</td>\n		<td style=\"height: 18px; border-width: 1px;\">This is just an example</td>\n	</tr>\n	<tr style=\"height: 18px;\">\n		<td style=\"height: 18px; border-width: 1px;\">!buyhouse</td>\n		<td style=\"height: 18px; border-width: 1px;\">Buy house you are looking at</td>\n	</tr>\n	<tr style=\"height: 18px;\">\n		<td style=\"height: 18px; border-width: 1px;\"><em>!aol</em></td>\n		<td style=\"height: 18px; border-width: 1px;\">Buy AoL</td>\n	</tr>\n	</tbody>\n</table>\n', 1755434119, 1, 0, 1, 0, 0),
(3, 'rules_on_the_page', 'Rules', '1. Names\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\n\n2. Cheating\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\nd) Manipulating the client program or using additional software to play the game.\ne) Trying to steal other players\\\' account data (\"hacking\").\nf) Playing on more than one account at the same time (\"multi-clienting\").\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\n\n3. Gamemasters\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\n\n4. Player Killing\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\n\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\n\nThese rules may be changed at any time. All changes will be announced on the official website.\n', 1755434119, 1, 0, 0, 0, 1),
(4, 'rules', 'Server Rules', '<b>{{ config.lua.serverName }} Rules</b><br/>1. Names<br />\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.<br />\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").<br />\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").<br />\n<br />\n2. Cheating<br />\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.<br />\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.<br />\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").<br />\nd) Manipulating the client program or using additional software to play the game.<br />\ne) Trying to steal other players\\\' account data (\"hacking\").<br />\nf) Playing on more than one account at the same time (\"multi-clienting\").<br />\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").<br />\n<br />\n3. Gamemasters<br />\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.<br />\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.<br />\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.<br />\n<br />\n4. Player Killing<br />\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.<br />\n<br />\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.<br />\n<br />\nThese rules may be changed at any time. All changes will be announced on the official website.<br />\n', 1755434119, 1, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_settings`
--

CREATE TABLE `myaac_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `myaac_settings`
--

INSERT INTO `myaac_settings` (`id`, `name`, `key`, `value`) VALUES
(1, 'core', 'date_timezone', 'Europe/Warsaw'),
(2, 'core', 'client', '1400'),
(3, 'core', 'anonymous_usage_statistics', 'true'),
(4, 'core', 'highscores_ids_hidden', '1, 2, 3, 4, 5');

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_spells`
--

CREATE TABLE `myaac_spells` (
  `id` int(11) NOT NULL,
  `spell` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `words` varchar(255) NOT NULL DEFAULT '',
  `category` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 - instant, 2 - conjure, 3 - rune',
  `level` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `soul` tinyint(4) NOT NULL DEFAULT 0,
  `conjure_id` int(11) NOT NULL DEFAULT 0,
  `conjure_count` tinyint(4) NOT NULL DEFAULT 0,
  `reagent` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `premium` tinyint(4) NOT NULL DEFAULT 0,
  `vocations` varchar(100) NOT NULL DEFAULT '',
  `hide` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_visitors`
--

CREATE TABLE `myaac_visitors` (
  `ip` varchar(45) NOT NULL,
  `lastvisit` int(11) NOT NULL DEFAULT 0,
  `page` varchar(2048) NOT NULL,
  `user_agent` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `myaac_weapons`
--

CREATE TABLE `myaac_weapons` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `vocations` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `office_cooldown`
--

CREATE TABLE `office_cooldown` (
  `account_id` int(11) NOT NULL,
  `office` enum('PRESIDENT','GOVERNOR') NOT NULL,
  `next_eligible_ts` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `office_term`
--

CREATE TABLE `office_term` (
  `id` bigint(20) NOT NULL,
  `office` enum('PRESIDENT','GOVERNOR') NOT NULL,
  `kingdom` tinyint(3) UNSIGNED DEFAULT NULL,
  `player_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `start_ts` datetime NOT NULL,
  `end_ts` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 1,
  `is_president` tinyint(1) NOT NULL DEFAULT 0,
  `is_governor` tinyint(1) NOT NULL DEFAULT 0,
  `kingdom` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0=neutro, 1=Norte, 2=Oeste, 3=Sul, 4=Leste',
  `account_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `vocation` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 150,
  `healthmax` int(11) NOT NULL DEFAULT 150,
  `experience` bigint(20) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `manamax` int(11) NOT NULL DEFAULT 0,
  `manaspent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `soul` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 1,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `conditions` mediumblob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT 0,
  `sex` int(11) NOT NULL DEFAULT 0,
  `pronoun` int(11) NOT NULL DEFAULT 0,
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `save` tinyint(1) NOT NULL DEFAULT 1,
  `skull` tinyint(1) NOT NULL DEFAULT 0,
  `skulltime` bigint(20) NOT NULL DEFAULT 0,
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `blessings` tinyint(2) NOT NULL DEFAULT 0,
  `blessings1` tinyint(4) NOT NULL DEFAULT 0,
  `blessings2` tinyint(4) NOT NULL DEFAULT 0,
  `blessings3` tinyint(4) NOT NULL DEFAULT 0,
  `blessings4` tinyint(4) NOT NULL DEFAULT 0,
  `blessings5` tinyint(4) NOT NULL DEFAULT 0,
  `blessings6` tinyint(4) NOT NULL DEFAULT 0,
  `blessings7` tinyint(4) NOT NULL DEFAULT 0,
  `blessings8` tinyint(4) NOT NULL DEFAULT 0,
  `onlinetime` int(11) NOT NULL DEFAULT 0,
  `deletion` bigint(15) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT 43200,
  `offlinetraining_skill` tinyint(2) NOT NULL DEFAULT -1,
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT 2520,
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_damage` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_damage_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_criticalhit_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_criticalhit_damage` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_lifeleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_lifeleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_manaleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_manaleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `manashield` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `max_manashield` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `xpboost_stamina` smallint(5) UNSIGNED DEFAULT NULL,
  `xpboost_value` tinyint(4) UNSIGNED DEFAULT NULL,
  `marriage_status` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `marriage_spouse` int(11) NOT NULL DEFAULT -1,
  `bonus_rerolls` bigint(21) NOT NULL DEFAULT 0,
  `prey_wildcard` bigint(21) NOT NULL DEFAULT 0,
  `task_points` bigint(21) NOT NULL DEFAULT 0,
  `quickloot_fallback` tinyint(1) DEFAULT 0,
  `lookmountbody` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmountfeet` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmounthead` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmountlegs` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookfamiliarstype` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `isreward` tinyint(1) NOT NULL DEFAULT 1,
  `istutorial` tinyint(1) NOT NULL DEFAULT 0,
  `forge_dusts` bigint(21) NOT NULL DEFAULT 0,
  `forge_dust_level` bigint(21) NOT NULL DEFAULT 100,
  `randomize_mount` tinyint(1) NOT NULL DEFAULT 0,
  `boss_points` int(11) NOT NULL DEFAULT 0,
  `animus_mastery` mediumblob DEFAULT NULL,
  `pres_guard` tinyint(4) GENERATED ALWAYS AS (case when `is_president` = 1 then 1 else NULL end) STORED,
  `gov_realm_guard` tinyint(4) GENERATED ALWAYS AS (case when `is_governor` = 1 then `kingdom` else NULL end) STORED,
  `kingdom_since` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'quando o player entrou no reino atual',
  `created` int(11) NOT NULL DEFAULT 0,
  `hide` tinyint(1) NOT NULL DEFAULT 0,
  `comment` varchar(5000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `is_president`, `is_governor`, `kingdom`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `pronoun`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `blessings1`, `blessings2`, `blessings3`, `blessings4`, `blessings5`, `blessings6`, `blessings7`, `blessings8`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `skill_critical_hit_chance`, `skill_critical_hit_chance_tries`, `skill_critical_hit_damage`, `skill_critical_hit_damage_tries`, `skill_life_leech_chance`, `skill_life_leech_chance_tries`, `skill_life_leech_amount`, `skill_life_leech_amount_tries`, `skill_mana_leech_chance`, `skill_mana_leech_chance_tries`, `skill_mana_leech_amount`, `skill_mana_leech_amount_tries`, `skill_criticalhit_chance`, `skill_criticalhit_damage`, `skill_lifeleech_chance`, `skill_lifeleech_amount`, `skill_manaleech_chance`, `skill_manaleech_amount`, `manashield`, `max_manashield`, `xpboost_stamina`, `xpboost_value`, `marriage_status`, `marriage_spouse`, `bonus_rerolls`, `prey_wildcard`, `task_points`, `quickloot_fallback`, `lookmountbody`, `lookmountfeet`, `lookmounthead`, `lookmountlegs`, `lookfamiliarstype`, `isreward`, `istutorial`, `forge_dusts`, `forge_dust_level`, `randomize_mount`, `boss_points`, `animus_mastery`, `kingdom_since`, `created`, `hide`, `comment`) VALUES
(1, 'Rook Sample', 1, 0, 0, 0, 1, 2, 0, 155, 155, 100, 113, 115, 95, 39, 129, 0, 2, 60, 60, 5936, 0, 1, 32069, 31901, 6, '', 410, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 12, 155, 12, 155, 12, 155, 12, 93, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 13:43:18', 0, 0, ''),
(2, 'Sorcerer Sample', 1, 0, 0, 0, 1, 8, 1, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 32369, 32241, 7, '', 470, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 13:43:18', 0, 0, ''),
(3, 'Druid Sample', 1, 0, 0, 0, 1, 8, 2, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 32369, 32241, 7, '', 470, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 13:43:18', 0, 0, ''),
(4, 'Paladin Sample', 1, 0, 0, 0, 1, 8, 3, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 32369, 32241, 7, '', 470, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 13:43:18', 0, 0, ''),
(5, 'Knight Sample', 1, 0, 0, 0, 1, 8, 4, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 32369, 32241, 7, '', 470, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 13:43:18', 0, 0, ''),
(6, 'GOD', 6, 1, 0, 3, 1, 2, 0, 155, 155, 100, 113, 115, 95, 39, 136, 0, 0, 60, 60, 0, 5, 8, 32345, 32228, 7, '', 410, 1, 0, 1755460329, 16777343, 1, 0, 0, 1755460340, 0, 1, 1, 1, 1, 1, 1, 1, 1, 789, 0, 577, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 14:38:08', 0, 0, ''),
(7, 'Toni', 6, 0, 0, 0, 2, 1, 0, 100, 100, 0, 10, 10, 10, 10, 136, 0, 0, 100, 100, 0, 0, 2, 32066, 31877, 5, '', 0, 0, 0, 1755439675, 16777343, 1, 0, 0, 1755439734, 0, 1, 1, 1, 1, 1, 1, 1, 1, 59, 0, 0, 43200, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 14:34:41', 1755434081, 0, ''),
(8, 'Tester', 1, 0, 0, 0, 2, 8, 4, 185, 185, 4254, 113, 115, 95, 39, 136, 0, 0, 90, 90, 0, 0, 2, 32065, 31884, 5, '', 470, 0, 0, 1755439735, 16777343, 1, 0, 0, 1755439919, 0, 1, 1, 1, 1, 1, 1, 1, 1, 264, 0, 12, 43200, -1, 2518, 10, 0, 10, 0, 10, 0, 10, 21, 10, 0, 10, 29, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 0, 0, '', '2025-08-17 14:36:36', 1755434196, 0, '');

--
-- Acionadores `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_players_kingdom_since_upd` BEFORE UPDATE ON `players` FOR EACH ROW BEGIN
  IF NEW.kingdom <> OLD.kingdom THEN
    SET NEW.kingdom_since = CURRENT_TIMESTAMP;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_bosstiary`
--

CREATE TABLE `player_bosstiary` (
  `player_id` int(11) NOT NULL,
  `bossIdSlotOne` int(11) NOT NULL DEFAULT 0,
  `bossIdSlotTwo` int(11) NOT NULL DEFAULT 0,
  `removeTimes` int(11) NOT NULL DEFAULT 1,
  `tracker` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_bosstiary`
--

INSERT INTO `player_bosstiary` (`player_id`, `bossIdSlotOne`, `bossIdSlotTwo`, `removeTimes`, `tracker`) VALUES
(7, 0, 0, 1, ''),
(8, 0, 0, 1, ''),
(6, 0, 0, 1, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_charms`
--

CREATE TABLE `player_charms` (
  `player_id` int(11) NOT NULL,
  `charm_points` smallint(6) NOT NULL DEFAULT 0,
  `minor_charm_echoes` smallint(6) NOT NULL DEFAULT 0,
  `max_charm_points` smallint(6) NOT NULL DEFAULT 0,
  `max_minor_charm_echoes` smallint(6) NOT NULL DEFAULT 0,
  `charm_expansion` tinyint(1) NOT NULL DEFAULT 0,
  `UsedRunesBit` int(11) NOT NULL DEFAULT 0,
  `UnlockedRunesBit` int(11) NOT NULL DEFAULT 0,
  `charms` blob DEFAULT NULL,
  `tracker list` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_charms`
--

INSERT INTO `player_charms` (`player_id`, `charm_points`, `minor_charm_echoes`, `max_charm_points`, `max_minor_charm_echoes`, `charm_expansion`, `UsedRunesBit`, `UnlockedRunesBit`, `charms`, `tracker list`) VALUES
(1, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(2, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(3, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(4, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(5, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(6, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(7, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, ''),
(8, 0, 0, 0, 0, 0, 0, 0, 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT 1,
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT 0,
  `unjustified` tinyint(1) NOT NULL DEFAULT 0,
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT 0,
  `participants` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_hirelings`
--

CREATE TABLE `player_hirelings` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `sid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(1, 11, 101, 23396, 1, ''),
(2, 11, 101, 23396, 1, ''),
(3, 11, 101, 23396, 1, ''),
(4, 11, 101, 23396, 1, ''),
(5, 11, 101, 23396, 1, ''),
(6, 3, 101, 2854, 1, 0x240126000000802c00000080),
(6, 11, 102, 23396, 1, ''),
(6, 101, 103, 3457, 1, ''),
(6, 101, 104, 3003, 1, ''),
(7, 3, 101, 2854, 1, 0x26000000802c00000080),
(7, 11, 102, 23396, 1, ''),
(7, 101, 103, 3457, 1, ''),
(7, 101, 104, 3003, 1, ''),
(8, 1, 101, 3354, 1, ''),
(8, 2, 102, 3572, 1, ''),
(8, 3, 103, 2854, 1, 0x240126000000802c00000080),
(8, 4, 104, 3359, 1, ''),
(8, 5, 105, 3425, 1, ''),
(8, 6, 106, 7773, 1, ''),
(8, 7, 107, 3372, 1, ''),
(8, 8, 108, 3552, 1, ''),
(8, 11, 109, 23396, 1, ''),
(8, 103, 110, 266, 10, 0x0f0a),
(8, 103, 111, 5710, 1, ''),
(8, 103, 112, 3003, 1, ''),
(8, 103, 113, 3327, 1, ''),
(8, 103, 114, 7774, 1, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_kills`
--

CREATE TABLE `player_kills` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `target` int(11) NOT NULL,
  `unavenged` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_prey`
--

CREATE TABLE `player_prey` (
  `player_id` int(11) NOT NULL,
  `slot` tinyint(1) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `raceid` varchar(250) NOT NULL,
  `option` tinyint(1) NOT NULL,
  `bonus_type` tinyint(1) NOT NULL,
  `bonus_rarity` tinyint(1) NOT NULL,
  `bonus_percentage` varchar(250) NOT NULL,
  `bonus_time` varchar(250) NOT NULL,
  `free_reroll` bigint(20) NOT NULL,
  `monster_list` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_prey`
--

INSERT INTO `player_prey` (`player_id`, `slot`, `state`, `raceid`, `option`, `bonus_type`, `bonus_rarity`, `bonus_percentage`, `bonus_time`, `free_reroll`, `monster_list`) VALUES
(6, 0, 3, '0', 0, 1, 2, '16', '0', 1755506159797, 0x83038b076500d800120440000302f407b607),
(6, 1, 3, '0', 0, 2, 8, '34', '0', 1755506159797, 0xf6000f072700be01c3061000de083d005b09),
(6, 2, 0, '0', 0, 2, 3, '19', '0', 1755506159797, ''),
(7, 0, 3, '0', 0, 0, 2, '16', '0', 1755511675241, 0xee0048048b042a00ad047100330094039e05),
(7, 1, 3, '0', 0, 3, 2, '16', '0', 1755511675241, 0xfd011b07d30472009c03970345007003f400),
(7, 2, 0, '0', 0, 0, 8, '34', '0', 1755511675241, ''),
(8, 0, 3, '0', 0, 0, 4, '22', '0', 1755506210102, 0x1e042d0830007904da002509db00d6030200),
(8, 1, 0, '0', 0, 3, 5, '25', '0', 1755506210102, ''),
(8, 2, 0, '0', 0, 1, 6, '28', '0', 1755506210102, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_rewards`
--

CREATE TABLE `player_rewards` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_stash`
--

CREATE TABLE `player_stash` (
  `player_id` int(16) NOT NULL,
  `item_id` int(16) NOT NULL,
  `item_count` int(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(6, 13413, 1),
(6, 13414, 8),
(6, 14903, 0),
(6, 10002011, 0),
(7, 13413, 1),
(7, 13414, 8),
(7, 14903, 0),
(7, 44752, 1),
(7, 44753, 1),
(8, 13413, 1),
(8, 13414, 8),
(8, 14903, 0),
(8, 44752, 1),
(8, 44753, 1),
(8, 52277, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_taskhunt`
--

CREATE TABLE `player_taskhunt` (
  `player_id` int(11) NOT NULL,
  `slot` tinyint(1) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `raceid` varchar(250) NOT NULL,
  `upgrade` tinyint(1) NOT NULL,
  `rarity` tinyint(1) NOT NULL,
  `kills` varchar(250) NOT NULL,
  `disabled_time` bigint(20) NOT NULL,
  `free_reroll` bigint(20) NOT NULL,
  `monster_list` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_taskhunt`
--

INSERT INTO `player_taskhunt` (`player_id`, `slot`, `state`, `raceid`, `upgrade`, `rarity`, `kills`, `disabled_time`, `free_reroll`, `monster_list`) VALUES
(6, 0, 2, '0', 0, 1, '0', 0, 1755506159797, 0x0d022d090c060e0408064301440138002a00),
(6, 1, 2, '0', 0, 1, '0', 0, 1755506159797, 0x3f00210102010702e807f507e000e2053208),
(6, 2, 0, '0', 0, 1, '0', 0, 1755506159797, ''),
(7, 0, 2, '0', 0, 1, '0', 0, 1755511675241, 0x26007b030308120028091603880142012709),
(7, 1, 2, '0', 0, 1, '0', 0, 1755511675241, 0x6e0399072100780215004600f8000b00fe03),
(7, 2, 0, '0', 0, 1, '0', 0, 1755511675241, ''),
(8, 0, 2, '0', 0, 1, '0', 0, 1755506210102, 0x4a01020117000900e508ad07000108024600),
(8, 1, 0, '0', 0, 1, '0', 0, 1755506210102, ''),
(8, 2, 0, '0', 0, 1, '0', 0, 1755506210102, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_wheeldata`
--

CREATE TABLE `player_wheeldata` (
  `player_id` int(11) NOT NULL,
  `slot` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `player_wheeldata`
--

INSERT INTO `player_wheeldata` (`player_id`, `slot`) VALUES
(6, 0x0100000200000300000400000500000600000700000800000900000a00000b00000c00000d00000e00000f00001000001100001200001300001400001500001600001700001800001900001a00001b00001c00001d00001e00001f0000200000210000220000230000240000),
(7, 0x0100000200000300000400000500000600000700000800000900000a00000b00000c00000d00000e00000f00001000001100001200001300001400001500001600001700001800001900001a00001b00001c00001d00001e00001f0000200000210000220000230000240000),
(8, 0x0100000200000300000400000500000600000700000800000900000a00000b00000c00000d00000e00000f00001000001100001200001300001400001500001600001700001800001900001a00001b00001c00001d00001e00001f0000200000210000220000230000240000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '52'),
('motd_hash', '93c2979f72c3faf9bb33393d607472e5c00bab42'),
('motd_num', '1'),
('players_record', '1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `store_history`
--

CREATE TABLE `store_history` (
  `id` int(11) NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `mode` smallint(2) NOT NULL DEFAULT 0,
  `description` varchar(3500) NOT NULL,
  `coin_type` tinyint(1) NOT NULL DEFAULT 0,
  `coin_amount` int(12) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `coins` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `tile_store`
--

INSERT INTO `tile_store` (`house_id`, `data`) VALUES
(3220, 0x637fd37f0701000000391900),
(3220, 0x607fd37f0701000000391900);

-- --------------------------------------------------------

--
-- Estrutura para tabela `towns`
--

CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `towns`
--

INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES
(1, 'Dawnport Tutorial', 32069, 31901, 6),
(2, 'Dawnport', 32064, 31894, 6),
(3, 'Rookgaard', 32097, 32219, 7),
(4, 'Island of Destiny', 32091, 32027, 7),
(5, 'Ab\'Dendriel', 32732, 31634, 7),
(6, 'Carlin', 32360, 31782, 7),
(7, 'Kazordoon', 32649, 31925, 11),
(8, 'Thais', 32369, 32241, 7),
(9, 'Venore', 32957, 32076, 7),
(10, 'Ankrahmun', 33194, 32853, 8),
(11, 'Edron', 33217, 31814, 8),
(12, 'Farmine', 33023, 31521, 11),
(13, 'Darashia', 33213, 32454, 1),
(14, 'Liberty Bay', 32317, 32826, 7),
(15, 'Port Hope', 32594, 32745, 7),
(16, 'Svargrond', 32212, 31132, 7),
(17, 'Yalahar', 32787, 31276, 7),
(18, 'Gray Beach', 33447, 31323, 9),
(19, 'Krailos', 33657, 31665, 8),
(20, 'Rathleton', 33594, 31899, 6),
(21, 'Roshamuul', 33513, 32363, 6),
(22, 'Issavi', 33921, 31477, 5),
(23, 'Event Room', 1054, 1040, 7),
(24, 'Cobra Bastion', 33397, 32651, 7),
(25, 'Bounac', 32424, 32445, 7),
(26, 'Feyrist', 33490, 32221, 7),
(27, 'Gnomprona', 33517, 32856, 14),
(28, 'Marapur', 33842, 32853, 7),
(29, 'Candia', 33338, 32125, 7),
(30, 'Silvertides', 33776, 32842, 7),
(31, 'Moonfall', 33797, 32755, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end` int(11) NOT NULL DEFAULT 0,
  `start` int(11) NOT NULL DEFAULT 0,
  `answers` int(11) NOT NULL DEFAULT 0,
  `votes_all` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_unique` (`name`);

--
-- Índices de tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `account_sessions`
--
ALTER TABLE `account_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `account_vipgrouplist`
--
ALTER TABLE `account_vipgrouplist`
  ADD UNIQUE KEY `account_vipgrouplist_unique` (`account_id`,`player_id`,`vipgroup_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `vipgroup_id` (`vipgroup_id`),
  ADD KEY `account_vipgrouplist_vipgroup_fk` (`vipgroup_id`,`account_id`);

--
-- Índices de tabela `account_vipgroups`
--
ALTER TABLE `account_vipgroups`
  ADD PRIMARY KEY (`id`,`account_id`),
  ADD KEY `account_vipgroups_accounts_fk` (`account_id`);

--
-- Índices de tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_viplist_unique` (`account_id`,`player_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `boosted_boss`
--
ALTER TABLE `boosted_boss`
  ADD PRIMARY KEY (`date`);

--
-- Índices de tabela `boosted_creature`
--
ALTER TABLE `boosted_creature`
  ADD PRIMARY KEY (`date`);

--
-- Índices de tabela `coins_transactions`
--
ALTER TABLE `coins_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Índices de tabela `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `economy_tariffs`
--
ALTER TABLE `economy_tariffs`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `election_candidate`
--
ALTER TABLE `election_candidate`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_unique_cand_once` (`cycle_id`,`player_id`),
  ADD KEY `idx_cycle_office` (`cycle_id`,`office`,`kingdom`);

--
-- Índices de tabela `election_cycle`
--
ALTER TABLE `election_cycle`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_week` (`week_iso`);

--
-- Índices de tabela `election_vote`
--
ALTER TABLE `election_vote`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_vote_acc_per_office` (`cycle_id`,`office`,`voter_account_id`),
  ADD KEY `idx_cycle_office` (`cycle_id`,`office`,`kingdom`),
  ADD KEY `idx_candidate` (`candidate_id`);

--
-- Índices de tabela `forge_history`
--
ALTER TABLE `forge_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `global_storage`
--
ALTER TABLE `global_storage`
  ADD UNIQUE KEY `global_storage_unique` (`key`);

--
-- Índices de tabela `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guilds_name_unique` (`name`),
  ADD UNIQUE KEY `guilds_owner_unique` (`ownerid`);

--
-- Índices de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Índices de tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Índices de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Índices de tabela `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Índices de tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD PRIMARY KEY (`house_id`,`listid`),
  ADD KEY `house_id_index` (`house_id`),
  ADD KEY `version` (`version`);

--
-- Índices de tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `kv_store`
--
ALTER TABLE `kv_store`
  ADD PRIMARY KEY (`key_name`);

--
-- Índices de tabela `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Índices de tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `myaac_account_actions`
--
ALTER TABLE `myaac_account_actions`
  ADD KEY `account_id` (`account_id`);

--
-- Índices de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_settings`
--
ALTER TABLE `myaac_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `key` (`key`);

--
-- Índices de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `myaac_visitors`
--
ALTER TABLE `myaac_visitors`
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Índices de tabela `myaac_weapons`
--
ALTER TABLE `myaac_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `office_cooldown`
--
ALTER TABLE `office_cooldown`
  ADD PRIMARY KEY (`account_id`,`office`);

--
-- Índices de tabela `office_term`
--
ALTER TABLE `office_term`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `players_unique` (`name`),
  ADD UNIQUE KEY `ux_single_president` (`pres_guard`),
  ADD UNIQUE KEY `ux_one_governor_per_kingdom` (`gov_realm_guard`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Índices de tabela `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices de tabela `player_bosstiary`
--
ALTER TABLE `player_bosstiary`
  ADD KEY `player_bosstiary_players_fk` (`player_id`);

--
-- Índices de tabela `player_charms`
--
ALTER TABLE `player_charms`
  ADD KEY `player_charms_players_fk` (`player_id`);

--
-- Índices de tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Índices de tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_depotitems_unique` (`player_id`,`sid`);

--
-- Índices de tabela `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_inboxitems_unique` (`player_id`,`sid`);

--
-- Índices de tabela `player_items`
--
ALTER TABLE `player_items`
  ADD PRIMARY KEY (`player_id`,`pid`,`sid`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Índices de tabela `player_kills`
--
ALTER TABLE `player_kills`
  ADD KEY `player_kills_players_fk` (`player_id`);

--
-- Índices de tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD UNIQUE KEY `player_namelocks_unique` (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Índices de tabela `player_prey`
--
ALTER TABLE `player_prey`
  ADD PRIMARY KEY (`player_id`,`slot`);

--
-- Índices de tabela `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD UNIQUE KEY `player_rewards_unique` (`player_id`,`sid`);

--
-- Índices de tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD PRIMARY KEY (`player_id`,`name`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_stash`
--
ALTER TABLE `player_stash`
  ADD PRIMARY KEY (`player_id`,`item_id`);

--
-- Índices de tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Índices de tabela `player_taskhunt`
--
ALTER TABLE `player_taskhunt`
  ADD PRIMARY KEY (`player_id`,`slot`);

--
-- Índices de tabela `player_wheeldata`
--
ALTER TABLE `player_wheeldata`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Índices de tabela `store_history`
--
ALTER TABLE `store_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Índices de tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Índices de tabela `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `z_polls`
--
ALTER TABLE `z_polls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `account_vipgroups`
--
ALTER TABLE `account_vipgroups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `coins_transactions`
--
ALTER TABLE `coins_transactions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `economy_tariffs`
--
ALTER TABLE `economy_tariffs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `election_candidate`
--
ALTER TABLE `election_candidate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `election_cycle`
--
ALTER TABLE `election_cycle`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `election_vote`
--
ALTER TABLE `election_vote`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `forge_history`
--
ALTER TABLE `forge_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3697;

--
-- AUTO_INCREMENT de tabela `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `myaac_settings`
--
ALTER TABLE `myaac_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `office_term`
--
ALTER TABLE `office_term`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `player_hirelings`
--
ALTER TABLE `player_hirelings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `store_history`
--
ALTER TABLE `store_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `towns`
--
ALTER TABLE `towns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de tabela `z_polls`
--
ALTER TABLE `z_polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_player_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_bans_history_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_history_player_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_vipgrouplist`
--
ALTER TABLE `account_vipgrouplist`
  ADD CONSTRAINT `account_vipgrouplist_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_vipgrouplist_vipgroup_fk` FOREIGN KEY (`vipgroup_id`,`account_id`) REFERENCES `account_vipgroups` (`id`, `account_id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `account_vipgroups`
--
ALTER TABLE `account_vipgroups`
  ADD CONSTRAINT `account_vipgroups_accounts_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `coins_transactions`
--
ALTER TABLE `coins_transactions`
  ADD CONSTRAINT `coins_transactions_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  ADD CONSTRAINT `daily_reward_history_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `election_candidate`
--
ALTER TABLE `election_candidate`
  ADD CONSTRAINT `fk_cand_cycle` FOREIGN KEY (`cycle_id`) REFERENCES `election_cycle` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `election_vote`
--
ALTER TABLE `election_vote`
  ADD CONSTRAINT `fk_vote_cand` FOREIGN KEY (`candidate_id`) REFERENCES `election_candidate` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vote_cycle` FOREIGN KEY (`cycle_id`) REFERENCES `election_cycle` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `forge_history`
--
ALTER TABLE `forge_history`
  ADD CONSTRAINT `forge_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ownerid_fk` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_warid_fk` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_guild_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_guild_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_rank_fk` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `houses_list_house_fk` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_players_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_bosstiary`
--
ALTER TABLE `player_bosstiary`
  ADD CONSTRAINT `player_bosstiary_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_charms`
--
ALTER TABLE `player_charms`
  ADD CONSTRAINT `player_charms_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD CONSTRAINT `player_hirelings_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_kills`
--
ALTER TABLE `player_kills`
  ADD CONSTRAINT `player_kills_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_players2_fk` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `player_prey`
--
ALTER TABLE `player_prey`
  ADD CONSTRAINT `player_prey_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD CONSTRAINT `player_rewards_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_stash`
--
ALTER TABLE `player_stash`
  ADD CONSTRAINT `player_stash_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_taskhunt`
--
ALTER TABLE `player_taskhunt`
  ADD CONSTRAINT `player_taskhunt_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_wheeldata`
--
ALTER TABLE `player_wheeldata`
  ADD CONSTRAINT `player_wheeldata_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `store_history`
--
ALTER TABLE `store_history`
  ADD CONSTRAINT `store_history_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_account_fk` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
