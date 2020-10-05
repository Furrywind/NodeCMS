SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `contents` (
  `cid` int(10) NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `content` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryId` int(10) NOT NULL DEFAULT 0,
  `authorId` int(10) DEFAULT 0,
  `status` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `contents` (`cid`, `title`, `slug`, `created`, `modified`, `content`, `categoryId`, `authorId`, `status`) VALUES
(2, 'What is Lorem Ipsum?', 'one', '2020-04-13 14:41:12', '2020-04-19 15:53:27', '<h2 style=\"text-align: center;\">What is Lorem Ipsum?</h2>\n<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 0, 59, 1),
(4, 'Where does it come from?', 'from', '2020-04-12 22:41:12', '2020-04-19 16:00:21', '<h2 style=\"text-align: center;\">Where does it come from?</h2>\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>', 66, 56, 1),
(6, 'Why do we use it?use', 'use', '2020-04-16 01:00:18', '2020-04-19 16:00:58', '<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>', 66, 0, 0),
(8, 'Where can I get some?', 'get', '2020-04-16 01:04:06', '2020-04-19 16:02:05', '<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', 66, 0, 0),
(9, 'The standard Lorem Ipsum passage, used since the 1500s', '1500', '2020-04-16 01:04:36', '2020-04-19 16:02:48', '<p>\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"</p>', 0, 0, 0),
(10, 'Section 1.10.32 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC', 'section', '2020-04-16 01:07:10', '2020-04-19 16:03:31', '<p>\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?\"</p>', 68, 0, 0),
(11, '1914 translation by H. Rackham', 'dghfjdghf', '2020-04-16 01:08:25', '2020-04-19 16:03:59', '<h4>\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?\"</h4>', 67, 0, 1),
(19, 'Section 1.10.33 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC', '45', '2020-04-17 23:25:30', '2020-04-19 16:04:39', '<h1 style=\"text-align: center;\">\"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.\"</h1>', 66, 0, 1),
(20, '1914 translation by H. Rackham', 'tran', '2020-04-17 23:46:50', '2020-04-19 16:05:05', '<p>\"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.\"</p>', 67, 0, 1),
(21, 'Lorem Ipsum', 'Lorem', '2020-04-17 23:48:28', '2020-04-19 16:05:59', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam iaculis nisl luctus, iaculis turpis ut, pretium nibh. Curabitur fermentum eros turpis, sit amet facilisis turpis vestibulum vel. Proin sed efficitur metus, ac venenatis dui. Maecenas ut ipsum dolor. Duis eleifend risus quis justo sollicitudin, et euismod diam elementum. Vestibulum a lacus sed turpis gravida placerat non sed mauris. Phasellus risus quam, finibus vel neque at, rutrum eleifend diam. Sed semper odio nec ligula dictum feugiat.</p>\n<p>Sed dictum orci id sapien suscipit, sit amet eleifend metus interdum. Sed varius pellentesque purus vel luctus. Vivamus scelerisque est est, sed ullamcorper urna faucibus a. Nunc in mauris at massa elementum eleifend eu at metus. Duis ac imperdiet risus. Suspendisse potenti. Suspendisse ut leo vitae justo dapibus maximus. Donec accumsan elit ut enim mollis vehicula. Etiam a fermentum ex, eget cursus dui. Nulla nec rutrum turpis. Nulla vel iaculis enim. Nulla tristique, erat quis bibendum efficitur, lectus dolor pretium velit, id hendrerit mauris dolor in mi. Sed a augue posuere magna semper elementum ut sit amet augue. Quisque ut accumsan massa, a dignissim ipsum.</p>\n<p>Cras congue placerat placerat. Sed mauris quam, congue vitae mi et, vestibulum ornare lacus. Praesent in rhoncus leo, et condimentum risus. Vivamus tristique diam euismod, ornare urna eget, vulputate lacus. Pellentesque nec mollis lectus. Suspendisse in molestie nunc. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer auctor, ex ac fringilla tincidunt, risus arcu lacinia nibh, sed porttitor nibh nibh eu diam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</p>\n<p>Ut suscipit vulputate sem, sed ullamcorper massa tincidunt et. Pellentesque eu ultricies mauris. Sed scelerisque, justo non scelerisque consequat, erat lectus maximus sapien, vitae consequat dolor neque ac leo. Etiam vitae est nunc. Vivamus aliquet fermentum felis ac consectetur. Integer luctus vulputate turpis, euismod tincidunt metus laoreet a. Quisque id imperdiet ligula. Quisque lacinia ante diam, sit amet posuere mauris sagittis tempor. Morbi malesuada felis eget ligula faucibus varius. Suspendisse luctus tellus nec lacus semper convallis.</p>\n<p>Maecenas mattis nulla quis dui viverra, a condimentum nisl tristique. Aenean consectetur dui finibus, consectetur erat imperdiet, mattis velit. Cras suscipit semper lacinia. Mauris sollicitudin dui hendrerit quam ullamcorper eleifend. In aliquam nibh vel posuere ultrices. Mauris in blandit orci, vel blandit sem. Sed eu mollis arcu.</p>', 66, 0, 0),
(22, 'There is no one who loves pain itself', 'pain', '2020-04-18 19:10:33', '2020-04-19 16:06:32', '<p>Ut suscipit vulputate sem, sed ullamcorper massa tincidunt et. Pellentesque eu ultricies mauris. Sed scelerisque, justo non scelerisque consequat, erat lectus maximus sapien, vitae consequat dolor neque ac leo. Etiam vitae est nunc. Vivamus aliquet fermentum felis ac consectetur. Integer luctus vulputate turpis, euismod tincidunt metus laoreet a. Quisque id imperdiet ligula. Quisque lacinia ante diam, sit amet posuere mauris sagittis tempor. Morbi malesuada felis eget ligula faucibus varius. Suspendisse luctus tellus nec lacus semper convallis.</p>\n<p>Maecenas mattis nulla quis dui viverra, a condimentum nisl tristique. Aenean consectetur dui finibus, consectetur erat imperdiet, mattis velit. Cras suscipit semper lacinia. Mauris sollicitudin dui hendrerit quam ullamcorper eleifend. In aliquam nibh vel posuere ultrices. Mauris in blandit orci, vel blandit sem. Sed eu mollis arcu.</p>', 0, 0, 1),
(26, 'What is Lorem Ipsum?', '5166666', '2020-05-16 09:55:06', '2020-05-16 09:55:44', '<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled<strong> it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesettin</strong>g, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>Co<strong>ntrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passa</strong>ge, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treati<em>se on the theory</em> of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>', 79, 0, 1);

CREATE TABLE `metas` (
  `mid` int(10) NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `metas` (`mid`, `name`, `slug`, `description`, `type`) VALUES
(0, 'Default', 'default', 'Default category', 'category'),
(57, 'Lorem', 'lorem', NULL, 'label'),
(58, 'Ipsum', 'ipsum', NULL, 'label'),
(59, 'dolor', 'dolor', NULL, 'label'),
(60, 'consectetur', 'consectetur', NULL, 'label'),
(61, 'adipiscing', 'adipiscing', NULL, 'label'),
(62, 'eiusmod', 'eiusmod', NULL, 'label'),
(63, 'incididunt', 'incididunt', NULL, 'label'),
(64, 'exercitation', 'exercitation', NULL, 'label'),
(65, 'ullamco', 'ullamco', NULL, 'label'),
(66, 'Lorem Ipsum', 'loremipsum', 'There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...', 'category'),
(67, 'translation', 'translation', '1914 translation', 'category'),
(68, 'Section', 'section', 'Section 1.10.33 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC', 'category'),
(78, '516', '516', NULL, 'label'),
(79, '516', '15515', NULL, 'category');

CREATE TABLE `relationships` (
  `cid` int(10) NOT NULL,
  `mid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `relationships` (`cid`, `mid`) VALUES
(2, 57),
(2, 58),
(2, 64),
(4, 57),
(4, 58),
(6, 57),
(6, 58),
(6, 60),
(6, 62),
(8, 58),
(8, 61),
(8, 62),
(8, 63),
(8, 64),
(10, 60),
(10, 62),
(10, 65),
(11, 60),
(19, 58),
(20, 63),
(20, 64),
(21, 59),
(22, 62);

CREATE TABLE `settings` (
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `settings` (`name`, `value`) VALUES
('siteName', 'NodeCMS'),
('address', 'www.example.com'),
('description', 'nothing to show.');

CREATE TABLE `users` (
  `uid` int(10) NOT NULL,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`uid`, `username`, `password`, `nickname`, `role`) VALUES
(0, 'admin', '$2b$10$iVgCjMc0ekP5s40Hwteq/.uHOZHG8x5DBsSaWb/0By2IFxoK0Si9q', 'admin', 0),
(33, 'admin12', '$2b$10$gOvrzagHvWhDxcj3OgMbke8zSK/nfpzVAjT8sDS0/llshsOvTMrrq', 'admin120', 1),
(51, 'admin102', '$2b$10$bnDudAUAHjG1Ob/zuMRk3.fu1G7Tsa04VsK6UqE54RYnzH892fH3m', 'admin12000000', 2),
(54, 'admin1022200', '$2b$10$Pol5vMlhpTVsiKLE/VYxBuSYPQpDXu8vdnMBm91YYrq5zHJeHllxi', '100000000', 2),
(56, 'admin100', '$2b$10$Xfu1FlmJWry3fHH8bZNDB.jCMoaDM.hnzUJ7lIsfZqIEtgiZ0UzJm', '0000000000000000', 2),
(57, 'admin555', '$2b$10$YiSmc10m5Me9WXmWfSg4K.0K/hrJwZLrpa7fC6HbwHax/P5LCG/6C', 'a100', 2),
(59, 'admin666', '$2b$10$qDUXPelu46YqB4zjM4WD1OxbstNqtGIfa7ZomNXuCJZnxyIerEqsa', '试试', 2),
(72, 'test123', '$2b$10$wYOfdNDfu5E.1QLtVHJIR.QqnZ53tFDrcKhRpk7bgFJnaVkY7elXW', 'test456', 2),
(73, 'test400', '$2b$10$fkrisOyNIYLu8WPfJJhicOA6LDZg.P634xFodSTah7wKBDpENYfum', '44566', 2),
(74, 'test0', '$2b$10$yB/EvjQAsPqXJwjJVXrkfO0nqtXlZBk12d4FXOsZyoyto5F8/Pb4O', '4568', 2),
(75, 'test777', '$2b$10$HqYyYqOV7iwYGFF8TyhaKerfrg9tSRPX33Nuqjo/.3eFIjOimhVEK', '456486', 2),
(77, '十六个字符十六个字符十六个字符的', '$2b$10$Bc5FVhVxOk2u7Zmunnt9HO9nIN3uHToDmlkOAb.QTdAKwuLIXxn8e', 'tryyyyyy000', 2),
(81, 'asd', '$2b$10$4wqPolPLJG6JVSaEGqBcgu3.KZvo79oOjE/um8TNjD8U6F9e98Zpq', 'ddd', 2),
(82, 'ddd', '$2b$10$s.vTVIjwhWnTbJVuHw37IOofLspTskIlbA38xtYPqZZuoPdMQqOxq', 'asdasda', 2),
(83, 'asdasd', '$2b$10$w3Whauh5O.oxlxg5z2tYuenyC1PTW8LRQoRdyyF8d0UQX9RkU0CwO', 'asdasdsda', 2),
(84, 'sdhfdg', '$2b$10$cLh3ecocfq2UIEIwV8AcUOnWnBgIVYrAKBbT/JRs3PxXc1kXOMjrW', 'hdfghdfgh', 2),
(85, 'asdfasdf', '$2b$10$.xpMQGXTusubNJv6asSVXu7cX9j4PF05hdm68yEDjPSlCr8aRSU3m', 'asdfasdfasdf', 2),
(87, 'asdaaaa', '$2b$10$T8YeY2Ek7kI2K.OI6.ekvO/2TdVLwL/vPiO.se5kZSzN8YVGm3KZC', 'asdas', 2),
(88, 'asdasdasdas', '$2b$10$wzFq/UPss1pYXNQJty63Me6uhhttmtLjVntNSbWJiQut3iR4GhX/m', 'asdasfsdaf', 2),
(89, 'fhdgfh', '$2b$10$3Lt3WbdtK.uE31YVzSF9WeAv.OQWQ9joA6HLkl7Q73ccFEH.0wYwa', 'ghj', 2),
(90, 'sfgh', '$2b$10$SBFA2Pxk1sGwjx7WYrjXTODpb4hmn9DrUCsKI.9lTiAnRFprH9Usi', 'fdghgf', 2),
(91, 'asdf', '$2b$10$jGr/Y/njYuqgbThe6Mtc3uvwe4csNxgUAEebcY8d.Z3hnid4G.Kle', 'asdfasdfsdf', 2),
(94, 'asdasd0', '$2b$10$EOnhVNzJ0UKgGwltYX62TukQl3Bt13DqlCNsD8pH/yWLfDJjn.hd.', 'gdgsg', 2),
(95, 'hhhhhhhhhhhhg', '$2b$10$1YDJ7CjlbnI5vdL26vwKA.35bXELnXGnyvlFTCRPwKkY1xBYvAvTG', '45f6g87g', 2),
(96, 'ghkhgjkhj', '$2b$10$3OAvqXzs8pJkIQ7oyUei6uogc8Is7r1MkgF7ut7f9Pw2oac71LXvy', 's1fd5', 2),
(97, 'fghjghjhjk', '$2b$10$LHVt.TnIMmMP5MCUAxMfEOdU8b8b7ml/MQ/Zqy9PwRjoGBr/mo8E.', 'kghuktyjf', 2),
(98, 'rtyerty', '$2b$10$VIV2QK2QtMwr7uroV5fdlO.RXIT1LsCM6BCFHn05bpD4p0jPU.5qy', 'urtsfg', 2),
(99, 'tyryerre', '$2b$10$qe7yOiBO8Nk9Y3vRCI2NFudDgdngRKhhwve/ipOGVg9w1jchqvRWi', 'wtreyrte', 2),
(100, 'frtyur', '$2b$10$T8Rqr/BZC6X5Yd0N0jb2/.gcaG.U4GxkXDNUFYt2gmhS322w4GCAG', 'wrtytry', 2),
(101, 'ioyutyr', '$2b$10$CItUG/lQXfYbIdZzEbrRfOlRVUa4mh3dhJycpxMburqFmdiGYi1qC', 'pouiyr', 2),
(102, 'oiutwrey', '$2b$10$cUz0Ybw6GT5O/vYJwNyjEOVbk3.exo.sVDiAZcVlsqPvLNmvEwfe6', 'tymhf', 2),
(103, 'ryubsdfdh', '$2b$10$3F7nREg90K9XA4M992ix9egmggarTVZ0kELStZRg3BWBE9KO6kef.', 'tktjgbf', 2),
(104, 'rgbnfgn', '$2b$10$kqIhmktdngYsodP3A.Dbx.Ou4fgVZGdzY2NIgIImcWjSeK.4R59kC', 'kfthfh', 2),
(105, 'dtyjdgfhndfn', '$2b$10$p7TSwzPY5Rl5SSrVRVFBh.nSXsUjhFcAyaxq4QhzTKUQPVhQ06s4S', 'fkyukuyffnhd', 2),
(106, 'ddfghfg', '$2b$10$XyWbk2l3s.SvsGRQmX1nWOjVXM./bPjDQFAptc6w4jKkCG7YcMnPm', 'hgfffgd', 2),
(107, 'edsfgdf', '$2b$10$MjokuFxAYln49CQM2k1EaOFpf0IHj3pp9ZGzeQg3Ke4BM66Kdxjb.', 'fuktyjftfj', 2),
(108, 'itwtrgd', '$2b$10$4iz9tdc0Q.XblbqkUS1bGOB4GV.zNAsijEP2GE/6Ctce3/BNHZelO', 'w45', 2),
(109, 'wrthsrbsf', '$2b$10$5yKhrAzU05WBNmGyxC5oSu3dNWwMMaePdGnzPMzMr1IHce39Wognu', 'tryjdjh', 2),
(110, 'asdbdb', '$2b$10$EMIPm3VNzk39/dCxLp7BO.QtVglqbUTXdpzdFUYhkDuOSsbbjURTy', 'dfdmghfhm', 2),
(111, 'djdfghjs', '$2b$10$fm/d6gVkwRa/hTXbPNTzMuCl8zlzHR1bZT.gBBReIoM25.FKpCNee', 'saserbsd', 2),
(112, 'wsrtry', '$2b$10$Kr6wzYOXnkIRW/SqT/psougKEks1GiUocKqlLYbqfi/1ud0wAqAg6', 'dsfghfg', 2),
(113, 'adgfdafsg', '$2b$10$JmCeAphFoW2G21GKfui6f.KQNA111qVBpoSVOdG/GvlsMxh2MoBZC', 'gnmbc', 2),
(114, 'sadfh', '$2b$10$1bWg..xH39ZLoHlhlgGbTOg1DHcSt/xhgKE8zSesMes3XpDy3/V.e', 'fsghfg', 2),
(115, 'asdfgd', '$2b$10$jtT5f5KNQnZoJzjTOpuhhOyxwhlG/Kh2Ch0ZCG0coNfDLD7sr1z8e', 'sdfgsdfg', 2),
(116, 'agdfg', '$2b$10$cdpI4vh596PBjZ.S59er3uktI9D6gkYftc3lqxCpW5hT151Fy83T.', '4156sdfg', 2),
(117, 'adhsdgh', '$2b$10$8j50RvGLJjTiGCn8PG1Z7uUtlIpC.PHS/AZJxXV7D2pcDFhihiHj2', 'dhjdgyj', 2),
(118, 'sfgnsdfgn', '$2b$10$w6ztsIZCKF4khL2mXe.4GeZ/cRx2BvHvDDSWDvdcLS2w5Tm4kyjcm', 'dfgndf', 2),
(120, 'asdfhbdfb', '$2b$10$5VMsmF.Zl4ypmlATj1QPXemAQwuSNoI02d8VKbnchXpVXeoDDspY6', 'fgndfgn', 2),
(121, 'sgfghjdf', '$2b$10$07548K2ngjgbubQ9qUmgpe9FUQLcj8cO970qJLcBQ9n786ydTCLu2', 'dfhjdtumfghm', 2),
(122, 'fmghm', '$2b$10$AGI4Vj/YJyDv.KyKhKmj7uXNpg9BXB9VhQfduhxf.mtqiWKLjCbXy', 'fghmfghm', 2),
(123, 'dhjghj', '$2b$10$6gfeCjJEdUkFAg7VsDfiZuGbseG9TO9h1nwMsUmKwQAKhSR8.x7MK', 'hjmhfgjmfgh', 2),
(124, 'srfgndfngu', '$2b$10$fwVPvJx6c/B616NVQOdZ6e.5CwHcqqbSmIL4xagzbNS.AZYGiNZ3K', 'dfbd', 2),
(125, 'sfgndf', '$2b$10$g5gt5DnWnn1ahskSvyHcO.7d5lsniwi.Dl6.gnnPFdCzjDxrrVfXe', 'dfhndgh', 2),
(126, 'd', '$2b$10$IsPEq0j7Si2LN6PaN/FGVOZ4w9XFjprzuzbcAipAwx.4UnHfhOtn6', 'sfdgjs', 2),
(127, 'rdgmfghj', '$2b$10$8E2FiAf4xumGV9Rwe4z4leVJJ/w3UkmvAWnaXZfq4EdUxxMjrTRFu', 'dfghmfgh', 2),
(128, 'wrtysdfb', '$2b$10$UCkypB0.2d.WGlBg9zZPu.Px7xNJjVRFCkQIgVF4gWSX6Gjrfna/m', 'stfyjdtysdbt', 2),
(129, 'aserhsrth', '$2b$10$tPYvCA1f.YJLMrxiAFhgr.yLpc64lyhM7z1SXFNpgGA6WQ0IWP2oS', 'dhmdgh', 2),
(130, 'adsnbsdg', '$2b$10$pk9Z9gW5Do5u8QDWz0IfEuNUSpdThQIh7Ldq310Ghag0rkB4ihQWu', '1gndsynd', 2),
(131, 'stydghmd', '$2b$10$eoG.xKpxqNKU21BzJc8i8uFuanWHW1nO5wrNhe3vlazEcqroPo.BO', 'ghfukfgu', 2),
(132, 'sadgfnbsfg', '$2b$10$TVjUjKvKGdQAt96aW3q9.OjkYxkNrqrCgz5IpU3g2WDjsfylS9sHK', 'nsdfgnfg', 2),
(133, 'fbdbsfdg', '$2b$10$NbnAWdFUTX4sv7/vM/43f.rfZxe/rIxUaUNoBCjlSP9Rm40B1UAIa', 'sfdnfg6n4f', 2),
(134, 'adfhsdhsdf', '$2b$10$HwUOzHlp0Dx5oNWTChQPBORKdf/Yor2in22GP/JEs9QFBijNPfWI6', 'sfyjtyhdfg', 2),
(135, 'sadfnsfgn', '$2b$10$DvshRfPGsnfpVDB1xXZeKOct/vkDXoPjDj36B5xGChI4JE32x1ES.', 'fjlfuf', 2),
(136, 'saedthfgn', '$2b$10$trhGbqlOZpN5XFXoscoNaO8w1e1Qm9dwyOgQQTrR26wqiWM2rbHbW', 'dfghmk.', 2),
(137, 'sdfj', '$2b$10$MFItiNpUpoqzplkUzDws3e3CF37sUo4vt7xtOvXwgR2wZd5d7.45S', 'jgdhj', 2),
(138, 'sdfuyd', '$2b$10$Fak.nqJ.jlGNwYi9bM5Jc.duYFLMUeZJXsd7/GFYy6FdJgS5l0yOK', 'fm,fj', 2),
(140, '4444564', '$2b$10$.gEpwh04STdD7vU7gmVAxe7MXznu1oWhg8B8q/qLr2j2QDNLJ4C52', '454564', 1),
(141, '516', '$2b$10$XtZl4YbbJ.o8cUmXkEZ9QOjUfaSsvdzpMhE3Bt6GgFfezkpYcj2Nq', '516', 2);


ALTER TABLE `contents`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `metas`
  ADD PRIMARY KEY (`mid`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `relationships`
  ADD PRIMARY KEY (`cid`,`mid`),
  ADD KEY `mid` (`mid`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `nickName` (`nickname`);


ALTER TABLE `contents`
  MODIFY `cid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

ALTER TABLE `metas`
  MODIFY `mid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

ALTER TABLE `users`
  MODIFY `uid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;


ALTER TABLE `relationships`
  ADD CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `contents` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mid` FOREIGN KEY (`mid`) REFERENCES `metas` (`mid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
