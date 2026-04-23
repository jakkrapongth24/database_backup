/*
 Navicat Premium Data Transfer

 Source Server         : Web_App
 Source Server Type    : MySQL
 Source Server Version : 101110 (10.11.10-MariaDB-log)
 Source Host           : 192.168.60.201:3306
 Source Schema         : bp_webapp

 Target Server Type    : MySQL
 Target Server Version : 101110 (10.11.10-MariaDB-log)
 File Encoding         : 65001

 Date: 22/04/2026 18:52:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bank_accounts
-- ----------------------------
DROP TABLE IF EXISTS `bank_accounts`;
CREATE TABLE `bank_accounts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เลขบัตรประชาชน (เชื่อมกับตาราง personel)',
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อธนาคาร',
  `account_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เลขบัญชีธนาคาร',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'สถานะ: active/inactive',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bank_accounts_cid_index`(`cid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 229 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bank_accounts
-- ----------------------------
INSERT INTO `bank_accounts` VALUES (62, '3430400040914', 'ธนาคารกรุงไทย (KTB)', 'นายวิทยา     บุตรสาระ', '4080216513', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (63, '1729900160543', 'ธนาคารกรุงไทย (KTB)', 'นายภัทรพงษ์พันธ์  วัฒนพล', '6605626834', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (64, '1489900322341', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพรรณิภา  โกศล', '4083434058', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (65, '1103900045078', 'ธนาคารกรุงไทย (KTB)', 'นายปราณ  กำจัดภัย', '6636171146', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (66, '1103900055090', 'ธนาคารกรุงไทย (KTB)', 'นางสาวเมธาวีร์  วรวัฒนะกุล', '6636170638', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (67, '1103702980943', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพีรยา  ตังคะวชิรานนท์', '1720450684', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (68, '1489900377031', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจิรัชยา  ศรัทธาพันธ์', '6625600679', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (69, '3480400073341', 'ธนาคารกรุงไทย (KTB)', 'นางสาววนิดา     อภัยโส', '4081473846', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (70, '1100702810123', 'ธนาคารกรุงไทย (KTB)', 'นางสาวภณิพิมพ์  ฟองพิสุทธิกุล', '4083374926', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (71, '1103702540358', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอิงลดา  กิจพิมล', '4083375043', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (72, '1480400057942', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมณีรัตน์    ผาลี', '9839918931', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (73, '1479900342181', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมาลิน  บุพศิริ', '9849629975', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (74, '1103702648442', 'ธนาคารกรุงไทย (KTB)', 'นางสาววลีรัตญา  นิลคง', '6786007341', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (75, '1480400054901', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพัชรนันท์  ฤทธิเดช', '6641884988', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (76, '3480400064457', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุภัสสร     อุดมกัน', '6787450788', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (77, '1480400092802', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนงค์ลักษณ์  สะนาค', '6641885747', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (78, '3101400231314', 'ธนาคารกรุงไทย (KTB)', 'นางสาววัชราภรณ์  อติวรรณกุล', '4080178980', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (79, '3480700056841', 'ธนาคารกรุงไทย (KTB)', 'นางฐิติวรดา     ใจช่วง', '4080074085', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (80, '1480500117050', 'ธนาคารกรุงไทย (KTB)', 'นางจิราภรณ์    แสนคุณท้าว', '9839919288', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (81, '1489900240841', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุรีรัตน์  สีหาบุตร', '6609137838', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (82, '1430900227545', 'ธนาคารกรุงไทย (KTB)', 'นางสาวฐายิกา  ทิพย์แสง', '6794604167', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (83, '1410100174064', 'ธนาคารกรุงไทย (KTB)', 'นางสาวปนัดดา  มีจันที', '6612118393', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (84, '3340100617486', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพิมพา   คำก้อน', '4080750579', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (85, '3480400213720', 'ธนาคารกรุงไทย (KTB)', 'นายจักรกฤษณ์ มานันที', '6641880370', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (86, '3480400326117', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพิสมัย  ป้องหา', '6641884694', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (87, '1480400104819', 'ธนาคารกรุงไทย (KTB)', 'นายวุฒิพงษ์  ทวนกลาง', '6786627277', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (88, '3480400233062', 'ธนาคารกรุงไทย (KTB)', 'นางยุพนา     ลิงลม', '4080085753', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (89, '3480600323740', 'ธนาคารกรุงไทย (KTB)', 'นางมะลินี     โพชะโน', '4080214421', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (90, '3480400067006', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมลิวรรณ    อ้วนแก้ว', '4080262078', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (91, '3480400075416', 'ธนาคารกรุงไทย (KTB)', 'นางรังสิมา     สิถิระบุตร', '4080212771', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (92, '3480300702249', 'ธนาคารกรุงไทย (KTB)', 'นางสุมาลี       อ้วนแก้ว', '6625119628', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (93, '3480400305292', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสาธินี    บุรีวงค์', '4081838844', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (94, '3110400242277', 'ธนาคารกรุงไทย (KTB)', 'นางสาวณิชกช    อาตวงศ์', '4081838887', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (95, '3480400378214', 'ธนาคารกรุงไทย (KTB)', 'นางนวลนาง    ลวกุณ', '4080091702', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (96, '1480400010041', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจิราภรณ์    สุราสา', '4080751958', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (97, '3480400147069', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุจิตรา   ขออาศัย', '4081932913', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (98, '1430900202241', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมาฆศิริ  ศรีนาทม', '6794573709', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (99, '3480400072212', 'ธนาคารกรุงไทย (KTB)', 'นางภิญญา  ฮามพันธ์เมือง', '4080079796', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (100, '3480400410487', 'ธนาคารกรุงไทย (KTB)', 'นางนิมิตร   ไชยภูวงศ์', '4080082347', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (101, '3480400233631', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจันทร์จิรา   กุณรักษ์', '6641879607', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (102, '3480400066395', 'ธนาคารกรุงไทย (KTB)', 'นางพวงเพชร     สมเพราะ', '6641878740', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (103, '3480400377358', 'ธนาคารกรุงไทย (KTB)', 'นางทัศนา       ต้นสียา', '6641879046', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (104, '1480400056172', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนาตยา    สุวรรณใจ', '4083520272', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (105, '1480700147653', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนันทิกา  ปัญญาพ่อ', '6601886246', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (106, '1489900331481', 'ธนาคารกรุงไทย (KTB)', 'นายกฤษณชัย  สมมะโน', '6641882519', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (107, '1489700006951', 'ธนาคารกรุงไทย (KTB)', 'นายธีรภัทร  จู่มา', '6641885402', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (108, '1419902085479', 'ธนาคารกรุงไทย (KTB)', 'นายโชคอนันต์  ภูมิประสาท', '4180766507', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (109, '1479300012279', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนลินี ทนุพร', '4193527530', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (110, '1570200063891', 'ธนาคารกรุงไทย (KTB)', 'นางสาวรจนา  ผาแก้ว', '6641882977', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (111, '1480800137781', 'ธนาคารกรุงไทย (KTB)', 'นายเอกสิทธิ์  เสนเพ็ง', '6602667092', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (112, '1480400095755', 'ธนาคารกรุงไทย (KTB)', 'นายฤทธิพงษ์  บุญศรี', '9838489522', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (113, '1480400049761', 'ธนาคารกรุงไทย (KTB)', 'นายวีระชัย  อภัยโส', '6641892840', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (114, '3480300380837', 'ธนาคารกรุงไทย (KTB)', 'นางศิตา    พลีจันทร์', '4080136404', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (115, '3480400073324', 'ธนาคารกรุงไทย (KTB)', 'นางยุพิน    นวานุช', '4080267827', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (116, '3480400366089', 'ธนาคารกรุงไทย (KTB)', 'นายพลาธิป     บุญทา', '4080136382', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (117, '1480400053602', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุชาดา  เสนาราช', '6638944320', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (118, '1480400061711', 'ธนาคารกรุงไทย (KTB)', 'นางสาววลัยภรณ์  จองไว', '4500592709', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (119, '3480400375312', 'ธนาคารกรุงไทย (KTB)', 'นางสาววรรณวิมล  คำมุข', '4081556881', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (120, '1480400006272', 'ธนาคารกรุงไทย (KTB)', 'นางสาวทิพารัตน์   เรือนทอง', '4080302711', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (121, '1480400117481', 'ธนาคารกรุงไทย (KTB)', 'นางสาวณัฐกานต์    เวียงสิมา', '4300813639', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (122, '3480400075424', 'ธนาคารกรุงไทย (KTB)', 'นางประเดิม     อภัยโส', '4080077963', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (123, '3480800274581', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกนกวรรณ  สายบุญเลิศ', '6795475182', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (124, '1480400105386', 'ธนาคารกรุงไทย (KTB)', 'นายทิวัตถ์  ไชยพร', '9848120068', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (125, '1430300250490', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจุไรรัตน์  แก้วทอง', '4300842388', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (126, '3430400073316', 'ธนาคารกรุงไทย (KTB)', 'นางสายสมร    ตั้งจรูญศรี', '4080085737', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (127, '3480300684348', 'ธนาคารกรุงไทย (KTB)', 'นางสาวดาวนภา     ศรีวรสาร', '4080081685', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (128, '3430900614251', 'ธนาคารกรุงไทย (KTB)', 'นางเปรมฤดี     คำจันทร์ศรี', '4080089899', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (129, '1480800012784', 'ธนาคารกรุงไทย (KTB)', 'นายเอกพจน์   เสถา', '4080908768', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (130, '3480400267005', 'ธนาคารกรุงไทย (KTB)', 'นางสาวภรภัค   เมืองซอง', '4081711585', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (131, '3480400062314', 'ธนาคารกรุงไทย (KTB)', 'นางณวรัตน์     เสียงล้ำ', '4080081715', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (132, '3480200024796', 'ธนาคารกรุงไทย (KTB)', 'นางพัชราภรณ์     ศรีเพชร', '4080079834', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (133, '3010701322467', 'ธนาคารกรุงไทย (KTB)', 'นางปรารถนา      คำมุข', '4080177739', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (134, '3480400407052', 'ธนาคารกรุงไทย (KTB)', 'นายลักเร่    อุดมมา', '6641881555', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (135, '3480400218985', 'ธนาคารกรุงไทย (KTB)', 'นายจีรพันธ์    หญ้างาม', '6641885445', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (136, '3480400088119', 'ธนาคารกรุงไทย (KTB)', 'นางวันวิสา  ขันเดช', '6641880214', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (137, '3480400243424', 'ธนาคารกรุงไทย (KTB)', 'นางจันทร์จิรา     ศรีเหล่า', '4080078277', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (138, '3480800060785', 'ธนาคารกรุงไทย (KTB)', 'นางจิณณ์ภัคธนา    เนตรวงค์', '4080370636', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (139, '3480400008859', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอภิญญา    อุปเสน', '4080470460', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (140, '3480400377251', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุกาญดา    ภาสอน', '6735622928', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (141, '1480400045774', 'ธนาคารกรุงไทย (KTB)', 'นางสาวเพียงพิศ  สมรฤทธิ์', '4080495552', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (142, '1489900121923', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุทธิดา    สีหา', '9850593229', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (143, '1480400084516', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุธีธิดา  เสียงล้ำ', '9846118155', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (144, '1480500116771', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกมลชนก  อุ่นชัย', '9839919687', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (145, '1480701245985', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมัยญรัตน์  อุดมทนานุกูล', '4210517771', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (146, '3480400406986', 'ธนาคารกรุงไทย (KTB)', 'นายไพ     มุมา', '6641881016', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (147, '1480400002901', 'ธนาคารกรุงไทย (KTB)', 'นายสมพงษ์  อุปเสน', '6641881768', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (148, '3480400416914', 'ธนาคารกรุงไทย (KTB)', 'นายจันธิราช    ไชยภูวงศ์', '6641882942', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (149, '1480400124127', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสาวิตรี  นาโสก', '6714577915', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (150, '1480400112030', 'ธนาคารกรุงไทย (KTB)', 'นายอภิวัฒน์  บรรเทา', '6642143159', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (151, '1480400100121', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุคนธา  ถาปาบุตร', '6641882268', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (152, '1489900374996', 'ธนาคารกรุงไทย (KTB)', 'นางสาวธัญนาฏ  อภัยโส', '9864111078', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (153, '3480400236754', 'ธนาคารกรุงไทย (KTB)', 'นางสาวชุติกาญจน์  ก่ำเสริฐ', '6641884155', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (154, '1480400047271', 'ธนาคารกรุงไทย (KTB)', 'นางแสงระวี    หญ้างาม', '6641544559', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (155, '1480400098754', 'ธนาคารกรุงไทย (KTB)', 'นางสาวชลิตา  สาสาย', '4080644280', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (156, '1407500024350', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพรนัชชา  ชาวยศ', '6617840127', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (157, '1340400229035', 'ธนาคารกรุงไทย (KTB)', 'นางสาวช่อผกา  ตั้งจรูญศรี', '9861455701', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (158, '1421300016803', 'ธนาคารกรุงไทย (KTB)', 'นายพลวัตร  นิลตานนท์', '6605595130', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (159, '1480400055656', 'ธนาคารกรุงไทย (KTB)', 'นายยศดนัย  อภัยโส', '6646281599', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (160, '1410800101752', 'ธนาคารกรุงไทย (KTB)', 'นายหัถชัย  หัสเดชะ', '6777412689', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (161, '1489700029276', 'ธนาคารกรุงไทย (KTB)', 'นายเอกพร  เจริญผล', '6629182618', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (162, '1431100024659', 'ธนาคารกรุงไทย (KTB)', 'นายเสกสรร  คะสาน', '6647039503', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (163, '1489700005504', 'ธนาคารกรุงไทย (KTB)', 'นางสาวธนัญญา พยุงวงศ์', '6798226426', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (164, '3480400073332', 'ธนาคารกรุงไทย (KTB)', 'นางยุพารี    ทัพวัน', '4080100736', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (165, '3480800396724', 'ธนาคารกรุงไทย (KTB)', 'นางสันสนี     ใหม่วงค์', '4080078218', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (166, '5480300007814', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนุชจรี     บุตรบุรี', '4080081707', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (167, '1480400051120', 'ธนาคารกรุงไทย (KTB)', 'นางสาวภัคศรัณย์  วงษา', '6629701402', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (168, '3480400214831', 'ธนาคารกรุงไทย (KTB)', 'นางประทุมมี  ตันสาย', '6641878147', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (169, '3460300724170', 'ธนาคารกรุงไทย (KTB)', 'นางพัชรินทร์   ทันจันทร์', '6623088733', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (170, '3480400083931', 'ธนาคารกรุงไทย (KTB)', 'นางสมภักตร์    ภาโสม', '4080292538', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (171, '2480400001392', 'ธนาคารกรุงไทย (KTB)', 'นางปราณี     ศิลป์ชัย', '6641892042', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (172, '3480400408903', 'ธนาคารกรุงไทย (KTB)', 'นางสาวฐิรพร    ธรรมจันทร์', '6641880885', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (173, '1209702023722', 'ธนาคารกรุงไทย (KTB)', 'นายธนเดช  นิยมกูล', '6641883566', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (174, '1489700006314', 'ธนาคารกรุงไทย (KTB)', 'นางสาวรัชฏาวรรณ  ผาลี', '6648155876', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (175, '3480500265268', 'ธนาคารกรุงไทย (KTB)', 'นางสาวบุษกร    สำเภา', '4080097220', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (176, '3480300749725', 'ธนาคารกรุงไทย (KTB)', 'นางธนพร  วรรณแสง', '6641879925', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (177, '1480400086233', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอินธุอร   ศรีนันทา', '6641883159', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (178, '3480400226503', 'ธนาคารกรุงไทย (KTB)', 'นางสาวศศิธร  สุวารีย์', '6641886964', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (179, '1480700110563', 'ธนาคารกรุงไทย (KTB)', 'นางสาวลดาวัลย์  ไตยราช', '6641884007', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (180, '1470800221634', 'ธนาคารกรุงไทย (KTB)', 'นางสาววิสุดา   บาลจบ', '6641886549', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (181, '1480800159238', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพรธิตา  ศิริวงศ์', '9864992031', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (182, '1489900398356', 'ธนาคารกรุงไทย (KTB)', 'นายภูริภัทร์  หวายสุด', '4083341262', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (183, '1480500097351', 'ธนาคารกรุงไทย (KTB)', 'นางสาวเพ็ญพร   เอกจักรแก้ว', '4210218235', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (184, '1479900472513', 'ธนาคารกรุงไทย (KTB)', 'นายกิตติคุณ  มัยวงศ์', '9838933570', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (185, '1103700452320', 'ธนาคารกรุงไทย (KTB)', 'นางธัญญาลักษณ์  ประยูรเสาวภาคย์', '4400361837', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (186, '1480400096352', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพิมศิริ  เกษบัว', '6641881962', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (187, '1481100027500', 'ธนาคารกรุงไทย (KTB)', 'นางสาวรมิดา  วงษา', '8283268465', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (188, '3480300048174', 'ธนาคารกรุงไทย (KTB)', 'นายวิทวัส     ศรีเพชร', '4081948976', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (189, '1481000066902', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุชาดา   ราชมณี', '4080508824', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (190, '1489900374651', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอริญา  ท่าทม', '9862817542', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (191, '1350300094855', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุภัสสร   วรรณอ่อน', '9839067494', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (192, '1471300089860', 'ธนาคารกรุงไทย (KTB)', 'นางสาวเกวรินทร์  โตมาชา', '6645738447', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (193, '1509966081571', 'ธนาคารกรุงไทย (KTB)', 'นายภัทรเชษฐ  รุ่งโรจน์วัฒนศิริ', '2613367687', '2026-03-13 14:36:07', '2026-03-13 14:36:07', 'active');
INSERT INTO `bank_accounts` VALUES (194, '1489700000430', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจิราพัชร  เขียวคำ', '6632605222', '2026-03-13 14:36:08', '2026-04-08 14:51:02', 'active');
INSERT INTO `bank_accounts` VALUES (195, '3480200214056', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกวินารัตน์     คำศรี', '4080160356', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (196, '1419901775099', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอาทิตยา  โคตรสมบัติ', '4083382376', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (197, '1430500375610', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกรวิภา  วงษ์ชัย', '6600044357', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (198, '3480400377561', 'ธนาคารกรุงไทย (KTB)', 'นายบรรจง   ทุมพิลา', '6641883698', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (199, '1489700006624', 'ธนาคารกรุงไทย (KTB)', 'นางสาวอริศรา  อุดมกัน', '6628404714', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (200, '3480400055164', 'ธนาคารกรุงไทย (KTB)', 'นางเอื้อมพร  สุวรรณใจ', '6646540748', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (201, '3480300005661', 'ธนาคารกรุงไทย (KTB)', 'นางเกษมณี  วิจันทร์', '3011949034', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (202, '1410401515481', 'ธนาคารกรุงไทย (KTB)', 'นายวิศวะ  ศรีวงษ์ราช', '4180905981', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (203, '3480400074142', 'ธนาคารกรุงไทย (KTB)', 'นายปริญญา    อภัยโส', '6641883310', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (204, '3480400073278', 'ธนาคารกรุงไทย (KTB)', 'นายณัฐภัทร  อภัยโส', '6641879275', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (205, '3480400065691', 'ธนาคารกรุงไทย (KTB)', 'นายอิทธิพล    ภาโสม', '6641879666', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (206, '1459900068054', 'ธนาคารกรุงไทย (KTB)', 'นายอนันต์   สีหาบุตร', '6641936333', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (207, '3480200314247', 'ธนาคารกรุงไทย (KTB)', 'นายขวัญชัย  คุยพร', '6641708675', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (208, '1480400109284', 'ธนาคารกรุงไทย (KTB)', 'นายทวีวัฒน์  สุพรรณ์', '6641878066', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (209, '1489900165777', 'ธนาคารกรุงไทย (KTB)', 'นายธวัชชัย  พรมราช', '6641878678', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (210, '3480400073154', 'ธนาคารกรุงไทย (KTB)', 'นายสาโรช  สมเทพ', '6648907436', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (211, '3430900615584', 'ธนาคารกรุงไทย (KTB)', 'นางวิลาวัลย์  พรหมจอม', '6641885895', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (212, '1340400210008', 'ธนาคารกรุงไทย (KTB)', 'นายวัชรพงศ์  ตั้งจรูญศรี', '6620118062', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (213, '1480100127210', 'ธนาคารกรุงไทย (KTB)', 'นางสาวมนัสนันท์  เสนจันทร์ฒิไชย', '6641886050', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (214, '1480400116612', 'ธนาคารกรุงไทย (KTB)', 'นางสาวนิตยา  ศรีลาคม', '4300986185', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (215, '1301502002332', 'ธนาคารกรุงไทย (KTB)', 'นายจิรายุส  ครุฑใจกล้า', '9848532757', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (216, '3439900079192', 'ธนาคารกรุงไทย (KTB)', 'นางสาวรัชดา  บุตรวงค์', '4080136374', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (217, '1480800044627', 'ธนาคารกรุงไทย (KTB)', 'นางสาวจินตหรา  นิมิตร', '9850226463', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (218, '1470100279273', 'ธนาคารกรุงไทย (KTB)', 'นายมงคล  โพธิ์นะ', '4083227877', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (219, '1480400057381', 'ธนาคารกรุงไทย (KTB)', 'นางสาวเตือนใจ งามแฉ้ม', '9854843157', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (220, '1480501295156', 'ธนาคารกรุงไทย (KTB)', 'นางสาวพรนภา  พลายงาม', '8850359640', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (221, '1431100044579', 'ธนาคารกรุงไทย (KTB)', 'นางสาวสุดารัตน์  แพงโท', '6604110303', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (222, '3540400307766', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกัณณิกา  ช้างมูบ', '6641886409', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (223, '1480400035213', 'ธนาคารกรุงไทย (KTB)', 'นายสุวัฒน์ชัย  อภัยโส', '6641884724', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (224, '1480400040438', 'ธนาคารกรุงไทย (KTB)', 'นายวีรพล  เสนจันทร์ฒิไชย', '6641885186', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (225, '1480400046941', 'ธนาคารกรุงไทย (KTB)', 'นายพงศธร  พรมจอม', '6643378699', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (226, '1250100358515', 'ธนาคารกรุงไทย (KTB)', 'นางสาวกนิษฐา  วงษ์หอย', '4780601371', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (227, '1480800122181', 'ธนาคารกรุงไทย (KTB)', 'นายจักรพงศ์  ทิพยศรี', '4083108983', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');
INSERT INTO `bank_accounts` VALUES (228, '1480400109152', 'ธนาคารกรุงไทย (KTB)', 'นายธนากร  พรหมจอม', '6647047018', '2026-03-13 14:36:08', '2026-03-13 14:36:08', 'active');

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('bp-webapp-cache-21129479e6d1e39de6deaf68e74d39d0cebbcf82', 'i:1;', 1776666031);
INSERT INTO `cache` VALUES ('bp-webapp-cache-21129479e6d1e39de6deaf68e74d39d0cebbcf82:timer', 'i:1776666031;', 1776666031);
INSERT INTO `cache` VALUES ('bp-webapp-cache-4b56f7f0b4c15ba746284502b96b2fc80b884098', 'i:1;', 1776670115);
INSERT INTO `cache` VALUES ('bp-webapp-cache-4b56f7f0b4c15ba746284502b96b2fc80b884098:timer', 'i:1776670115;', 1776670115);
INSERT INTO `cache` VALUES ('bp-webapp-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', 1776745771);
INSERT INTO `cache` VALUES ('bp-webapp-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1776745771;', 1776745771);
INSERT INTO `cache` VALUES ('bp-webapp-cache-6f844f63892267706ff1b217f331ac646722abd0', 'i:1;', 1776657155);
INSERT INTO `cache` VALUES ('bp-webapp-cache-6f844f63892267706ff1b217f331ac646722abd0:timer', 'i:1776657155;', 1776657155);
INSERT INTO `cache` VALUES ('bp-webapp-cache-74c40c8eea27888202480245a1c4a744f4f77f02', 'i:1;', 1776752502);
INSERT INTO `cache` VALUES ('bp-webapp-cache-74c40c8eea27888202480245a1c4a744f4f77f02:timer', 'i:1776752502;', 1776752502);
INSERT INTO `cache` VALUES ('bp-webapp-cache-b34dbb39ac511c1057425e4a0fd5a712f0ea9b41', 'i:1;', 1776764457);
INSERT INTO `cache` VALUES ('bp-webapp-cache-b34dbb39ac511c1057425e4a0fd5a712f0ea9b41:timer', 'i:1776764457;', 1776764457);
INSERT INTO `cache` VALUES ('bp-webapp-cache-b6c725df5e4d64beb7a2af291a6f9636e0aa1a21', 'i:1;', 1776757055);
INSERT INTO `cache` VALUES ('bp-webapp-cache-b6c725df5e4d64beb7a2af291a6f9636e0aa1a21:timer', 'i:1776757055;', 1776757055);
INSERT INTO `cache` VALUES ('bp-webapp-cache-e261c66a78e1a4b51657a41c6129d1996f750fc6', 'i:2;', 1776839914);
INSERT INTO `cache` VALUES ('bp-webapp-cache-e261c66a78e1a4b51657a41c6129d1996f750fc6:timer', 'i:1776839914;', 1776839914);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of departments
-- ----------------------------
INSERT INTO `departments` VALUES (1, 'กลุ่มงานบริหารทั่วไป', NULL, NULL);
INSERT INTO `departments` VALUES (2, 'งานห้องคลอดและผ่าตัด', NULL, NULL);
INSERT INTO `departments` VALUES (3, 'งานผู้ป่วยนอก', NULL, NULL);
INSERT INTO `departments` VALUES (4, 'กลุ่มงานประกันสุขภาพยุทธศาสตร์', NULL, NULL);
INSERT INTO `departments` VALUES (5, 'งานผู้ป่วยใน', NULL, NULL);
INSERT INTO `departments` VALUES (6, 'งานอุบัติเหตุฉุกเฉินและนิติเวช', NULL, NULL);
INSERT INTO `departments` VALUES (7, 'กลุ่มงานการแพทย์แผนไทยและการแพทย์ทางเลือก', NULL, NULL);
INSERT INTO `departments` VALUES (8, 'กลุ่มงานกายภาพ', NULL, NULL);
INSERT INTO `departments` VALUES (9, 'กลุ่มงานทันตกรรม', NULL, NULL);
INSERT INTO `departments` VALUES (10, 'กลุ่มงานรังสีวิทยา', NULL, NULL);
INSERT INTO `departments` VALUES (11, 'กลุ่มงานเภสัชกรรมและคุ้มครองผู้บริโภค', NULL, NULL);
INSERT INTO `departments` VALUES (12, 'งานอนามัยสิ่งแวดล้อมและควบคุมโรค', NULL, NULL);
INSERT INTO `departments` VALUES (13, 'กลุ่มงานสุขภาพดิจิทัล', NULL, NULL);
INSERT INTO `departments` VALUES (14, 'กลุ่มงานบริการด้านปฐมภูมิและองค์รวม', NULL, NULL);
INSERT INTO `departments` VALUES (16, 'งานซักฟอก จ่ายกลาง', NULL, NULL);
INSERT INTO `departments` VALUES (17, 'กลุ่มงานเทคนิคการแพทย์', NULL, NULL);
INSERT INTO `departments` VALUES (18, 'กลุ่มงานจิตเวชและยาเสพติด', NULL, NULL);
INSERT INTO `departments` VALUES (19, 'กลุ่มงานการแพทย์', NULL, NULL);
INSERT INTO `departments` VALUES (20, 'มินิธัญญารักษ์', NULL, NULL);
INSERT INTO `departments` VALUES (21, 'ผู้อำนวยการโรงพยาบาล', NULL, NULL);
INSERT INTO `departments` VALUES (22, 'งานโภชนาการ', NULL, '2026-02-27 09:01:06');
INSERT INTO `departments` VALUES (23, 'งานการเงิน', NULL, NULL);
INSERT INTO `departments` VALUES (25, 'งานพัสดุ', NULL, '2026-02-27 09:01:20');
INSERT INTO `departments` VALUES (27, 'กลุ่มการพยาบาล', NULL, NULL);
INSERT INTO `departments` VALUES (29, 'ศูนย์จัดเก็บรายได้', NULL, NULL);
INSERT INTO `departments` VALUES (32, 'คลินิกพิเศษ', NULL, NULL);
INSERT INTO `departments` VALUES (33, 'งานการเงินและบัญชี', '2026-02-27 09:01:46', '2026-02-27 09:01:46');
INSERT INTO `departments` VALUES (34, 'งานยานพาหนะ', '2026-02-28 09:44:53', '2026-02-28 09:44:53');

-- ----------------------------
-- Table structure for dormitories
-- ----------------------------
DROP TABLE IF EXISTS `dormitories`;
CREATE TABLE `dormitories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('flat','house') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'flat',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitories
-- ----------------------------
INSERT INTO `dormitories` VALUES (2, 'บ้านพักแถวที่ 2', 'house', NULL, 'active', '2026-04-18 19:29:28', '2026-04-21 14:50:51');
INSERT INTO `dormitories` VALUES (3, 'แฟลต 3 ชั้น', 'flat', NULL, 'active', '2026-04-19 18:28:28', '2026-04-21 14:50:26');
INSERT INTO `dormitories` VALUES (4, 'บ้านพักแถวที่ 1', 'house', NULL, 'active', '2026-04-19 21:27:36', '2026-04-21 14:50:43');
INSERT INTO `dormitories` VALUES (5, 'บ้านพักเป็นหลัง 1', 'house', NULL, 'active', '2026-04-21 14:51:13', '2026-04-21 14:51:21');
INSERT INTO `dormitories` VALUES (6, 'บ้านพักเป็นหลัง 2', 'house', NULL, 'active', '2026-04-21 14:51:36', '2026-04-21 14:51:36');
INSERT INTO `dormitories` VALUES (7, 'บ้านพักเป็นหลัง 3', 'house', NULL, 'active', '2026-04-21 14:51:51', '2026-04-21 14:51:51');
INSERT INTO `dormitories` VALUES (8, 'บ้านพักเป็นหลัง 4', 'house', NULL, 'active', '2026-04-21 14:52:12', '2026-04-21 14:52:12');
INSERT INTO `dormitories` VALUES (9, 'บ้านพักเป็นหลัง 5', 'house', NULL, 'active', '2026-04-21 14:52:31', '2026-04-21 14:52:36');
INSERT INTO `dormitories` VALUES (10, 'บ้านพักเป็นหลัง 6', 'house', NULL, 'active', '2026-04-21 14:52:44', '2026-04-21 14:52:44');
INSERT INTO `dormitories` VALUES (11, 'บ้านพักเป็นหลัง 7', 'house', NULL, 'active', '2026-04-21 14:52:52', '2026-04-21 14:52:52');
INSERT INTO `dormitories` VALUES (12, 'บ้านพักเป็นหลัง 8', 'house', NULL, 'active', '2026-04-21 14:53:59', '2026-04-21 14:53:59');
INSERT INTO `dormitories` VALUES (13, 'บ้านพักเป็นหลัง 9', 'house', NULL, 'active', '2026-04-21 14:54:14', '2026-04-21 14:54:14');
INSERT INTO `dormitories` VALUES (14, 'บ้านพักเป็นหลัง 10', 'house', NULL, 'active', '2026-04-21 14:54:23', '2026-04-21 14:54:23');
INSERT INTO `dormitories` VALUES (15, 'บ้านพักเป็นหลัง 11', 'house', NULL, 'active', '2026-04-21 14:54:47', '2026-04-21 14:54:47');
INSERT INTO `dormitories` VALUES (16, 'บ้านพักเป็นหลัง 12', 'house', NULL, 'active', '2026-04-21 14:54:54', '2026-04-21 14:54:54');
INSERT INTO `dormitories` VALUES (17, 'บ้านพักเป็นหลัง 13', 'house', NULL, 'active', '2026-04-21 14:55:02', '2026-04-21 14:55:02');

-- ----------------------------
-- Table structure for dormitory_bill_items
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_bill_items`;
CREATE TABLE `dormitory_bill_items`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `bill_id` bigint UNSIGNED NOT NULL,
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10, 2) NOT NULL DEFAULT 1.00,
  `unit_price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dormitory_bill_items_bill_id_index`(`bill_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_bill_items
-- ----------------------------

-- ----------------------------
-- Table structure for dormitory_billing_settings
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_billing_settings`;
CREATE TABLE `dormitory_billing_settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `water_unit_rate` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_unit_rate` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `water_management_fee_default` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_management_fee_default` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `common_area_fee_default` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_billing_settings
-- ----------------------------
INSERT INTO `dormitory_billing_settings` VALUES (1, 8.00, 5.00, 30.00, 30.00, 80.00, '2026-04-18 20:57:03', '2026-04-18 20:58:37');

-- ----------------------------
-- Table structure for dormitory_bills
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_bills`;
CREATE TABLE `dormitory_bills`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `room_id` bigint UNSIGNED NOT NULL,
  `bill_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `billing_month` date NOT NULL,
  `issue_date` date NULL DEFAULT NULL,
  `due_date` date NULL DEFAULT NULL,
  `water_previous_reading` decimal(10, 2) NULL DEFAULT NULL,
  `water_current_reading` decimal(10, 2) NULL DEFAULT NULL,
  `water_units_used` decimal(10, 2) NULL DEFAULT NULL,
  `water_unit_rate` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_previous_reading` decimal(10, 2) NULL DEFAULT NULL,
  `electricity_current_reading` decimal(10, 2) NULL DEFAULT NULL,
  `electricity_units_used` decimal(10, 2) NULL DEFAULT NULL,
  `electricity_allowance_units` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_units_chargeable` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_unit_rate` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `water_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `water_management_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `electricity_management_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `common_area_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `other_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `meter_start` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meter_end` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `units_used` decimal(10, 2) NULL DEFAULT NULL,
  `status` enum('draft','issued','paid','overdue','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dormitory_bills_bill_no_unique`(`bill_no`) USING BTREE,
  INDEX `dormitory_bills_room_id_billing_month_index`(`room_id`, `billing_month`) USING BTREE,
  INDEX `dormitory_bills_status_due_date_index`(`status`, `due_date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_bills
-- ----------------------------

-- ----------------------------
-- Table structure for dormitory_ot_deductions
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_ot_deductions`;
CREATE TABLE `dormitory_ot_deductions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `bill_id` bigint UNSIGNED NOT NULL,
  `is_deducted` tinyint(1) NOT NULL DEFAULT 0,
  `deducted_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dormitory_ot_deductions_bill_id_unique`(`bill_id`) USING BTREE,
  INDEX `dormitory_ot_deductions_updated_by_foreign`(`updated_by`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of dormitory_ot_deductions
-- ----------------------------

-- ----------------------------
-- Table structure for dormitory_payment_records
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_payment_records`;
CREATE TABLE `dormitory_payment_records`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `bill_id` bigint UNSIGNED NOT NULL,
  `paid_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `paid_at` date NULL DEFAULT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `reference_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `slip_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `slip_original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `recorded_by` bigint UNSIGNED NULL DEFAULT NULL,
  `status` enum('pending','paid','partial','void') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dormitory_payment_records_recorded_by_foreign`(`recorded_by`) USING BTREE,
  INDEX `dormitory_payment_records_bill_id_status_index`(`bill_id`, `status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_payment_records
-- ----------------------------
INSERT INTO `dormitory_payment_records` VALUES (3, 2, 320.00, '2026-04-19', 'โอนเงิน', NULL, 'dormitory/payment-slips/fUvXX3h9uDLxEP6DSRe2qR1sfECm8sg658oVj6Uo.jpg', '892205c431c5109f6b9a3c5c2cd33e14.jpg', NULL, 1, 'paid', '2026-04-19 13:53:46', '2026-04-19 13:54:02');
INSERT INTO `dormitory_payment_records` VALUES (4, 3, 276.00, '2026-04-19', 'โอนเงิน', NULL, 'dormitory/payment-slips/cjqkrm3eANkr6xWmma8h2j8kYf1aBspGQAxNppdR.jpg', '6956d8909ed5dddcef3c1451f0d79923.jpg', NULL, 1, 'paid', '2026-04-19 17:58:31', '2026-04-19 18:03:13');
INSERT INTO `dormitory_payment_records` VALUES (5, 4, 260.00, '2026-04-19', 'โอนเงิน', NULL, 'dormitory/payment-slips/fTW2kWCc2GvtzoW4WJ7VsoEH2KChVYedZhwhehnS.jpg', '0f0453d3f90cd60306849111eebdc699.jpg', NULL, 1, 'paid', '2026-04-19 18:09:25', '2026-04-19 18:09:39');
INSERT INTO `dormitory_payment_records` VALUES (6, 5, 260.00, '2026-04-19', 'หักจากโอที', NULL, NULL, NULL, 'หักจากโอที - รอ Admin ดำเนินการหักเงิน', 1, 'paid', '2026-04-19 18:24:41', '2026-04-19 18:24:59');
INSERT INTO `dormitory_payment_records` VALUES (7, 6, 406.00, '2026-04-19', 'โอนเงิน', NULL, 'dormitory/payment-slips/2ezwypKFThrtbMFEyAjambSFhkYjC1PnmndPlzHe.jpg', '6956d8909ed5dddcef3c1451f0d79923.jpg', NULL, 1, 'paid', '2026-04-19 18:31:17', '2026-04-19 18:31:55');
INSERT INTO `dormitory_payment_records` VALUES (8, 7, 300.00, '2026-04-20', 'โอนเงิน', NULL, 'dormitory/payment-slips/c1lrA6X0D3qsuMzfFOTPtkl9uG1Sg5BNGy0bB0S6.jpg', 'pa.jpg', NULL, 1, 'paid', '2026-04-20 08:51:42', '2026-04-20 10:07:59');
INSERT INTO `dormitory_payment_records` VALUES (10, 8, 603.00, '2026-04-21', 'โอนเงิน', NULL, 'dormitory/payment-slips/PI24pWssdD7ZcHQIpRyyvZYf4ksJVrrZPVBzy3m5.jpg', '288813.jpg', NULL, 9, 'paid', '2026-04-21 16:34:43', '2026-04-21 16:35:10');

-- ----------------------------
-- Table structure for dormitory_residents
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_residents`;
CREATE TABLE `dormitory_residents`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `personel_id` bigint UNSIGNED NULL DEFAULT NULL,
  `employee_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `electricity_allowance_units` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `allowance_effective_from` date NULL DEFAULT NULL,
  `allowance_effective_to` date NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dormitory_residents_personel_id_cid_index`(`personel_id`, `cid`) USING BTREE,
  INDEX `dormitory_residents_employee_id_index`(`employee_id`(250)) USING BTREE,
  INDEX `dormitory_residents_cid_index`(`cid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_residents
-- ----------------------------
INSERT INTO `dormitory_residents` VALUES (1, 1, NULL, '1480800122181', 'นาย จักรพงศ์ ทิพยศรี', NULL, NULL, 30.00, '2026-01-01', NULL, 'active', '2026-04-18 20:10:01', '2026-04-22 09:33:20');
INSERT INTO `dormitory_residents` VALUES (2, 19, NULL, '1480800044627', 'นางสาว จินตหรา นิมิตร', NULL, NULL, 80.00, '2026-01-01', NULL, 'active', '2026-04-18 20:11:42', '2026-04-22 09:33:33');
INSERT INTO `dormitory_residents` VALUES (3, 10, NULL, '1301502002332', 'นาย จิรายุส ครุฑใจกล้า', NULL, NULL, 80.00, '2026-01-01', NULL, 'active', '2026-04-18 20:15:22', '2026-04-22 09:32:50');
INSERT INTO `dormitory_residents` VALUES (4, NULL, NULL, '1100702810123', 'นางสาวภณิพิมพ์  ฟองพิสุทธิกุล', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:11:28', '2026-04-20 16:11:28');
INSERT INTO `dormitory_residents` VALUES (5, NULL, NULL, '1103702540358', 'นางสาวอิงลดา  กิจพิมล', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:12:01', '2026-04-20 16:12:01');
INSERT INTO `dormitory_residents` VALUES (6, NULL, NULL, '1479900342181', 'นางสาวมาลิน  บุพศิริ', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:12:25', '2026-04-20 16:12:25');
INSERT INTO `dormitory_residents` VALUES (7, NULL, NULL, '1103702648442', 'นางสาววลีรัตญา  นิลคง', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:12:48', '2026-04-20 16:12:48');
INSERT INTO `dormitory_residents` VALUES (8, NULL, NULL, '3480400075416', 'นางรังสิมา สิถิระบุตร', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:13:30', '2026-04-20 16:13:30');
INSERT INTO `dormitory_residents` VALUES (9, NULL, NULL, '3110400242277', 'นางสาวณิชกช อาตวงศ์', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:14:09', '2026-04-20 16:14:09');
INSERT INTO `dormitory_residents` VALUES (10, NULL, NULL, '3480400147069', 'นางสาวสุจิตรา  ขออาศัย', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:14:32', '2026-04-20 16:14:32');
INSERT INTO `dormitory_residents` VALUES (11, 9, NULL, '1470100279273', 'นาย มงคล โพธิ์นะ', NULL, NULL, 30.00, '2026-01-01', NULL, 'active', '2026-04-20 16:14:41', '2026-04-22 09:32:10');
INSERT INTO `dormitory_residents` VALUES (12, NULL, NULL, '1430900202241', 'นางสาวมาฆศิริ  ศรีนาทม', NULL, NULL, 80.00, '2026-04-01', NULL, 'active', '2026-04-20 16:15:27', '2026-04-22 09:24:25');
INSERT INTO `dormitory_residents` VALUES (13, NULL, NULL, '1419902085479', 'นายโชคอนันต์  ภูมิประสาท', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:15:57', '2026-04-20 16:15:57');
INSERT INTO `dormitory_residents` VALUES (14, NULL, NULL, '1479300012279', 'นางสาวนลินี ทนุพร', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:16:16', '2026-04-20 16:16:16');
INSERT INTO `dormitory_residents` VALUES (15, NULL, NULL, '1480800137781', 'นายเอกสิทธิ์  เสนเพ็ง', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:16:35', '2026-04-20 16:16:35');
INSERT INTO `dormitory_residents` VALUES (16, NULL, NULL, '1480400061711', 'นางสาววลัยภรณ์  จองไว', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:16:56', '2026-04-20 16:16:56');
INSERT INTO `dormitory_residents` VALUES (17, NULL, NULL, '3480200024796', 'นางพัชราภรณ์  ศรีเพชร', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:17:29', '2026-04-20 16:17:29');
INSERT INTO `dormitory_residents` VALUES (18, NULL, NULL, '3480800060785', 'นางจิณณ์ภัคธนา   เนตรวงค์', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:18:02', '2026-04-20 16:18:02');
INSERT INTO `dormitory_residents` VALUES (19, NULL, NULL, '3480400008859', 'นางสาวอภิญญา    อุปเสน', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:18:22', '2026-04-20 16:18:22');
INSERT INTO `dormitory_residents` VALUES (20, NULL, NULL, '1480400045774', 'นางสาวเพียงพิศ  สมรฤทธิ์', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:18:43', '2026-04-20 16:18:43');
INSERT INTO `dormitory_residents` VALUES (21, NULL, NULL, '1489900121923', 'นางสาวสุทธิดา    สีหา', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:19:01', '2026-04-20 16:19:01');
INSERT INTO `dormitory_residents` VALUES (22, NULL, NULL, '1480500116771', 'นางสาวกมลชนก  อุ่นชัย', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:19:19', '2026-04-20 16:19:19');
INSERT INTO `dormitory_residents` VALUES (23, NULL, NULL, '1480701245985', 'นางสาวมัยญรัตน์  อุดมทนานุกูล', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:19:38', '2026-04-20 16:19:38');
INSERT INTO `dormitory_residents` VALUES (24, NULL, NULL, '1480400124127', 'นางสาวสาวิตรี  นาโสก', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:19:58', '2026-04-20 16:19:58');
INSERT INTO `dormitory_residents` VALUES (25, NULL, NULL, '1407500024350', 'นางสาวพรนัชชา  ชาวยศ', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:20:24', '2026-04-20 16:20:24');
INSERT INTO `dormitory_residents` VALUES (26, NULL, NULL, '3480800396724', 'นางสันสนี   ใหม่วงค์', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:21:00', '2026-04-20 16:21:00');
INSERT INTO `dormitory_residents` VALUES (27, NULL, NULL, '5480300007814', 'นางสาวนุชจรี  บุตรบุรี', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:21:20', '2026-04-20 16:21:20');
INSERT INTO `dormitory_residents` VALUES (28, NULL, NULL, '3480500265268', 'นางสาวบุษกร   สำเภา', NULL, NULL, 100.00, '2026-04-01', NULL, 'active', '2026-04-20 16:21:46', '2026-04-22 09:24:25');
INSERT INTO `dormitory_residents` VALUES (29, NULL, NULL, '1480400086233', 'นางสาวอินธุอร   ศรีนันทา', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:22:08', '2026-04-20 16:22:08');
INSERT INTO `dormitory_residents` VALUES (30, NULL, NULL, '1480700110563', 'นางสาวลดาวัลย์  ไตยราช', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:22:27', '2026-04-20 16:22:27');
INSERT INTO `dormitory_residents` VALUES (31, NULL, NULL, '1470800221634', 'นางสาววิสุดา   บาลจบ', NULL, NULL, 30.00, '2026-04-01', NULL, 'active', '2026-04-20 16:22:47', '2026-04-22 09:24:25');
INSERT INTO `dormitory_residents` VALUES (32, NULL, NULL, '1480800159238', 'นางสาวพรธิตา  ศิริวงศ์', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:23:05', '2026-04-20 16:23:05');
INSERT INTO `dormitory_residents` VALUES (33, NULL, NULL, '1480500097351', 'นางสาวเพ็ญพร   เอกจักรแก้ว', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:23:23', '2026-04-20 16:23:23');
INSERT INTO `dormitory_residents` VALUES (34, NULL, NULL, '1479900472513', 'นายกิตติคุณ  มัยวงศ์', NULL, NULL, 80.00, '2026-01-01', NULL, 'active', '2026-04-20 16:24:44', '2026-04-22 09:31:32');
INSERT INTO `dormitory_residents` VALUES (35, NULL, NULL, '1481100027500', 'นางสาวรมิดา  วงษา', NULL, NULL, 0.00, NULL, NULL, 'active', '2026-04-20 16:25:09', '2026-04-20 16:25:09');

-- ----------------------------
-- Table structure for dormitory_room_assignments
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_room_assignments`;
CREATE TABLE `dormitory_room_assignments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `room_id` bigint UNSIGNED NOT NULL,
  `resident_id` bigint UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NULL DEFAULT NULL,
  `is_solo` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','ended','transferred') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dormitory_room_assignments_room_id_status_index`(`room_id`, `status`) USING BTREE,
  INDEX `dormitory_room_assignments_resident_id_status_index`(`resident_id`, `status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of dormitory_room_assignments
-- ----------------------------
INSERT INTO `dormitory_room_assignments` VALUES (1, 2, 1, '2026-04-18', NULL, 0, 'active', '2026-04-18 20:10:19', '2026-04-18 20:10:19');
INSERT INTO `dormitory_room_assignments` VALUES (2, 3, 2, '2026-04-18', NULL, 0, 'active', '2026-04-18 20:12:48', '2026-04-18 20:12:48');
INSERT INTO `dormitory_room_assignments` VALUES (3, 2, 3, '2026-04-18', NULL, 0, 'active', '2026-04-18 20:15:44', '2026-04-18 20:15:44');
INSERT INTO `dormitory_room_assignments` VALUES (4, 4, 11, '2026-04-01', NULL, 0, 'active', '2026-04-21 15:02:49', '2026-04-21 15:02:49');
INSERT INTO `dormitory_room_assignments` VALUES (5, 4, 3, '2026-04-01', NULL, 0, 'active', '2026-04-21 15:02:59', '2026-04-21 15:02:59');
INSERT INTO `dormitory_room_assignments` VALUES (6, 5, 28, '2026-04-21', NULL, 1, 'active', '2026-04-21 16:14:25', '2026-04-21 16:14:25');
INSERT INTO `dormitory_room_assignments` VALUES (7, 6, 12, '2026-04-21', NULL, 0, 'active', '2026-04-21 16:17:06', '2026-04-21 16:17:06');
INSERT INTO `dormitory_room_assignments` VALUES (8, 7, 31, '2026-04-21', NULL, 0, 'active', '2026-04-21 16:18:32', '2026-04-21 16:18:32');

-- ----------------------------
-- Table structure for dormitory_rooms
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_rooms`;
CREATE TABLE `dormitory_rooms`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `dormitory_id` bigint UNSIGNED NOT NULL,
  `room_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `max_occupants` int UNSIGNED NOT NULL DEFAULT 1,
  `status` enum('vacant','occupied','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'vacant',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dormitory_rooms_dormitory_id_room_number_unique`(`dormitory_id`, `room_number`) USING BTREE,
  INDEX `dormitory_rooms_dormitory_id_status_index`(`dormitory_id`, `status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dormitory_rooms
-- ----------------------------
INSERT INTO `dormitory_rooms` VALUES (5, 5, '3', NULL, 1, 'occupied', '2026-04-21 16:13:50', '2026-04-21 16:14:25');
INSERT INTO `dormitory_rooms` VALUES (4, 2, '22', NULL, 2, 'occupied', '2026-04-21 15:02:13', '2026-04-21 15:02:13');
INSERT INTO `dormitory_rooms` VALUES (6, 6, '4', NULL, 2, 'occupied', '2026-04-21 16:16:42', '2026-04-21 16:17:06');
INSERT INTO `dormitory_rooms` VALUES (7, 7, '5', NULL, 2, 'occupied', '2026-04-21 16:18:20', '2026-04-21 16:18:32');
INSERT INTO `dormitory_rooms` VALUES (8, 4, '10', NULL, 2, 'vacant', '2026-04-21 16:19:38', '2026-04-21 16:19:38');
INSERT INTO `dormitory_rooms` VALUES (9, 4, '11', NULL, 1, 'vacant', '2026-04-21 16:20:19', '2026-04-21 16:20:19');
INSERT INTO `dormitory_rooms` VALUES (10, 4, '12', NULL, 1, 'vacant', '2026-04-21 16:20:37', '2026-04-21 16:20:37');
INSERT INTO `dormitory_rooms` VALUES (11, 4, '13', NULL, 2, 'vacant', '2026-04-21 16:20:56', '2026-04-21 16:20:56');
INSERT INTO `dormitory_rooms` VALUES (12, 4, '14', NULL, 2, 'vacant', '2026-04-21 16:21:07', '2026-04-21 16:21:07');
INSERT INTO `dormitory_rooms` VALUES (13, 8, '15', NULL, 1, 'vacant', '2026-04-21 16:21:55', '2026-04-21 16:21:55');
INSERT INTO `dormitory_rooms` VALUES (14, 9, '16', NULL, 2, 'vacant', '2026-04-21 16:22:10', '2026-04-21 16:22:10');
INSERT INTO `dormitory_rooms` VALUES (15, 10, '17', NULL, 2, 'vacant', '2026-04-21 16:22:26', '2026-04-21 16:22:26');
INSERT INTO `dormitory_rooms` VALUES (16, 11, '18', NULL, 2, 'vacant', '2026-04-21 16:22:50', '2026-04-21 16:22:50');
INSERT INTO `dormitory_rooms` VALUES (17, 2, '19', NULL, 1, 'vacant', '2026-04-21 16:23:22', '2026-04-21 16:23:22');
INSERT INTO `dormitory_rooms` VALUES (18, 2, '20', NULL, 1, 'vacant', '2026-04-21 16:23:36', '2026-04-21 16:23:36');
INSERT INTO `dormitory_rooms` VALUES (19, 2, '21', NULL, 2, 'vacant', '2026-04-21 16:23:51', '2026-04-21 16:23:51');
INSERT INTO `dormitory_rooms` VALUES (20, 2, '23', NULL, 2, 'vacant', '2026-04-21 16:24:57', '2026-04-21 16:24:57');
INSERT INTO `dormitory_rooms` VALUES (21, 12, '24', NULL, 2, 'vacant', '2026-04-21 16:25:22', '2026-04-21 16:25:56');
INSERT INTO `dormitory_rooms` VALUES (22, 13, '25', NULL, 1, 'vacant', '2026-04-21 16:26:15', '2026-04-21 16:26:15');
INSERT INTO `dormitory_rooms` VALUES (23, 14, '26', NULL, 1, 'vacant', '2026-04-21 16:26:49', '2026-04-21 16:26:49');
INSERT INTO `dormitory_rooms` VALUES (24, 15, '27', NULL, 1, 'vacant', '2026-04-21 16:27:01', '2026-04-21 16:27:01');
INSERT INTO `dormitory_rooms` VALUES (25, 16, '28', NULL, 1, 'vacant', '2026-04-21 16:27:22', '2026-04-21 16:27:22');
INSERT INTO `dormitory_rooms` VALUES (26, 17, '30', NULL, 2, 'vacant', '2026-04-21 16:27:38', '2026-04-21 16:27:38');
INSERT INTO `dormitory_rooms` VALUES (27, 3, '101', NULL, 2, 'vacant', '2026-04-21 16:27:52', '2026-04-21 16:27:52');
INSERT INTO `dormitory_rooms` VALUES (28, 3, '102', NULL, 2, 'vacant', '2026-04-21 16:28:05', '2026-04-21 16:28:05');
INSERT INTO `dormitory_rooms` VALUES (29, 3, '103', NULL, 2, 'vacant', '2026-04-21 16:28:23', '2026-04-21 16:28:23');
INSERT INTO `dormitory_rooms` VALUES (30, 3, '104', NULL, 1, 'vacant', '2026-04-21 16:28:35', '2026-04-21 16:28:35');
INSERT INTO `dormitory_rooms` VALUES (31, 3, '201', NULL, 2, 'vacant', '2026-04-21 16:40:31', '2026-04-21 16:40:31');
INSERT INTO `dormitory_rooms` VALUES (32, 3, '202', NULL, 2, 'vacant', '2026-04-21 16:40:45', '2026-04-21 16:40:45');
INSERT INTO `dormitory_rooms` VALUES (33, 3, '203', NULL, 2, 'vacant', '2026-04-21 16:41:01', '2026-04-21 16:41:01');
INSERT INTO `dormitory_rooms` VALUES (34, 3, '204', NULL, 2, 'vacant', '2026-04-21 16:41:14', '2026-04-21 16:41:14');
INSERT INTO `dormitory_rooms` VALUES (35, 3, '301', NULL, 2, 'vacant', '2026-04-21 16:41:29', '2026-04-21 16:41:29');
INSERT INTO `dormitory_rooms` VALUES (36, 3, '302', NULL, 2, 'vacant', '2026-04-21 16:41:43', '2026-04-21 16:41:43');
INSERT INTO `dormitory_rooms` VALUES (37, 3, '303', NULL, 1, 'vacant', '2026-04-21 16:41:59', '2026-04-21 16:41:59');
INSERT INTO `dormitory_rooms` VALUES (38, 3, '304', NULL, 2, 'vacant', '2026-04-21 16:42:13', '2026-04-21 16:42:13');

-- ----------------------------
-- Table structure for meeting_rooms
-- ----------------------------
DROP TABLE IF EXISTS `meeting_rooms`;
CREATE TABLE `meeting_rooms`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อห้องประชุม',
  `capacity` int NOT NULL DEFAULT 0 COMMENT 'ความจุ (คน)',
  `equipment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'อุปกรณ์ที่มีในห้อง',
  `color_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#0ea5e9' COMMENT 'สีประจำห้องในปฏิทิน (Hex Code)',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'สถานะ 1=เปิดใช้งาน, 0=ปิดปรับปรุง',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of meeting_rooms
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2026_03_12_103544_create_bank_accounts_table', 1);
INSERT INTO `migrations` VALUES (2, '2026_04_18_000001_create_dormitory_system_tables', 2);
INSERT INTO `migrations` VALUES (3, '2026_04_18_000003_add_slip_fields_to_dormitory_payment_records_table', 3);
INSERT INTO `migrations` VALUES (4, '2026_04_18_000002_create_dormitory_structure_tables', 3);
INSERT INTO `migrations` VALUES (5, '2026_04_18_000003_add_dormitory_billing_settings_and_bill_calculation_fields', 3);
INSERT INTO `migrations` VALUES (6, '2026_04_19_000001_add_dormitory_permissions', 4);
INSERT INTO `migrations` VALUES (7, '2026_04_22_000001_move_dormitory_electricity_allowance_to_residents', 5);
INSERT INTO `migrations` VALUES (8, '2026_04_22_000002_drop_dormitory_room_allowances_table', 6);

-- ----------------------------
-- Table structure for permission_personel
-- ----------------------------
DROP TABLE IF EXISTS `permission_personel`;
CREATE TABLE `permission_personel`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `personel_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `personel_id`(`personel_id` ASC) USING BTREE,
  INDEX `permission_id`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `permission_personel_ibfk_1` FOREIGN KEY (`personel_id`) REFERENCES `personel` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `permission_personel_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission_personel
-- ----------------------------
INSERT INTO `permission_personel` VALUES (6, 1, 1, NULL, NULL);
INSERT INTO `permission_personel` VALUES (7, 1, 2, NULL, NULL);
INSERT INTO `permission_personel` VALUES (8, 1, 3, NULL, NULL);
INSERT INTO `permission_personel` VALUES (9, 1, 4, NULL, NULL);
INSERT INTO `permission_personel` VALUES (10, 1, 5, NULL, NULL);
INSERT INTO `permission_personel` VALUES (11, 6, 1, NULL, NULL);
INSERT INTO `permission_personel` VALUES (12, 6, 2, NULL, NULL);
INSERT INTO `permission_personel` VALUES (13, 6, 3, NULL, NULL);
INSERT INTO `permission_personel` VALUES (14, 6, 4, NULL, NULL);
INSERT INTO `permission_personel` VALUES (15, 6, 5, NULL, NULL);
INSERT INTO `permission_personel` VALUES (16, 13, 8, NULL, NULL);
INSERT INTO `permission_personel` VALUES (17, 19, 7, NULL, NULL);
INSERT INTO `permission_personel` VALUES (18, 9, 3, NULL, NULL);
INSERT INTO `permission_personel` VALUES (19, 9, 6, NULL, NULL);
INSERT INTO `permission_personel` VALUES (20, 9, 7, NULL, NULL);
INSERT INTO `permission_personel` VALUES (21, 10, 8, NULL, NULL);

-- ----------------------------
-- Table structure for permission_requests
-- ----------------------------
DROP TABLE IF EXISTS `permission_requests`;
CREATE TABLE `permission_requests`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL COMMENT 'ไอดีพนักงานที่ขอ',
  `permission_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อสิทธิ์ที่ขอ เช่น access_kpi',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เหตุผลที่ขอ',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT 'สถานะคำร้อง',
  `admin_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT 'แอดมินที่ทำรายการ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `req_user_id_foreign`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission_requests
-- ----------------------------
INSERT INTO `permission_requests` VALUES (1, 2, 'undefined', 'ทดสอบ', 'rejected', 1, '2026-03-02 15:29:28', '2026-03-02 15:39:46');
INSERT INTO `permission_requests` VALUES (2, 2, 'access_kpi', 'ทดสอบ', 'rejected', 1, '2026-03-02 15:39:24', '2026-03-02 15:43:41');
INSERT INTO `permission_requests` VALUES (3, 2, 'access_kpi', 'ทดสอบ', 'approved', 1, '2026-03-02 15:43:51', '2026-03-02 15:43:56');
INSERT INTO `permission_requests` VALUES (4, 2, 'access_cqi', 'ทดสอบ', 'rejected', 1, '2026-03-02 16:39:36', '2026-03-02 16:40:30');
INSERT INTO `permission_requests` VALUES (5, 2, 'access_cqi', 'ทดสอบ', 'rejected', 1, '2026-03-02 16:40:41', '2026-03-02 16:47:57');
INSERT INTO `permission_requests` VALUES (6, 2, 'access_cqi', 'ทดสอบ', 'rejected', 1, '2026-03-02 16:48:06', '2026-03-02 16:51:54');
INSERT INTO `permission_requests` VALUES (7, 2, 'access_cqi', 'ทดสอบ', 'rejected', 1, '2026-03-02 16:52:04', '2026-03-05 09:35:49');
INSERT INTO `permission_requests` VALUES (8, 1, 'manage_softwares', 'เป็น IT', 'approved', 1, '2026-03-05 13:16:08', '2026-03-05 13:16:38');

-- ----------------------------
-- Table structure for permission_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  INDEX `permission_id`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `permission_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `permission_role_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission_role
-- ----------------------------
INSERT INTO `permission_role` VALUES (1, 1, 1);
INSERT INTO `permission_role` VALUES (2, 1, 2);
INSERT INTO `permission_role` VALUES (3, 1, 3);
INSERT INTO `permission_role` VALUES (4, 1, 4);
INSERT INTO `permission_role` VALUES (5, 1, 5);
INSERT INTO `permission_role` VALUES (7, 4, 4);
INSERT INTO `permission_role` VALUES (8, 2, 1);
INSERT INTO `permission_role` VALUES (9, 2, 2);
INSERT INTO `permission_role` VALUES (10, 2, 4);
INSERT INTO `permission_role` VALUES (11, 3, 1);
INSERT INTO `permission_role` VALUES (12, 3, 2);
INSERT INTO `permission_role` VALUES (13, 3, 4);
INSERT INTO `permission_role` VALUES (14, 1, 6);
INSERT INTO `permission_role` VALUES (15, 4, 6);
INSERT INTO `permission_role` VALUES (16, 3, 6);
INSERT INTO `permission_role` VALUES (17, 2, 6);
INSERT INTO `permission_role` VALUES (18, 1, 7);

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'access_kpi', 'เข้าถึงระบบ KPI', '2026-02-28 09:45:50', '2026-02-28 09:45:50');
INSERT INTO `permissions` VALUES (2, 'access_cqi', 'เข้าถึงระบบ CQI / KM', '2026-02-28 09:45:50', '2026-02-28 09:45:50');
INSERT INTO `permissions` VALUES (3, 'access_settings', 'เข้าถึงเมนูตั้งค่าระบบ (Settings Hub)', '2026-03-02 14:54:32', '2026-03-02 14:54:32');
INSERT INTO `permissions` VALUES (4, 'approve_booking', 'เข้าถึงการอนุมัติจองห้องประชุม', '2026-03-03 07:43:31', '2026-03-03 07:43:33');
INSERT INTO `permissions` VALUES (5, 'manage_softwares', 'เข้าถึงทะเบียนซอฟต์แวร์', '2026-03-05 13:15:37', '2026-03-05 13:15:40');
INSERT INTO `permissions` VALUES (6, 'access_info', 'เข้าถึงระบบสารบรรณ', '2026-03-08 18:59:52', '2026-03-08 18:59:55');
INSERT INTO `permissions` VALUES (7, 'dormitory_admin', 'ผู้ดูแลระบบบ้านพัก', '2026-04-19 21:33:54', '2026-04-19 21:33:54');
INSERT INTO `permissions` VALUES (8, 'dormitory_technician', 'ช่าง / เจ้าหน้าที่ระบบบ้านพัก', '2026-04-19 21:33:54', '2026-04-19 21:33:54');

-- ----------------------------
-- Table structure for personel
-- ----------------------------
DROP TABLE IF EXISTS `personel`;
CREATE TABLE `personel`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `prefix` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `thai_first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `thai_last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `birthdate` date NULL DEFAULT NULL,
  `hire_date` date NULL DEFAULT NULL,
  `department_id` bigint UNSIGNED NULL DEFAULT NULL,
  `position_id` bigint UNSIGNED NULL DEFAULT NULL,
  `operational_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role_id` bigint UNSIGNED NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending',
  `employment_status` enum('ทำงานอยู่','ลาออก','โยกย้าย') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ทำงานอยู่',
  `salary` decimal(10, 2) NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `emergency_contact_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `emergency_contact_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `line_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `line_display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `line_picture_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `line_profile` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `position_id`(`position_id` ASC) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `personel_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `personel_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `personel_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personel
-- ----------------------------
INSERT INTO `personel` VALUES (1, NULL, '1480800122181', 'นาย', 'จักรพงศ์', 'ทิพยศรี', 'จักรพงศ์', 'ทิพยศรี', 'boss1994@hospital.com', NULL, NULL, NULL, 13, 8, NULL, 1, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'boss1994', '$2y$12$ASD8ITjGc2vNjPrd44GxGuXyLt0E8ZnYQf/uCM0NLX6.yCAbAC832', 'U3502051a6225e962a5847a631c94dcfa', 'Boss-11106', 'https://profile.line-scdn.net/0hwXkRJjRTKHdGKzoL7bhWCDZ7Kx1lWnFlb04wE3opJhdzT2YkOh00FXp-fkR5TmYlP0RmGCYsdxRKOF8RWH3UQ0EbdUZ6E2YhY0RvmQ', '{\"userId\":\"U3502051a6225e962a5847a631c94dcfa\",\"displayName\":\"Boss-11106\",\"statusMessage\":\"0986218063\",\"pictureUrl\":\"https:\\/\\/profile.line-scdn.net\\/0hwXkRJjRTKHdGKzoL7bhWCDZ7Kx1lWnFlb04wE3opJhdzT2YkOh00FXp-fkR5TmYlP0RmGCYsdxRKOF8RWH3UQ0EbdUZ6E2YhY0RvmQ\"}', '22jqkq4SZA4b648okBdxKPrjuYCV8QXpKzARbtAQ2IDIDLzU7A2TvieQLeMW', '2026-02-27 05:18:14', '2026-04-17 11:12:19', NULL);
INSERT INTO `personel` VALUES (6, NULL, '1480400109152', 'นาย', NULL, NULL, 'ธนากร', 'พรหมจอม', NULL, NULL, NULL, NULL, 13, 8, NULL, 1, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'frong2541', '$2y$12$DVLyF3dKDLohQTFUnWVfaeoYF2LvNSk7jSjwlIIOYnRkOJgB0/P0i', 'Ue99dadabaa757792f53164ed24ceb124', 'Thanakorn🫡🫡', 'https://profile.line-scdn.net/0hEbzxYXFCGk1XAQRl-5ZkcydRGSd0cENfcmBQLjFRFihjMgkYcm5TfzAJEHRqZFwffG4BKDUETSl1OS1AASUqKSdcLQQvchVbGTsJdiQGGAARZFwYFSU9VmQGPgoDYSsTPzgBWT9dMittU1pNLSQ0fzV_HTs4NRpZElZ2G1IzdM44A20YemZdLWoBQn7q', '{\"userId\":\"Ue99dadabaa757792f53164ed24ceb124\",\"displayName\":\"Thanakorn\\ud83e\\udee1\\ud83e\\udee1\",\"pictureUrl\":\"https:\\/\\/profile.line-scdn.net\\/0hEbzxYXFCGk1XAQRl-5ZkcydRGSd0cENfcmBQLjFRFihjMgkYcm5TfzAJEHRqZFwffG4BKDUETSl1OS1AASUqKSdcLQQvchVbGTsJdiQGGAARZFwYFSU9VmQGPgoDYSsTPzgBWT9dMittU1pNLSQ0fzV_HTs4NRpZElZ2G1IzdM44A20YemZdLWoBQn7q\"}', 'RsgVgJKsfcjwNxZ86oM2QgHLY07gfmP1P4pBgiFCn5L02hLke5TEsxPpduqG', '2026-03-06 09:32:23', '2026-04-17 10:45:32', NULL);
INSERT INTO `personel` VALUES (7, NULL, '1480501295156', 'นางสาว', NULL, NULL, 'พรนภา', 'พลายงาม', NULL, NULL, NULL, NULL, 1, 34, NULL, 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Pornnapha', '$2y$12$Zfp89uwz.xA67xIZY.v/ju0AmotOEXzzMKPZ4bkXZ3aEYbAKwewD.', 'Ua6d1cc6333ad5b6b63056a5510abb770', 'pornnapha', 'https://profile.line-scdn.net/0habqi2up2Pk1cECBV3RlAcyxAPSd_YWdfJCUiIm5EZS5gKH4cJHJyez4ZYXVmc39JIyJzfm0SMnR-VDxILH4kewt7MAs0Qxp7JB0mYgFnCX4pfSxEMDJ4Xz8XOxgUUnEdGS8Kcm9yYQBiYzFhBCYBdB1rJRk3QjthLEdSG1kiUM4zEkkYcXd5LWEQZn7h', '{\"userId\":\"Ua6d1cc6333ad5b6b63056a5510abb770\",\"displayName\":\"pornnapha\",\"statusMessage\":\"(d)on\'t look down on yourself.\",\"pictureUrl\":\"https:\\/\\/profile.line-scdn.net\\/0habqi2up2Pk1cECBV3RlAcyxAPSd_YWdfJCUiIm5EZS5gKH4cJHJyez4ZYXVmc39JIyJzfm0SMnR-VDxILH4kewt7MAs0Qxp7JB0mYgFnCX4pfSxEMDJ4Xz8XOxgUUnEdGS8Kcm9yYQBiYzFhBCYBdB1rJRk3QjthLEdSG1kiUM4zEkkYcXd5LWEQZn7h\"}', 'vOlJQhJdds8L07A0X3zJfvLzyCeItCi9vuDzCGOC225BlfWObNSAoA45LT9A', '2026-03-06 11:12:25', '2026-04-17 10:51:40', NULL);
INSERT INTO `personel` VALUES (8, NULL, '1431100044579', 'นางสาว', NULL, NULL, 'สุดารัตน์', 'แพงโท', NULL, NULL, NULL, NULL, 1, 32, NULL, 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Sudarat', '$2y$12$hcAtHxKd64QqqAXkGxWlvOTTt.1988Zle9JLfSTiLk8ORtZoka2/e', NULL, NULL, NULL, NULL, NULL, '2026-03-06 11:14:48', '2026-03-08 20:20:21', NULL);
INSERT INTO `personel` VALUES (9, NULL, '1470100279273', 'นาย', 'Mongkol', 'Phona', 'มงคล', 'โพธิ์นะ', NULL, NULL, NULL, NULL, 1, 9, NULL, 1, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'mongkol1112', '$2y$12$VPDtc6hn8oqPSq7E/mN//OqHmqIyxl1c3AOoRz8qXkOxG91bKlXW.', 'U9e285c7442ecf1788aae4921d42a1f5a', 'MONG3887🤍托托🐷', 'https://profile.line-scdn.net/0hFKq_3iCOGWRcJgbduVVnWix2Gg5_V0B2c0ZQC2AuRAFpQgk7eURXV25xRFE2RF8xeUQCV21xEFR-cTp3AB4eRx0iBihgFAFkOEJVRhZZDyk7YVlBIAMVcBojFQAeEFtrODMCdyxkG1E4bCN3JwIuYSkuHzYaEh5EBnF1MlkUd-czJG4xcUFeBGEmQVfh', '{\"userId\":\"U9e285c7442ecf1788aae4921d42a1f5a\",\"displayName\":\"MONG3887\\ud83e\\udd0d\\u6258\\u6258\\ud83d\\udc37\",\"statusMessage\":\"\\ud83e\\udd0d\\u0e44\\u0e21\\u0e48\\u0e40\\u0e04\\u0e22\\u0e01\\u0e25\\u0e31\\u0e27\\u0e01\\u0e32\\u0e23\\u0e40\\u0e23\\u0e34\\u0e48\\u0e21\\u0e15\\u0e49\\u0e19\\u0e43\\u0e2b\\u0e21\\u0e48\\ud83e\\udd0d\",\"pictureUrl\":\"https:\\/\\/profile.line-scdn.net\\/0hFKq_3iCOGWRcJgbduVVnWix2Gg5_V0B2c0ZQC2AuRAFpQgk7eURXV25xRFE2RF8xeUQCV21xEFR-cTp3AB4eRx0iBihgFAFkOEJVRhZZDyk7YVlBIAMVcBojFQAeEFtrODMCdyxkG1E4bCN3JwIuYSkuHzYaEh5EBnF1MlkUd-czJG4xcUFeBGEmQVfh\"}', NULL, '2026-03-06 13:06:45', '2026-04-20 16:27:16', NULL);
INSERT INTO `personel` VALUES (10, NULL, '1301502002332', 'นาย', NULL, NULL, 'จิรายุส', 'ครุฑใจกล้า', NULL, NULL, NULL, NULL, 1, 41, 'ปฏิบัติการ', 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Jirayutkjk', '$2y$12$fxfIYQLQP2kN53vcUcC7ROIq2cy0PFkHtnKL8WcRCYso16e1K2d5i', NULL, NULL, NULL, NULL, NULL, '2026-03-06 13:12:53', '2026-03-11 17:10:42', NULL);
INSERT INTO `personel` VALUES (13, NULL, '1480400117481', 'นางสาว', NULL, NULL, 'ณัฐกานต์', 'เวียงสิมา', NULL, NULL, NULL, NULL, 14, 24, NULL, 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Natthakan26', '$2y$12$8xlIu/fVAB5/kRBSfCECs.q.XAZvklOKV5IUXS2AisNqeyHilJqhm', NULL, NULL, NULL, NULL, NULL, '2026-03-11 19:53:52', '2026-03-11 19:57:09', NULL);
INSERT INTO `personel` VALUES (18, NULL, '3439900079192', 'นางสาว', NULL, NULL, 'รัชดา', 'บุตรวงค์', NULL, NULL, NULL, NULL, 1, 32, 'ชำนาญงาน', 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Aoy079192', '$2y$12$jZ1IIG19evlLTsuBAe4Q7eFTiNGMTOEsiZ942/gBZqK2xYtv1oeiG', NULL, NULL, NULL, NULL, 'XQ4CNBbUvfJCYe4cGxMHMacAdJo6X7MUO3i5mPEO6TRDKZzIeqLV6U6HB4v9', '2026-03-12 16:28:17', '2026-03-12 16:34:42', NULL);
INSERT INTO `personel` VALUES (19, NULL, '1480800044627', 'นางสาว', NULL, NULL, 'จินตหรา', 'นิมิตร', NULL, NULL, NULL, NULL, 33, 31, NULL, 4, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, '1480800044627', '$2y$12$lD1.IO/EYm7LDjNjNhAyNO9Jq32fIXJPjX.i3kHJKvpCi81v.ep2q', NULL, NULL, NULL, NULL, NULL, '2026-03-12 16:29:09', '2026-03-12 16:34:09', NULL);
INSERT INTO `personel` VALUES (20, NULL, '1250100358515', 'นางสาว', NULL, NULL, 'กนิษฐา', 'วงษ์หอย', NULL, NULL, NULL, NULL, 13, 8, NULL, 1, 'active', 'ทำงานอยู่', NULL, NULL, NULL, NULL, NULL, NULL, 'Kanitta1402', '$2y$12$tCkJFa3Lm56DzPqEEPB6ZeuO9alihntgyzNtXLF4cuFWUqRgRketC', NULL, NULL, NULL, NULL, 'MCAT4MQzMSeupeCZVHE2tIU1BvrtUlFhNTwN6L3EN7fJaRT8RPl3gDBzHTwg', '2026-03-19 16:18:59', '2026-03-19 16:19:11', NULL);

-- ----------------------------
-- Table structure for positions
-- ----------------------------
DROP TABLE IF EXISTS `positions`;
CREATE TABLE `positions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of positions
-- ----------------------------
INSERT INTO `positions` VALUES (1, 'นายแพทย์', NULL, NULL);
INSERT INTO `positions` VALUES (2, 'ทันตแพทย์ปฏิบัติการ', NULL, NULL);
INSERT INTO `positions` VALUES (3, 'เภสัชกร', NULL, NULL);
INSERT INTO `positions` VALUES (4, 'พยาบาลวิชาชีพ', NULL, NULL);
INSERT INTO `positions` VALUES (5, 'นักวิชาการสาธารณสุข', NULL, NULL);
INSERT INTO `positions` VALUES (6, 'นักสาธารณสุข', NULL, NULL);
INSERT INTO `positions` VALUES (7, 'นักเทคนิคการแพทย์', NULL, NULL);
INSERT INTO `positions` VALUES (8, 'นักวิชาการคอมพิวเตอร์', NULL, NULL);
INSERT INTO `positions` VALUES (9, 'นักวิชาการเงินและบัญชี', NULL, NULL);
INSERT INTO `positions` VALUES (10, 'นักรังษีการแพทย์', NULL, NULL);
INSERT INTO `positions` VALUES (11, 'แพทย์แผนไทย', NULL, NULL);
INSERT INTO `positions` VALUES (12, 'นักจิตวิทยา', NULL, NULL);
INSERT INTO `positions` VALUES (13, 'นักกายภาพบำบัด', NULL, NULL);
INSERT INTO `positions` VALUES (14, 'เจ้าพนักงานทันตสาธารณสุข', NULL, NULL);
INSERT INTO `positions` VALUES (15, 'เจ้าพนักงานเภสัชกรรม', NULL, NULL);
INSERT INTO `positions` VALUES (16, 'เจ้าพนักงานวิทยาศาสตร์การแพทย์', NULL, NULL);
INSERT INTO `positions` VALUES (17, 'เจ้าพนักงานเวชกิจฉุกเฉิน', NULL, NULL);
INSERT INTO `positions` VALUES (18, 'เจ้าพนักงานเวชสถิติ', NULL, NULL);
INSERT INTO `positions` VALUES (19, 'เจ้าพนักงานสาธารณสุข', NULL, NULL);
INSERT INTO `positions` VALUES (20, 'นักวิชาการทันตสาธารณสุข', NULL, NULL);
INSERT INTO `positions` VALUES (21, 'ผู้ช่วยแพทย์แผนไทย', NULL, NULL);
INSERT INTO `positions` VALUES (22, 'พนักงานช่วยเหลือคนไข้', NULL, NULL);
INSERT INTO `positions` VALUES (23, 'พนักงานประจำตึก', NULL, NULL);
INSERT INTO `positions` VALUES (24, 'พนักงานบริการ', NULL, NULL);
INSERT INTO `positions` VALUES (25, 'ผู้ช่วยทันตแพทย์', NULL, NULL);
INSERT INTO `positions` VALUES (26, 'พนักงานเกษตรพื้นฐาน', NULL, NULL);
INSERT INTO `positions` VALUES (27, 'พนักงานบัตรรายงานโรค', NULL, NULL);
INSERT INTO `positions` VALUES (28, 'พนักงานประจำห้องยา', NULL, NULL);
INSERT INTO `positions` VALUES (29, 'นักโภชนาการ', NULL, NULL);
INSERT INTO `positions` VALUES (30, 'พนักงานประกอบอาหาร', NULL, NULL);
INSERT INTO `positions` VALUES (31, 'เจ้าพนักงานการเงินและบัญชี', NULL, NULL);
INSERT INTO `positions` VALUES (32, 'เจ้าพนักงานธุรการ', NULL, NULL);
INSERT INTO `positions` VALUES (33, 'นักวิชาการพัสดุ', NULL, NULL);
INSERT INTO `positions` VALUES (34, 'เจ้าพนักงานพัสดุ', NULL, NULL);
INSERT INTO `positions` VALUES (35, 'พนักงานพิมพ์', NULL, NULL);
INSERT INTO `positions` VALUES (36, 'พนักงานพิมพ์ดีด', NULL, NULL);
INSERT INTO `positions` VALUES (37, 'นายช่างเทคนิค', NULL, NULL);
INSERT INTO `positions` VALUES (38, 'ผู้ช่วยช่างทั่วไป', NULL, NULL);
INSERT INTO `positions` VALUES (39, 'พนักงานขับรถยนต์', NULL, NULL);
INSERT INTO `positions` VALUES (40, 'พนักงานทำความสะอาด', NULL, NULL);
INSERT INTO `positions` VALUES (41, 'นักจัดการทั่วไป', NULL, NULL);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'admin', 'ผู้ดูแลระบบ', NULL, NULL);
INSERT INTO `roles` VALUES (2, 'doctor', 'แพทย์', NULL, NULL);
INSERT INTO `roles` VALUES (3, 'nurse', 'พยาบาล', NULL, NULL);
INSERT INTO `roles` VALUES (4, 'staff', 'เจ้าหน้าที่ทั่วไป', NULL, NULL);

-- ----------------------------
-- Table structure for room_bookings
-- ----------------------------
DROP TABLE IF EXISTS `room_bookings`;
CREATE TABLE `room_bookings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `room_id` bigint UNSIGNED NOT NULL COMMENT 'รหัสห้องประชุม',
  `user_id` bigint UNSIGNED NOT NULL COMMENT 'รหัสพนักงานผู้จอง (อ้างอิงตาราง personel)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'หัวข้อการประชุม',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'รายละเอียด/สิ่งที่ต้องการเพิ่มเติม',
  `attendees` int NOT NULL DEFAULT 0,
  `start_datetime` datetime NOT NULL COMMENT 'วัน-เวลาเริ่มการประชุม',
  `end_datetime` datetime NOT NULL COMMENT 'วัน-เวลาสิ้นสุดการประชุม',
  `status` enum('pending','approved','rejected','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT 'สถานะการจอง',
  `approver_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT 'รหัสผู้อนุมัติ (อ้างอิงตาราง personel)',
  `reject_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'เหตุผลที่ไม่อนุมัติหรือยกเลิก',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `room_bookings_room_id_foreign`(`room_id` ASC) USING BTREE,
  INDEX `room_bookings_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `room_bookings_approver_id_foreign`(`approver_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room_bookings
-- ----------------------------

-- ----------------------------
-- Table structure for salary_slips
-- ----------------------------
DROP TABLE IF EXISTS `salary_slips`;
CREATE TABLE `salary_slips`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'รหัสบัตรประชาชน (อ้างอิงตาราง personel)',
  `transfer_date` date NOT NULL COMMENT 'วันที่โอนเข้า',
  `month_year` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'รอบเดือน-ปี-ครั้ง เช่น 03-2026-01',
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ชื่อ - สกุล',
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ตำแหน่ง',
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'แผนก',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ชื่อธนาคาร',
  `account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เลขที่บัญชี',
  `earn_salary` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'เงินเดือน',
  `earn_living_allowance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าครองชีพ',
  `earn_backpay` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'เงินเดือน (ตกเบิก)',
  `earn_allowance_11` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนเบี้ยเลี้ยงเหมาจ่าย (ฉ.11)',
  `earn_ot` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนการปฏิบัติงานนอกเวลา (OT)',
  `earn_shift` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนเวรผลัดบ่าย - ดึก',
  `earn_proactive` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนเชิงรุก',
  `earn_special_med` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนแพทย์ส่งเสริมพิเศษ',
  `earn_autopsy` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนการชันสูตร',
  `earn_non_clinical` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทนไม่ทำเวช',
  `earn_pts` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าตอบแทน พตส.',
  `deduct_social_sec` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ประกันสังคม',
  `deduct_nks` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ณกส',
  `deduct_tax` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ภาษีหัก ณ ที่จ่าย',
  `deduct_baac` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ธนาคาร ธกส',
  `deduct_gsb` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ธนาคารออมสิน',
  `deduct_ktb` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ธนาคารกรุงไทย',
  `deduct_student_loan` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'กองทุนกู้ยืมเพื่อการศึกษา',
  `deduct_provident_fund` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'กองทุนสำรองเลี้ยงชีพ',
  `deduct_utility` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ค่าน้ำค่าไฟฟ้า',
  `total_earnings` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'รวมเงินรับทั้งหมด',
  `total_deductions` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'รวมเงินหักทั้งหมด',
  `net_pay` decimal(10, 2) NULL DEFAULT 0.00 COMMENT 'ยอดเงินสุทธิที่รับจริง',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'หมายเหตุ',
  `status` enum('draft','published') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'draft' COMMENT 'สถานะ: draft/published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `salary_slips_cid_index`(`cid` ASC) USING BTREE,
  INDEX `salary_slips_month_year_index`(`month_year` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of salary_slips
-- ----------------------------
INSERT INTO `salary_slips` VALUES (541, '3430400040914', '2026-03-05', '03-2026-01', 'นายวิทยา     บุตรสาระ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080216513', 0.00, 0.00, 0.00, 40000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 40000.00, 0.00, 40000.00, 'ตัวอย่าง: โอนรอบปกติ', 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (542, '1729900160543', '2026-03-05', '03-2026-01', 'นายภัทรพงษ์พันธ์  วัฒนพล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605626834', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (543, '1489900322341', '2026-03-05', '03-2026-01', 'นางสาวพรรณิภา  โกศล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083434058', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (544, '1103900045078', '2026-03-05', '03-2026-01', 'นายปราณ  กำจัดภัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636171146', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (545, '1103900055090', '2026-03-05', '03-2026-01', 'นางสาวเมธาวีร์  วรวัฒนะกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636170638', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (546, '1103702980943', '2026-03-05', '03-2026-01', 'นางสาวพีรยา  ตังคะวชิรานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '1720450684', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (547, '1489900377031', '2026-03-05', '03-2026-01', 'นางสาวจิรัชยา  ศรัทธาพันธ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625600679', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (548, '3480400073341', '2026-03-05', '03-2026-01', 'นางสาววนิดา     อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081473846', 0.00, 0.00, 0.00, 40000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 40000.00, 0.00, 40000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (549, '1100702810123', '2026-03-05', '03-2026-01', 'นางสาวภณิพิมพ์  ฟองพิสุทธิกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083374926', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (550, '1103702540358', '2026-03-05', '03-2026-01', 'นางสาวอิงลดา  กิจพิมล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083375043', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (551, '1480400057942', '2026-03-05', '03-2026-01', 'นางสาวมณีรัตน์    ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839918931', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (552, '1479900342181', '2026-03-05', '03-2026-01', 'นางสาวมาลิน  บุพศิริ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9849629975', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (553, '1103702648442', '2026-03-05', '03-2026-01', 'นางสาววลีรัตญา  นิลคง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786007341', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (554, '1480400054901', '2026-03-05', '03-2026-01', 'นางสาวพัชรนันท์  ฤทธิเดช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884988', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (555, '3480400064457', '2026-03-05', '03-2026-01', 'นางสาวสุภัสสร     อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6787450788', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:34', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (556, '1480400092802', '2026-03-05', '03-2026-01', 'นางสาวนงค์ลักษณ์  สะนาค', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885747', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (557, '3101400231314', '2026-03-05', '03-2026-01', 'นางสาววัชราภรณ์  อติวรรณกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080178980', 0.00, 0.00, 0.00, 6500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6500.00, 0.00, 6500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (558, '3480700056841', '2026-03-05', '03-2026-01', 'นางฐิติวรดา     ใจช่วง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080074085', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (559, '1480500117050', '2026-03-05', '03-2026-01', 'นางจิราภรณ์    แสนคุณท้าว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919288', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (560, '1489900240841', '2026-03-05', '03-2026-01', 'นางสาวสุรีรัตน์  สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6609137838', 0.00, 0.00, 0.00, 5500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5500.00, 0.00, 5500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (561, '1430900227545', '2026-03-05', '03-2026-01', 'นางสาวฐายิกา  ทิพย์แสง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6794604167', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (562, '1410100174064', '2026-03-05', '03-2026-01', 'นางสาวปนัดดา  มีจันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6612118393', 0.00, 0.00, 0.00, 4500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4500.00, 0.00, 4500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (563, '3340100617486', '2026-03-05', '03-2026-01', 'นางสาวพิมพา   คำก้อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080750579', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (564, '3480400213720', '2026-03-05', '03-2026-01', 'นายจักรกฤษณ์ มานันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880370', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (565, '3480400326117', '2026-03-05', '03-2026-01', 'นางสาวพิสมัย  ป้องหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884694', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (566, '1480400104819', '2026-03-05', '03-2026-01', 'นายวุฒิพงษ์  ทวนกลาง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786627277', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (567, '3480400233062', '2026-03-05', '03-2026-01', 'นางยุพนา     ลิงลม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080085753', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (568, '3480600323740', '2026-03-05', '03-2026-01', 'นางมะลินี     โพชะโน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080214421', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (569, '3480400067006', '2026-03-05', '03-2026-01', 'นางสาวมลิวรรณ    อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080262078', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (570, '3480400075416', '2026-03-05', '03-2026-01', 'นางรังสิมา     สิถิระบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080212771', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (571, '3480300702249', '2026-03-05', '03-2026-01', 'นางสุมาลี       อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625119628', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (572, '3480400305292', '2026-03-05', '03-2026-01', 'นางสาวสาธินี    บุรีวงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838844', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (573, '3110400242277', '2026-03-05', '03-2026-01', 'นางสาวณิชกช    อาตวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838887', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (574, '3480400378214', '2026-03-05', '03-2026-01', 'นางนวลนาง    ลวกุณ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080091702', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (575, '1480400010041', '2026-03-05', '03-2026-01', 'นางสาวจิราภรณ์    สุราสา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080751958', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (576, '3480400147069', '2026-03-05', '03-2026-01', 'นางสาวสุจิตรา   ขออาศัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081932913', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (577, '1430900202241', '2026-03-05', '03-2026-01', 'นางสาวมาฆศิริ  ศรีนาทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6794573709', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (578, '3480400072212', '2026-03-05', '03-2026-01', 'นางภิญญา  ฮามพันธ์เมือง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080079796', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (579, '3480400410487', '2026-03-05', '03-2026-01', 'นางนิมิตร   ไชยภูวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080082347', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (580, '3480400066395', '2026-03-05', '03-2026-01', 'นางพวงเพชร     สมเพราะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878740', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (581, '3480400377358', '2026-03-05', '03-2026-01', 'นางทัศนา       ต้นสียา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879046', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (582, '1480400056172', '2026-03-05', '03-2026-01', 'นางสาวนาตยา    สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083520272', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (583, '1480700147653', '2026-03-05', '03-2026-01', 'นางสาวนันทิกา  ปัญญาพ่อ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6601886246', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (584, '1489900331481', '2026-03-05', '03-2026-01', 'นายกฤษณชัย  สมมะโน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882519', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (585, '1489700006951', '2026-03-05', '03-2026-01', 'นายธีรภัทร  จู่มา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885402', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (586, '1419902085479', '2026-03-05', '03-2026-01', 'นายโชคอนันต์  ภูมิประสาท', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180766507', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (587, '1479300012279', '2026-03-05', '03-2026-01', 'นางสาวนลินี ทนุพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4193527530', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (588, '1570200063891', '2026-03-05', '03-2026-01', 'นางสาวรจนา  ผาแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882977', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (589, '1480800137781', '2026-03-05', '03-2026-01', 'นายเอกสิทธิ์  เสนเพ็ง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6602667092', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (590, '1480400095755', '2026-03-05', '03-2026-01', 'นายฤทธิพงษ์  บุญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838489522', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (591, '1480400049761', '2026-03-05', '03-2026-01', 'นายวีระชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892840', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (592, '3480300380837', '2026-03-05', '03-2026-01', 'นางศิตา    พลีจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136404', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (593, '3480400073324', '2026-03-05', '03-2026-01', 'นางยุพิน    นวานุช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080267827', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (594, '3480400366089', '2026-03-05', '03-2026-01', 'นายพลาธิป     บุญทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136382', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (595, '1480400053602', '2026-03-05', '03-2026-01', 'นางสาวสุชาดา  เสนาราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6638944320', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (596, '1480400061711', '2026-03-05', '03-2026-01', 'นางสาววลัยภรณ์  จองไว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4500592709', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (597, '3480400375312', '2026-03-05', '03-2026-01', 'นางสาววรรณวิมล  คำมุข', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081556881', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (598, '1480400006272', '2026-03-05', '03-2026-01', 'นางสาวทิพารัตน์   เรือนทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080302711', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (599, '1480400117481', '2026-03-05', '03-2026-01', 'นางสาวณัฐกานต์ เวียงสิมา', 'พนักงานบริการ', 'กลุ่มงานบริการด้านปฐมภูมิและองค์รวม', 'ธนาคารกรุงไทย (KTB)', '4300813639', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (600, '3480400075424', '2026-03-05', '03-2026-01', 'นางประเดิม     อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080077963', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (601, '3480800274581', '2026-03-05', '03-2026-01', 'นางสาวกนกวรรณ  สายบุญเลิศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6795475182', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (602, '1480400105386', '2026-03-05', '03-2026-01', 'นายทิวัตถ์  ไชยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9848120068', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (603, '1430300250490', '2026-03-05', '03-2026-01', 'นางสาวจุไรรัตน์  แก้วทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300842388', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (604, '3430400073316', '2026-03-05', '03-2026-01', 'นางสายสมร    ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080085737', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (605, '3480300684348', '2026-03-05', '03-2026-01', 'นางสาวดาวนภา     ศรีวรสาร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081685', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (606, '3430900614251', '2026-03-05', '03-2026-01', 'นางเปรมฤดี     คำจันทร์ศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080089899', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (607, '1480800012784', '2026-03-05', '03-2026-01', 'นายเอกพจน์   เสถา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080908768', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (608, '3480400267005', '2026-03-05', '03-2026-01', 'นางสาวภรภัค   เมืองซอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081711585', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (609, '3480400062314', '2026-03-05', '03-2026-01', 'นางณวรัตน์     เสียงล้ำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081715', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (610, '3480200024796', '2026-03-05', '03-2026-01', 'นางพัชราภรณ์     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080079834', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:35', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (611, '3010701322467', '2026-03-05', '03-2026-01', 'นางปรารถนา      คำมุข', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080177739', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (612, '3480400407052', '2026-03-05', '03-2026-01', 'นายลักเร่    อุดมมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881555', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (613, '3480400218985', '2026-03-05', '03-2026-01', 'นายจีรพันธ์    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885445', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (614, '3480400088119', '2026-03-05', '03-2026-01', 'นางวันวิสา  ขันเดช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880214', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (615, '3480400243424', '2026-03-05', '03-2026-01', 'นางจันทร์จิรา     ศรีเหล่า', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080078277', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (616, '3480800060785', '2026-03-05', '03-2026-01', 'นางจิณณ์ภัคธนา    เนตรวงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080370636', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (617, '3480400008859', '2026-03-05', '03-2026-01', 'นางสาวอภิญญา    อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080470460', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (618, '3480400377251', '2026-03-05', '03-2026-01', 'นางสาวสุกาญดา    ภาสอน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6735622928', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (619, '1480400045774', '2026-03-05', '03-2026-01', 'นางสาวเพียงพิศ  สมรฤทธิ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080495552', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (620, '1489900121923', '2026-03-05', '03-2026-01', 'นางสาวสุทธิดา    สีหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9850593229', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (621, '1480400084516', '2026-03-05', '03-2026-01', 'นางสาวสุธีธิดา  เสียงล้ำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9846118155', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (622, '1480500116771', '2026-03-05', '03-2026-01', 'นางสาวกมลชนก  อุ่นชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919687', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (623, '1480701245985', '2026-03-05', '03-2026-01', 'นางสาวมัยญรัตน์  อุดมทนานุกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210517771', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (624, '3480400406986', '2026-03-05', '03-2026-01', 'นายไพ     มุมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881016', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (625, '1480400002901', '2026-03-05', '03-2026-01', 'นายสมพงษ์  อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881768', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (626, '3480400416914', '2026-03-05', '03-2026-01', 'นายจันธิราช    ไชยภูวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882942', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (627, '1480400124127', '2026-03-05', '03-2026-01', 'นางสาวสาวิตรี  นาโสก', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6714577915', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (628, '1480400112030', '2026-03-05', '03-2026-01', 'นายอภิวัฒน์  บรรเทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6642143159', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (629, '1480400100121', '2026-03-05', '03-2026-01', 'นางสาวสุคนธา  ถาปาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882268', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (630, '1489900374996', '2026-03-05', '03-2026-01', 'นางสาวธัญนาฏ  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864111078', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (631, '3480400236754', '2026-03-05', '03-2026-01', 'นางสาวชุติกาญจน์  ก่ำเสริฐ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884155', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (632, '1480400047271', '2026-03-05', '03-2026-01', 'นางแสงระวี    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641544559', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (633, '1480400098754', '2026-03-05', '03-2026-01', 'นางสาวชลิตา  สาสาย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080644280', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (634, '1407500024350', '2026-03-05', '03-2026-01', 'นางสาวพรนัชชา  ชาวยศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6617840127', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (635, '1340400229035', '2026-03-05', '03-2026-01', 'นางสาวช่อผกา  ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9861455701', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (636, '1421300016803', '2026-03-05', '03-2026-01', 'นายพลวัตร  นิลตานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605595130', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (637, '1480400055656', '2026-03-05', '03-2026-01', 'นายยศดนัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646281599', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (638, '1410800101752', '2026-03-05', '03-2026-01', 'นายหัถชัย  หัสเดชะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6777412689', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (639, '1489700029276', '2026-03-05', '03-2026-01', 'นายเอกพร  เจริญผล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629182618', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (640, '1431100024659', '2026-03-05', '03-2026-01', 'นายเสกสรร  คะสาน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6647039503', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (641, '1489700005504', '2026-03-05', '03-2026-01', 'นางสาวธนัญญา พยุงวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6798226426', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (642, '3480400073332', '2026-03-05', '03-2026-01', 'นางยุพารี    ทัพวัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080100736', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (643, '3480800396724', '2026-03-05', '03-2026-01', 'นางสันสนี     ใหม่วงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080078218', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (644, '5480300007814', '2026-03-05', '03-2026-01', 'นางสาวนุชจรี     บุตรบุรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081707', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (645, '1480400051120', '2026-03-05', '03-2026-01', 'นางสาวภัคศรัณย์  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629701402', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (646, '3480400214831', '2026-03-05', '03-2026-01', 'นางประทุมมี  ตันสาย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878147', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (647, '3460300724170', '2026-03-05', '03-2026-01', 'นางพัชรินทร์   ทันจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6623088733', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (648, '3480400083931', '2026-03-05', '03-2026-01', 'นางสมภักตร์    ภาโสม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080292538', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (649, '2480400001392', '2026-03-05', '03-2026-01', 'นางปราณี     ศิลป์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892042', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (650, '3480400408903', '2026-03-05', '03-2026-01', 'นางสาวฐิรพร    ธรรมจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880885', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (651, '1209702023722', '2026-03-05', '03-2026-01', 'นายธนเดช  นิยมกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883566', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (652, '1489700006314', '2026-03-05', '03-2026-01', 'นางสาวรัชฏาวรรณ  ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648155876', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (653, '3480500265268', '2026-03-05', '03-2026-01', 'นางสาวบุษกร    สำเภา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080097220', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (654, '3480300749725', '2026-03-05', '03-2026-01', 'นางธนพร  วรรณแสง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879925', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (655, '1480400086233', '2026-03-05', '03-2026-01', 'นางสาวอินธุอร   ศรีนันทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883159', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (656, '3480400226503', '2026-03-05', '03-2026-01', 'นางสาวศศิธร  สุวารีย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886964', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (657, '1480700110563', '2026-03-05', '03-2026-01', 'นางสาวลดาวัลย์  ไตยราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884007', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (658, '1470800221634', '2026-03-05', '03-2026-01', 'นางสาววิสุดา   บาลจบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886549', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (659, '1480800159238', '2026-03-05', '03-2026-01', 'นางสาวพรธิตา  ศิริวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864992031', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (660, '1489900398356', '2026-03-05', '03-2026-01', 'นายภูริภัทร์  หวายสุด', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083341262', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (661, '1480500097351', '2026-03-05', '03-2026-01', 'นางสาวเพ็ญพร   เอกจักรแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210218235', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (662, '1479900472513', '2026-03-05', '03-2026-01', 'นายกิตติคุณ  มัยวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838933570', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (663, '1103700452320', '2026-03-05', '03-2026-01', 'นางธัญญาลักษณ์  ประยูรเสาวภาคย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4400361837', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (664, '1480400096352', '2026-03-05', '03-2026-01', 'นางสาวพิมศิริ  เกษบัว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881962', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (665, '1481100027500', '2026-03-05', '03-2026-01', 'นางสาวรมิดา  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '8283268465', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (666, '3480300048174', '2026-03-05', '03-2026-01', 'นายวิทวัส     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081948976', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (667, '1481000066902', '2026-03-05', '03-2026-01', 'นางสาวสุชาดา   ราชมณี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080508824', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (668, '1489900374651', '2026-03-05', '03-2026-01', 'นางสาวอริญา  ท่าทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9862817542', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:36', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (669, '1350300094855', '2026-03-05', '03-2026-01', 'นางสาวสุภัสสร   วรรณอ่อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839067494', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (670, '1471300089860', '2026-03-05', '03-2026-01', 'นางสาวเกวรินทร์  โตมาชา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6645738447', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (671, '1509966081571', '2026-03-05', '03-2026-01', 'นายภัทรเชษฐ  รุ่งโรจน์วัฒนศิริ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '2613367687', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (672, '1489700000430', '2026-03-05', '03-2026-01', 'นางสาวจิราพัชร  เขียวคำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6632605222', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (673, '3480200214056', '2026-03-05', '03-2026-01', 'นางสาวกวินารัตน์     คำศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080160356', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (674, '1419901775099', '2026-03-05', '03-2026-01', 'นางสาวอาทิตยา  โคตรสมบัติ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083382376', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (675, '1430500375610', '2026-03-05', '03-2026-01', 'นางสาวกรวิภา  วงษ์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6600044357', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (676, '3480400377561', '2026-03-05', '03-2026-01', 'นายบรรจง   ทุมพิลา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883698', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (677, '1489700006624', '2026-03-05', '03-2026-01', 'นางสาวอริศรา  อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6628404714', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (678, '3480400055164', '2026-03-05', '03-2026-01', 'นางเอื้อมพร  สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646540748', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (679, '3480300005661', '2026-03-05', '03-2026-01', 'นางเกษมณี  วิจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '3011949034', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (680, '1410401515481', '2026-03-05', '03-2026-01', 'นายวิศวะ  ศรีวงษ์ราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180905981', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (681, '3480400074142', '2026-03-05', '03-2026-01', 'นายปริญญา    อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883310', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (682, '3480400073278', '2026-03-05', '03-2026-01', 'นายณัฐภัทร  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879275', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (683, '3480400065691', '2026-03-05', '03-2026-01', 'นายอิทธิพล    ภาโสม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879666', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (684, '1459900068054', '2026-03-05', '03-2026-01', 'นายอนันต์   สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641936333', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (685, '3480200314247', '2026-03-05', '03-2026-01', 'นายขวัญชัย  คุยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641708675', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (686, '1480400109284', '2026-03-05', '03-2026-01', 'นายทวีวัฒน์  สุพรรณ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878066', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (687, '1489900165777', '2026-03-05', '03-2026-01', 'นายธวัชชัย  พรมราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878678', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (688, '3480400073154', '2026-03-05', '03-2026-01', 'นายสาโรช  สมเทพ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648907436', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (689, '3430900615584', '2026-03-05', '03-2026-01', 'นางวิลาวัลย์  พรหมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885895', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (690, '1340400210008', '2026-03-05', '03-2026-01', 'นายวัชรพงศ์  ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6620118062', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (691, '1480100127210', '2026-03-05', '03-2026-01', 'นางสาวมนัสนันท์  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886050', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (692, '1480400116612', '2026-03-05', '03-2026-01', 'นางสาวนิตยา  ศรีลาคม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300986185', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (693, '1301502002332', '2026-03-05', '03-2026-01', 'นายจิรายุส ครุฑใจกล้า', 'นักจัดการทั่วไป', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '9848532757', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (694, '3439900079192', '2026-03-05', '03-2026-01', 'นางสาวรัชดา บุตรวงค์', 'เจ้าพนักงานธุรการ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4080136374', 0.00, 0.00, 0.00, 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 0.00, 2500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (695, '1480800044627', '2026-03-05', '03-2026-01', 'นางสาวจินตหรา นิมิตร', 'เจ้าพนักงานการเงินและบัญชี', 'งานการเงินและบัญชี', 'ธนาคารกรุงไทย (KTB)', '9850226463', 0.00, 0.00, 0.00, 2300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2300.00, 0.00, 2300.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (696, '1470100279273', '2026-03-05', '03-2026-01', 'นายมงคล โพธิ์นะ', 'นักวิชาการเงินและบัญชี', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4083227877', 0.00, 0.00, 0.00, 2300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2300.00, 0.00, 2300.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (697, '1480400057381', '2026-03-05', '03-2026-01', 'นางสาวเตือนใจ งามแฉ้ม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9854843157', 0.00, 0.00, 0.00, 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 0.00, 2500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (698, '1480501295156', '2026-03-05', '03-2026-01', 'นางสาวพรนภา พลายงาม', 'เจ้าพนักงานพัสดุ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '8850359640', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (699, '1431100044579', '2026-03-05', '03-2026-01', 'นางสาวสุดารัตน์ แพงโท', 'เจ้าพนักงานธุรการ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '6604110303', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (700, '3540400307766', '2026-03-05', '03-2026-01', 'นางสาวกัณณิกา  ช้างมูบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886409', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (701, '1480400035213', '2026-03-05', '03-2026-01', 'นายสุวัฒน์ชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884724', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (702, '1480400040438', '2026-03-05', '03-2026-01', 'นายวีรพล  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885186', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (703, '1480400046941', '2026-03-05', '03-2026-01', 'นายพงศธร  พรมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6643378699', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (704, '1250100358515', '2026-03-05', '03-2026-01', 'นางสาวกนิษฐา วงษ์หอย', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4780601371', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (705, '1480800122181', '2026-03-05', '03-2026-01', 'นายจักรพงศ์ ทิพยศรี', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4083108983', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (706, '1480400109152', '2026-03-05', '03-2026-01', 'นายธนากร พรหมจอม', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '6647047018', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 13:20:37', '2026-04-09 13:20:54');
INSERT INTO `salary_slips` VALUES (707, '3430400040914', '2026-02-04', '02-2026-01', 'นายวิทยา     บุตรสาระ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080216513', 0.00, 0.00, 0.00, 40000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 40000.00, 0.00, 40000.00, 'ตัวอย่าง: โอนรอบปกติ', 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (708, '1729900160543', '2026-02-04', '02-2026-01', 'นายภัทรพงษ์พันธ์  วัฒนพล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605626834', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (709, '1489900322341', '2026-02-04', '02-2026-01', 'นางสาวพรรณิภา  โกศล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083434058', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (710, '1103900045078', '2026-02-04', '02-2026-01', 'นายปราณ  กำจัดภัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636171146', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (711, '1103900055090', '2026-02-04', '02-2026-01', 'นางสาวเมธาวีร์  วรวัฒนะกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636170638', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (712, '1103702980943', '2026-02-04', '02-2026-01', 'นางสาวพีรยา  ตังคะวชิรานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '1720450684', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (713, '1489900377031', '2026-02-04', '02-2026-01', 'นางสาวจิรัชยา  ศรัทธาพันธ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625600679', 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 10000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (714, '3480400073341', '2026-02-04', '02-2026-01', 'นางสาววนิดา     อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081473846', 0.00, 0.00, 0.00, 40000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 40000.00, 0.00, 40000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (715, '1100702810123', '2026-02-04', '02-2026-01', 'นางสาวภณิพิมพ์  ฟองพิสุทธิกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083374926', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (716, '1103702540358', '2026-02-04', '02-2026-01', 'นางสาวอิงลดา  กิจพิมล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083375043', 0.00, 0.00, 0.00, 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 30000.00, 0.00, 30000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (717, '1480400057942', '2026-02-04', '02-2026-01', 'นางสาวมณีรัตน์    ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839918931', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (718, '1103702648442', '2026-02-04', '02-2026-01', 'นางสาววลีรัตญา  นิลคง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786007341', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (719, '1480400054901', '2026-02-04', '02-2026-01', 'นางสาวพัชรนันท์  ฤทธิเดช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884988', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (720, '3480400064457', '2026-02-04', '02-2026-01', 'นางสาวสุภัสสร     อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6787450788', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (721, '1480400092802', '2026-02-04', '02-2026-01', 'นางสาวนงค์ลักษณ์  สะนาค', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885747', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (722, '1900100111874', '2026-02-04', '02-2026-01', 'นางสาวนัซวานี  หลีหมัด', 'ไม่ระบุ', 'ไม่ระบุ', '-', '-', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (723, '3101400231314', '2026-02-04', '02-2026-01', 'นางสาววัชราภรณ์  อติวรรณกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080178980', 0.00, 0.00, 0.00, 6500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6500.00, 0.00, 6500.00, NULL, 'published', '2026-04-09 16:49:15', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (724, '3340100617486', '2026-02-04', '02-2026-01', 'นางสาวพิมพา   คำก้อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080750579', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (725, '3480700056841', '2026-02-04', '02-2026-01', 'นางฐิติวรดา     ใจช่วง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080074085', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (726, '1480500117050', '2026-02-04', '02-2026-01', 'นางจิราภรณ์    แสนคุณท้าว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919288', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (727, '1489900240841', '2026-02-04', '02-2026-01', 'นางสาวสุรีรัตน์  สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6609137838', 0.00, 0.00, 0.00, 5500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5500.00, 0.00, 5500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (728, '3480400213720', '2026-02-04', '02-2026-01', 'นายจักรกฤษณ์ มานันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880370', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (729, '1410100174064', '2026-02-04', '02-2026-01', 'นางสาวปนัดดา  มีจันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6612118393', 0.00, 0.00, 0.00, 4500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4500.00, 0.00, 4500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (730, '3480400326117', '2026-02-04', '02-2026-01', 'นางสาวพิสมัย  ป้องหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884694', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (731, '1480400104819', '2026-02-04', '02-2026-01', 'นายวุฒิพงษ์  ทวนกลาง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786627277', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (732, '3480400233062', '2026-02-04', '02-2026-01', 'นางยุพนา     ลิงลม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080085753', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (733, '3480600323740', '2026-02-04', '02-2026-01', 'นางมะลินี     โพชะโน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080214421', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (734, '3480400067006', '2026-02-04', '02-2026-01', 'นางสาวมลิวรรณ    อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080262078', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (735, '3480400075416', '2026-02-04', '02-2026-01', 'นางรังสิมา     สิถิระบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080212771', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (736, '3480300702249', '2026-02-04', '02-2026-01', 'นางสุมาลี       อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625119628', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (737, '3480400305292', '2026-02-04', '02-2026-01', 'นางสาวสาธินี    บุรีวงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838844', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (738, '3110400242277', '2026-02-04', '02-2026-01', 'นางสาวณิชกช    อาตวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838887', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (739, '3480400378214', '2026-02-04', '02-2026-01', 'นางนวลนาง    ลวกุณ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080091702', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (740, '1480400010041', '2026-02-04', '02-2026-01', 'นางสาวจิราภรณ์    สุราสา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080751958', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (741, '3480400147069', '2026-02-04', '02-2026-01', 'นางสาวสุจิตรา   ขออาศัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081932913', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (742, '1430900202241', '2026-02-04', '02-2026-01', 'นางสาวมาฆศิริ  ศรีนาทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6794573709', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (743, '3480400072212', '2026-02-04', '02-2026-01', 'นางภิญญา  ฮามพันธ์เมือง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080079796', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (744, '3480400410487', '2026-02-04', '02-2026-01', 'นางนิมิตร   ไชยภูวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080082347', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (745, '3480400233631', '2026-02-04', '02-2026-01', 'นางสาวจันทร์จิรา   กุณรักษ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879607', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (746, '3480400066395', '2026-02-04', '02-2026-01', 'นางพวงเพชร     สมเพราะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878740', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (747, '3480400377358', '2026-02-04', '02-2026-01', 'นางทัศนา       ต้นสียา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879046', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (748, '1480400056172', '2026-02-04', '02-2026-01', 'นางสาวนาตยา    สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083520272', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (749, '1480700147653', '2026-02-04', '02-2026-01', 'นางสาวนันทิกา  ปัญญาพ่อ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6601886246', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (750, '1489900331481', '2026-02-04', '02-2026-01', 'นายกฤษณชัย  สมมะโน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882519', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (751, '1489700006951', '2026-02-04', '02-2026-01', 'นายธีรภัทร  จู่มา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885402', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (752, '1419902085479', '2026-02-04', '02-2026-01', 'นายโชคอนันต์  ภูมิประสาท', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180766507', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (753, '1479300012279', '2026-02-04', '02-2026-01', 'นางสาวนลินี ทนุพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4193527530', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (754, '1570200063891', '2026-02-04', '02-2026-01', 'นางสาวรจนา  ผาแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882977', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (755, '1480800137781', '2026-02-04', '02-2026-01', 'นายเอกสิทธิ์  เสนเพ็ง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6602667092', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (756, '1480400095755', '2026-02-04', '02-2026-01', 'นายฤทธิพงษ์  บุญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838489522', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (757, '1480400049761', '2026-02-04', '02-2026-01', 'นายวีระชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892840', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (758, '3480300380837', '2026-02-04', '02-2026-01', 'นางศิตา    พลีจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136404', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (759, '3480400073324', '2026-02-04', '02-2026-01', 'นางยุพิน    นวานุช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080267827', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (760, '3480400366089', '2026-02-04', '02-2026-01', 'นายพลาธิป     บุญทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136382', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (761, '1480400006272', '2026-02-04', '02-2026-01', 'นางสาวทิพารัตน์   เรือนทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080302711', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (762, '1480400053602', '2026-02-04', '02-2026-01', 'นางสาวสุชาดา  เสนาราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6638944320', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (763, '1480400117481', '2026-02-04', '02-2026-01', 'นางสาวณัฐกานต์ เวียงสิมา', 'พนักงานบริการ', 'กลุ่มงานบริการด้านปฐมภูมิและองค์รวม', 'ธนาคารกรุงไทย (KTB)', '4300813639', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (764, '1480400061711', '2026-02-04', '02-2026-01', 'นางสาววลัยภรณ์  จองไว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4500592709', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (765, '3480400375312', '2026-02-04', '02-2026-01', 'นางสาววรรณวิมล  คำมุข', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081556881', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (766, '3480400075424', '2026-02-04', '02-2026-01', 'นางประเดิม     อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080077963', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (767, '1480400105386', '2026-02-04', '02-2026-01', 'นายทิวัตถ์  ไชยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9848120068', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (768, '1430300250490', '2026-02-04', '02-2026-01', 'นางสาวจุไรรัตน์  แก้วทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300842388', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (769, '3480800274581', '2026-02-04', '02-2026-01', 'นางสาวกนกวรรณ  สายบุญเลิศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6795475182', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (770, '3430400073316', '2026-02-04', '02-2026-01', 'นางสายสมร    ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080085737', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (771, '3480300684348', '2026-02-04', '02-2026-01', 'นางสาวดาวนภา     ศรีวรสาร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081685', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (772, '3430900614251', '2026-02-04', '02-2026-01', 'นางเปรมฤดี     คำจันทร์ศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080089899', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (773, '1480800012784', '2026-02-04', '02-2026-01', 'นายเอกพจน์   เสถา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080908768', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (774, '3480400267005', '2026-02-04', '02-2026-01', 'นางสาวภรภัค   เมืองซอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081711585', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (775, '3480400407052', '2026-02-04', '02-2026-01', 'นายลักเร่    อุดมมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881555', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (776, '3480400218985', '2026-02-04', '02-2026-01', 'นายจีรพันธ์    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885445', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (777, '3480400088119', '2026-02-04', '02-2026-01', 'นางวันวิสา  ขันเดช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880214', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (778, '3480400062314', '2026-02-04', '02-2026-01', 'นางณวรัตน์     เสียงล้ำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081715', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (779, '3480200024796', '2026-02-04', '02-2026-01', 'นางพัชราภรณ์     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080079834', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (780, '3010701322467', '2026-02-04', '02-2026-01', 'นางปรารถนา      คำมุข', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080177739', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (781, '3480400243424', '2026-02-04', '02-2026-01', 'นางจันทร์จิรา     ศรีเหล่า', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080078277', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (782, '3480800060785', '2026-02-04', '02-2026-01', 'นางจิณณ์ภัคธนา    เนตรวงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080370636', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:16', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (783, '3480400008859', '2026-02-04', '02-2026-01', 'นางสาวอภิญญา    อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080470460', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (784, '3480400377251', '2026-02-04', '02-2026-01', 'นางสาวสุกาญดา    ภาสอน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6735622928', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (785, '1480400045774', '2026-02-04', '02-2026-01', 'นางสาวเพียงพิศ  สมรฤทธิ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080495552', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (786, '1489900121923', '2026-02-04', '02-2026-01', 'นางสาวสุทธิดา    สีหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9850593229', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (787, '1480701245985', '2026-02-04', '02-2026-01', 'นางสาวมัยญรัตน์  อุดมทนานุกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210517771', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (788, '3480400406986', '2026-02-04', '02-2026-01', 'นายไพ     มุมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881016', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (789, '1480400002901', '2026-02-04', '02-2026-01', 'นายสมพงษ์  อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881768', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (790, '3480400416914', '2026-02-04', '02-2026-01', 'นายจันธิราช    ไชยภูวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882942', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (791, '1480400124127', '2026-02-04', '02-2026-01', 'นางสาวสาวิตรี  นาโสก', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6714577915', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (792, '1480400084516', '2026-02-04', '02-2026-01', 'นางสาวสุธีธิดา  เสียงล้ำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9846118155', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (793, '1480400112030', '2026-02-04', '02-2026-01', 'นายอภิวัฒน์  บรรเทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6642143159', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (794, '1480400100121', '2026-02-04', '02-2026-01', 'นางสาวสุคนธา  ถาปาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882268', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (795, '1489900374996', '2026-02-04', '02-2026-01', 'นางสาวธัญนาฏ  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864111078', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (796, '3480400236754', '2026-02-04', '02-2026-01', 'นางสาวชุติกาญจน์  ก่ำเสริฐ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884155', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (797, '1480400047271', '2026-02-04', '02-2026-01', 'นางแสงระวี    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641544559', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (798, '1480400098754', '2026-02-04', '02-2026-01', 'นางสาวชลิตา  สาสาย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080644280', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (799, '1480500116771', '2026-02-04', '02-2026-01', 'นางสาวกมลชนก  อุ่นชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919687', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (800, '1407500024350', '2026-02-04', '02-2026-01', 'นางสาวพรนัชชา  ชาวยศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6617840127', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (801, '1340400229035', '2026-02-04', '02-2026-01', 'นางสาวช่อผกา  ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9861455701', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (802, '1421300016803', '2026-02-04', '02-2026-01', 'นายพลวัตร  นิลตานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605595130', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (803, '1480400055656', '2026-02-04', '02-2026-01', 'นายยศดนัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646281599', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (804, '1410800101752', '2026-02-04', '02-2026-01', 'นายหัถชัย  หัสเดชะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6777412689', 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (805, '1489700029276', '2026-02-04', '02-2026-01', 'นายเอกพร  เจริญผล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629182618', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (806, '1431100024659', '2026-02-04', '02-2026-01', 'นายเสกสรร  คะสาน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6647039503', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (807, '1489700005504', '2026-02-04', '02-2026-01', 'นางสาวธนัญญา พยุงวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6798226426', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (808, '3480400073332', '2026-02-04', '02-2026-01', 'นางยุพารี    ทัพวัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080100736', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (809, '3480800396724', '2026-02-04', '02-2026-01', 'นางสันสนี     ใหม่วงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080078218', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (810, '3480400214831', '2026-02-04', '02-2026-01', 'นางประทุมมี  ตันสาย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878147', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (811, '3460300724170', '2026-02-04', '02-2026-01', 'นางพัชรินทร์   ทันจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6623088733', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (812, '5480300007814', '2026-02-04', '02-2026-01', 'นางสาวนุชจรี     บุตรบุรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081707', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (813, '1480400051120', '2026-02-04', '02-2026-01', 'นางสาวภัคศรัณย์  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629701402', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (814, '3480400083931', '2026-02-04', '02-2026-01', 'นางสมภักตร์    ภาโสม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080292538', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (815, '2480400001392', '2026-02-04', '02-2026-01', 'นางปราณี     ศิลป์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892042', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (816, '3480400408903', '2026-02-04', '02-2026-01', 'นางสาวฐิรพร    ธรรมจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880885', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (817, '1209702023722', '2026-02-04', '02-2026-01', 'นายธนเดช  นิยมกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883566', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (818, '1489700006314', '2026-02-04', '02-2026-01', 'นางสาวรัชฏาวรรณ  ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648155876', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (819, '3480500265268', '2026-02-04', '02-2026-01', 'นางสาวบุษกร    สำเภา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080097220', 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (820, '3480300749725', '2026-02-04', '02-2026-01', 'นางธนพร  วรรณแสง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879925', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (821, '1480400086233', '2026-02-04', '02-2026-01', 'นางสาวอินธุอร   ศรีนันทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883159', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (822, '3480400226503', '2026-02-04', '02-2026-01', 'นางสาวศศิธร  สุวารีย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886964', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (823, '1480700110563', '2026-02-04', '02-2026-01', 'นางสาวลดาวัลย์  ไตยราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884007', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (824, '1470800221634', '2026-02-04', '02-2026-01', 'นางสาววิสุดา   บาลจบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886549', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (825, '1480800159238', '2026-02-04', '02-2026-01', 'นางสาวพรธิตา  ศิริวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864992031', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (826, '1489900398356', '2026-02-04', '02-2026-01', 'นายภูริภัทร์  หวายสุด', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083341262', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (827, '1480500097351', '2026-02-04', '02-2026-01', 'นางสาวเพ็ญพร   เอกจักรแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210218235', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (828, '1480400096352', '2026-02-04', '02-2026-01', 'นางสาวพิมศิริ  เกษบัว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881962', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (829, '1479900472513', '2026-02-04', '02-2026-01', 'นายกิตติคุณ  มัยวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838933570', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (830, '1103700452320', '2026-02-04', '02-2026-01', 'นางธัญญาลักษณ์  ประยูรเสาวภาคย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4400361837', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (831, '1481100027500', '2026-02-04', '02-2026-01', 'นางสาวรมิดา  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '8283268465', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (832, '3480300048174', '2026-02-04', '02-2026-01', 'นายวิทวัส     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081948976', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (833, '1481000066902', '2026-02-04', '02-2026-01', 'นางสาวสุชาดา   ราชมณี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080508824', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (834, '1489900374651', '2026-02-04', '02-2026-01', 'นางสาวอริญา  ท่าทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9862817542', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (835, '1350300094855', '2026-02-04', '02-2026-01', 'นางสาวสุภัสสร   วรรณอ่อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839067494', 0.00, 0.00, 0.00, 3000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (836, '1489700000430', '2026-02-04', '02-2026-01', 'นางสาวจิราพัชร  เขียวคำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6632605222', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (837, '1471300089860', '2026-02-04', '02-2026-01', 'นางสาวเกวรินทร์  โตมาชา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6645738447', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (838, '1509966081571', '2026-02-04', '02-2026-01', 'นายภัทรเชษฐ  รุ่งโรจน์วัฒนศิริ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '2613367687', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (839, '3480200214056', '2026-02-04', '02-2026-01', 'นางสาวกวินารัตน์     คำศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080160356', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (840, '1419901775099', '2026-02-04', '02-2026-01', 'นางสาวอาทิตยา  โคตรสมบัติ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083382376', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (841, '3480400377561', '2026-02-04', '02-2026-01', 'นายบรรจง   ทุมพิลา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883698', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (842, '1489700006624', '2026-02-04', '02-2026-01', 'นางสาวอริศรา  อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6628404714', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (843, '1430500375610', '2026-02-04', '02-2026-01', 'นางสาวกรวิภา  วงษ์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6600044357', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (844, '3480400055164', '2026-02-04', '02-2026-01', 'นางเอื้อมพร  สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646540748', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:17', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (845, '3480300005661', '2026-02-04', '02-2026-01', 'นางเกษมณี  วิจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '3011949034', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (846, '3480400074142', '2026-02-04', '02-2026-01', 'นายปริญญา    อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883310', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (847, '3480400073278', '2026-02-04', '02-2026-01', 'นายณัฐภัทร  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879275', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (848, '1410401515481', '2026-02-04', '02-2026-01', 'นายวิศวะ  ศรีวงษ์ราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180905981', 0.00, 0.00, 0.00, 2200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2200.00, 0.00, 2200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (849, '3480400065691', '2026-02-04', '02-2026-01', 'นายอิทธิพล    ภาโสม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879666', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (850, '1459900068054', '2026-02-04', '02-2026-01', 'นายอนันต์   สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641936333', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (851, '3480200314247', '2026-02-04', '02-2026-01', 'นายขวัญชัย  คุยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641708675', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (852, '1480400109284', '2026-02-04', '02-2026-01', 'นายทวีวัฒน์  สุพรรณ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878066', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (853, '1489900165777', '2026-02-04', '02-2026-01', 'นายธวัชชัย  พรมราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878678', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (854, '3480400073154', '2026-02-04', '02-2026-01', 'นายสาโรช  สมเทพ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648907436', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (855, '3430900615584', '2026-02-04', '02-2026-01', 'นางวิลาวัลย์  พรหมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885895', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (856, '1340400210008', '2026-02-04', '02-2026-01', 'นายวัชรพงศ์  ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6620118062', 0.00, 0.00, 0.00, 2800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2800.00, 0.00, 2800.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (857, '1480100127210', '2026-02-04', '02-2026-01', 'นางสาวมนัสนันท์  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886050', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (858, '1480400116612', '2026-02-04', '02-2026-01', 'นางสาวนิตยา  ศรีลาคม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300986185', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (859, '1301502002332', '2026-02-04', '02-2026-01', 'นายจิรายุส ครุฑใจกล้า', 'นักจัดการทั่วไป', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '9848532757', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (860, '3439900079192', '2026-02-04', '02-2026-01', 'นางสาวรัชดา บุตรวงค์', 'เจ้าพนักงานธุรการ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4080136374', 0.00, 0.00, 0.00, 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 0.00, 2500.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (861, '1480800044627', '2026-02-04', '02-2026-01', 'นางสาวจินตหรา นิมิตร', 'เจ้าพนักงานการเงินและบัญชี', 'งานการเงินและบัญชี', 'ธนาคารกรุงไทย (KTB)', '9850226463', 0.00, 0.00, 0.00, 2300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2300.00, 0.00, 2300.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (862, '1470100279273', '2026-02-04', '02-2026-01', 'นายมงคล โพธิ์นะ', 'นักวิชาการเงินและบัญชี', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4083227877', 0.00, 0.00, 0.00, 2300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2300.00, 0.00, 2300.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (863, '1480400057381', '2026-02-04', '02-2026-01', 'นางสาวเตือนใจ งามแฉ้ม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9854843157', 0.00, 0.00, 0.00, 2500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2500.00, 0.00, 2500.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (864, '1431100044579', '2026-02-04', '02-2026-01', 'นางสาวสุดารัตน์ แพงโท', 'เจ้าพนักงานธุรการ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '6604110303', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (865, '1480501295156', '2026-02-04', '02-2026-01', 'นางสาวพรนภา พลายงาม', 'เจ้าพนักงานพัสดุ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '8850359640', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (866, '3540400307766', '2026-02-04', '02-2026-01', 'นางสาวกัณณิกา  ช้างมูบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886409', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (867, '1480400035213', '2026-02-04', '02-2026-01', 'นายสุวัฒน์ชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884724', 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 1500.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (868, '1480400040438', '2026-02-04', '02-2026-01', 'นายวีรพล  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885186', 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 1200.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (869, '1480400046941', '2026-02-04', '02-2026-01', 'นายพงศธร  พรมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6643378699', 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 1000.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (870, '1250100358515', '2026-02-04', '02-2026-01', 'นางสาวกนิษฐา วงษ์หอย', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4780601371', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (871, '1480800122181', '2026-02-04', '02-2026-01', 'นายจักรพงศ์ ทิพยศรี', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4083108983', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (872, '1480400109152', '2026-02-04', '02-2026-01', 'นายธนากร พรหมจอม', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '6647047018', 0.00, 0.00, 0.00, 1700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1700.00, 0.00, 1700.00, NULL, 'published', '2026-04-09 16:49:18', '2026-04-09 16:50:08');
INSERT INTO `salary_slips` VALUES (873, '1729900160543', '2026-03-13', '03-2026-02', 'นายภัทรพงษ์พันธ์  วัฒนพล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605626834', 0.00, 0.00, 0.00, 0.00, 21600.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 31600.00, 0.00, 31600.00, 'ตัวอย่าง: โอนรอบปกติ', 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (874, '1489900322341', '2026-03-13', '03-2026-02', 'นางสาวพรรณิภา  โกศล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083434058', 0.00, 0.00, 0.00, 0.00, 19200.00, 0.00, 0.00, 5000.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 34200.00, 0.00, 34200.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (875, '1489900377031', '2026-03-13', '03-2026-02', 'นางสาวจิรัชยา  ศรัทธาพันธ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625600679', 0.00, 0.00, 0.00, 0.00, 16200.00, 0.00, 0.00, 5000.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 31200.00, 0.00, 31200.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (876, '1103702980943', '2026-03-13', '03-2026-02', 'นางสาวพีรยา  ตั้งคะวชิรานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '1720450684', 0.00, 0.00, 0.00, 0.00, 21600.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 148.00, 31600.00, 148.00, 31452.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (877, '1103900055090', '2026-03-13', '03-2026-02', 'นางสาวเมธาวีร์  วรวัฒนะกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636170638', 0.00, 0.00, 0.00, 0.00, 21600.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 148.00, 31600.00, 148.00, 31452.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (878, '1103900045078', '2026-03-13', '03-2026-02', 'นายปราณ  กำจัดภัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6636171146', 0.00, 0.00, 0.00, 0.00, 19800.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 837.00, 29800.00, 837.00, 28963.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (879, '1100702810123', '2026-03-13', '03-2026-02', 'นางสาวภณิพิมพ์  ฟองพิสุทธิกุล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083374926', 0.00, 0.00, 0.00, 0.00, 6275.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 16275.00, 0.00, 16275.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (880, '1103702540358', '2026-03-13', '03-2026-02', 'นางสาวอิงลดา  กิจพิมล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083375043', 0.00, 0.00, 0.00, 0.00, 3675.00, 0.00, 0.00, 0.00, 0.00, 10000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13675.00, 0.00, 13675.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (881, '1480400057942', '2026-03-13', '03-2026-02', 'นางสาวมณีรัตน์    ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839918931', 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3200.00, 0.00, 3200.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (882, '1479900342181', '2026-03-13', '03-2026-02', 'นางสาวมาลิน   บุพศิริ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9849629975', 0.00, 0.00, 0.00, 0.00, 540.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 540.00, 0.00, 540.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (883, '1103702648442', '2026-03-13', '03-2026-02', 'นางสาววลีรัตญา  นิลคง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786007341', 0.00, 0.00, 0.00, 0.00, 2380.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2380.00, 0.00, 2380.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (884, '1480400054901', '2026-03-13', '03-2026-02', 'นางสาวพัชรนันท์  ฤทธิเดช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884988', 0.00, 0.00, 0.00, 0.00, 740.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 740.00, 0.00, 740.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (885, '3480400064457', '2026-03-13', '03-2026-02', 'นางสาวสุภัสสร     อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6787450788', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (886, '1480400092802', '2026-03-13', '03-2026-02', 'นางสาวนงค์ลักษณ์  สะนาค', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885747', 0.00, 0.00, 0.00, 0.00, 740.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 740.00, 0.00, 740.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (887, '3340100617486', '2026-03-13', '03-2026-02', 'นางสาวพิมพา   คำก้อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080750579', 0.00, 0.00, 0.00, 0.00, 1110.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1110.00, 0.00, 1110.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (888, '3480700056841', '2026-03-13', '03-2026-02', 'นางฐิติวรดา     ใจช่วง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080074085', 0.00, 0.00, 0.00, 0.00, 5400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5400.00, 0.00, 5400.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (889, '1480500117050', '2026-03-13', '03-2026-02', 'นางจิราภรณ์    แสนคุณท้าว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919288', 0.00, 0.00, 0.00, 0.00, 7200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 7200.00, 0.00, 7200.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (890, '1489900240841', '2026-03-13', '03-2026-02', 'นางสาวสุรีรัตน์  สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6609137838', 0.00, 0.00, 0.00, 0.00, 4300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4300.00, 0.00, 4300.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (891, '3480400213720', '2026-03-13', '03-2026-02', 'นายจักรกฤษณ์ มานันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880370', 0.00, 0.00, 0.00, 0.00, 2590.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2590.00, 0.00, 2590.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (892, '1410100174064', '2026-03-13', '03-2026-02', 'นางสาวปนัดดา  มีจันที', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6612118393', 0.00, 0.00, 0.00, 0.00, 5160.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5160.00, 0.00, 5160.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (893, '3480400326117', '2026-03-13', '03-2026-02', 'นางสาวพิสมัย  ป้องหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884694', 0.00, 0.00, 0.00, 0.00, 2405.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2405.00, 0.00, 2405.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (894, '1480400104819', '2026-03-13', '03-2026-02', 'นายวุฒิพงษ์  ทวนกลาง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6786627277', 0.00, 0.00, 0.00, 0.00, 3145.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3145.00, 0.00, 3145.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (895, '3480400067006', '2026-03-13', '03-2026-02', 'นางสาวมลิวรรณ    อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080262078', 0.00, 0.00, 0.00, 0.00, 6840.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6840.00, 1000.00, 5840.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (896, '3480400075416', '2026-03-13', '03-2026-02', 'นางรังสิมา     สิถิระบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080212771', 0.00, 0.00, 0.00, 0.00, 1440.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1440.00, 0.00, 1440.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (897, '3480300702249', '2026-03-13', '03-2026-02', 'นางสุมาลี       อ้วนแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6625119628', 0.00, 0.00, 0.00, 0.00, 19800.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 25560.00, 0.00, 25560.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (898, '3480400305292', '2026-03-13', '03-2026-02', 'นางสาวสาธินี    บุรีวงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838844', 0.00, 0.00, 0.00, 0.00, 17640.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 23400.00, 1200.00, 22200.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (899, '3110400242277', '2026-03-13', '03-2026-02', 'นางสาวณิชกช    อาตวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081838887', 0.00, 0.00, 0.00, 0.00, 2160.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 807.00, 7920.00, 1207.00, 6713.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (900, '3480400378214', '2026-03-13', '03-2026-02', 'นางนวลนาง    ลวกุณ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080091702', 0.00, 0.00, 0.00, 0.00, 19440.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 25200.00, 500.00, 24700.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (901, '1480400010041', '2026-03-13', '03-2026-02', 'นางสาวจิราภรณ์    สุราสา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080751958', 0.00, 0.00, 0.00, 0.00, 8280.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 8280.00, 400.00, 7880.00, NULL, 'published', '2026-04-09 16:57:42', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (902, '3480400147069', '2026-03-13', '03-2026-02', 'นางสาวสุจิตรา   ขออาศัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081932913', 0.00, 0.00, 0.00, 0.00, 9720.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15480.00, 1000.00, 14480.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (903, '1430900202241', '2026-03-13', '03-2026-02', 'นางสาวมาฆศิริ  ศรีนาทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6794573709', 0.00, 0.00, 0.00, 0.00, 12240.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 18000.00, 500.00, 17500.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (904, '3480400233631', '2026-03-13', '03-2026-02', 'นางสาวจันทร์จิรา   กุณรักษ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879607', 0.00, 0.00, 0.00, 0.00, 740.00, 1320.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2060.00, 0.00, 2060.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (905, '3480400066395', '2026-03-13', '03-2026-02', 'นางพวงเพชร     สมเพราะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878740', 0.00, 0.00, 0.00, 0.00, 4440.00, 1920.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6360.00, 0.00, 6360.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (906, '3480400377358', '2026-03-13', '03-2026-02', 'นางทัศนา       ต้นสียา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879046', 0.00, 0.00, 0.00, 0.00, 4810.00, 1920.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6730.00, 0.00, 6730.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (907, '1480400056172', '2026-03-13', '03-2026-02', 'นางสาวนาตยา    สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083520272', 0.00, 0.00, 0.00, 0.00, 1480.00, 2040.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3520.00, 0.00, 3520.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (908, '1489900331481', '2026-03-13', '03-2026-02', 'นายกฤษณชัย  สมมะโน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882519', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (909, '1489700006951', '2026-03-13', '03-2026-02', 'นายธีรภัทร  จู่มา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885402', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (910, '1480700147653', '2026-03-13', '03-2026-02', 'นางสาวนันทิกา  ปัญญาพ่อ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6601886246', 0.00, 0.00, 0.00, 0.00, 1480.00, 1920.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3400.00, 0.00, 3400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (911, '1479300012279', '2026-03-13', '03-2026-02', 'นางสาวนลินี  ทนุพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4193527530', 0.00, 0.00, 0.00, 0.00, 8280.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15540.00, 0.00, 15540.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (912, '1570200063891', '2026-03-13', '03-2026-02', 'นางสาวรจนา  ผาแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882977', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (913, '1419902085479', '2026-03-13', '03-2026-02', 'นายโชคอนันต์  ภูมิประสาท', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180766507', 0.00, 0.00, 0.00, 0.00, 10080.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 5550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 21390.00, 0.00, 21390.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (914, '1480800137781', '2026-03-13', '03-2026-02', 'นายเอกสิทธิ์  เสนเพ็ง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6602667092', 0.00, 0.00, 0.00, 0.00, 10440.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 17700.00, 0.00, 17700.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (915, '3480300380837', '2026-03-13', '03-2026-02', 'นางศิตา    พลีจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136404', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (916, '3480400073324', '2026-03-13', '03-2026-02', 'นางยุพิน    นวานุช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080267827', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (917, '3480400366089', '2026-03-13', '03-2026-02', 'นายพลาธิป     บุญทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080136382', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (918, '1480400006272', '2026-03-13', '03-2026-02', 'นางสาวทิพารัตน์   เรือนทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080302711', 0.00, 0.00, 0.00, 0.00, 4070.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4070.00, 0.00, 4070.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (919, '1480400053602', '2026-03-13', '03-2026-02', 'นางสาวสุชาดา  เสนาราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6638944320', 0.00, 0.00, 0.00, 0.00, 1080.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3480.00, 0.00, 3480.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (920, '1480400117481', '2026-03-13', '03-2026-02', 'นางสาวณัฐกานต์ เวียงสิมา', 'พนักงานบริการ', 'กลุ่มงานบริการด้านปฐมภูมิและองค์รวม', 'ธนาคารกรุงไทย (KTB)', '4300813639', 0.00, 0.00, 0.00, 0.00, 4810.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4810.00, 0.00, 4810.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (921, '1480400061711', '2026-03-13', '03-2026-02', 'นางสาววลัยภรณ์  จองไว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4500592709', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (922, '3480400375312', '2026-03-13', '03-2026-02', 'นางสาววรรณวิมล  คำมุข', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081556881', 0.00, 0.00, 0.00, 0.00, 12600.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15000.00, 800.00, 14200.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (923, '3480400075424', '2026-03-13', '03-2026-02', 'นางประเดิม     อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080077963', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (924, '1480400105386', '2026-03-13', '03-2026-02', 'นายทิวัตถ์  ไชยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9848120068', 0.00, 0.00, 0.00, 0.00, 4320.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6720.00, 0.00, 6720.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (925, '1430300250490', '2026-03-13', '03-2026-02', 'นางสาวจุไรรัตน์  แก้วทอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300842388', 0.00, 0.00, 0.00, 0.00, 4320.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6720.00, 0.00, 6720.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (926, '3480800274581', '2026-03-13', '03-2026-02', 'นางสาวกนกวรรณ  สายบุญเลิศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6795475182', 0.00, 0.00, 0.00, 0.00, 1440.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3840.00, 0.00, 3840.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (927, '3480300684348', '2026-03-13', '03-2026-02', 'นางสาวดาวนภา     ศรีวรสาร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081685', 0.00, 0.00, 0.00, 0.00, 1620.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1620.00, 0.00, 1620.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (928, '3430900614251', '2026-03-13', '03-2026-02', 'นางเปรมฤดี     คำจันทร์ศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080089899', 0.00, 0.00, 0.00, 0.00, 2160.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2160.00, 0.00, 2160.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (929, '3480400267005', '2026-03-13', '03-2026-02', 'นางสาวภรภัค   เมืองซอง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081711585', 0.00, 0.00, 0.00, 0.00, 2160.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2160.00, 0.00, 2160.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (930, '3480400218985', '2026-03-13', '03-2026-02', 'นายจีรพันธ์    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885445', 0.00, 0.00, 0.00, 0.00, 2590.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2590.00, 0.00, 2590.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (931, '3480200024796', '2026-03-13', '03-2026-02', 'นางพัชราภรณ์     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080079834', 0.00, 0.00, 0.00, 0.00, 5760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5760.00, 0.00, 5760.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (932, '3480400008859', '2026-03-13', '03-2026-02', 'นางสาวอภิญญา    อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080470460', 0.00, 0.00, 0.00, 0.00, 1440.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 420.00, 6120.00, 720.00, 5400.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (933, '3480400377251', '2026-03-13', '03-2026-02', 'นางสาวสุกาญดา    ภาสอน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6735622928', 0.00, 0.00, 0.00, 0.00, 1440.00, 4320.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 300.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5760.00, 300.00, 5460.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (934, '1480400045774', '2026-03-13', '03-2026-02', 'นางสาวเพียงพิศ  สมรฤทธิ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080495552', 0.00, 0.00, 0.00, 0.00, 2880.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 7560.00, 0.00, 7560.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (935, '1489900121923', '2026-03-13', '03-2026-02', 'นางสาวสุทธิดา    สีหา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9850593229', 0.00, 0.00, 0.00, 0.00, 720.00, 3240.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 228.00, 3960.00, 228.00, 3732.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (936, '1480701245985', '2026-03-13', '03-2026-02', 'นางสาวมัยญรัตน์  อุดมทนานุกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210517771', 0.00, 0.00, 0.00, 0.00, 9860.00, 3780.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 268.00, 13640.00, 268.00, 13372.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (937, '3480400406986', '2026-03-13', '03-2026-02', 'นายไพ     มุมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881016', 0.00, 0.00, 0.00, 0.00, 1850.00, 2160.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4010.00, 0.00, 4010.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (938, '1480400002901', '2026-03-13', '03-2026-02', 'นายสมพงษ์  อุปเสน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881768', 0.00, 0.00, 0.00, 0.00, 1850.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1850.00, 0.00, 1850.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (939, '3480400416914', '2026-03-13', '03-2026-02', 'นายจันธิราช    ไชยภูวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882942', 0.00, 0.00, 0.00, 0.00, 4810.00, 1680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6490.00, 0.00, 6490.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (940, '1480400124127', '2026-03-13', '03-2026-02', 'นางสาวสาวิตรี  นาโสก', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6714577915', 0.00, 0.00, 0.00, 0.00, 14040.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 20220.00, 0.00, 20220.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (941, '1480400112030', '2026-03-13', '03-2026-02', 'นายอภิวัฒน์  บรรเทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6642143159', 0.00, 0.00, 0.00, 0.00, 2220.00, 2280.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4500.00, 0.00, 4500.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (942, '1480400100121', '2026-03-13', '03-2026-02', 'นางสาวสุคนธา  ถาปาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641882268', 0.00, 0.00, 0.00, 0.00, 370.00, 1440.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1810.00, 0.00, 1810.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (943, '1489900374996', '2026-03-13', '03-2026-02', 'นางสาวธัญนาฏ  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864111078', 0.00, 0.00, 0.00, 0.00, 11880.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 18060.00, 0.00, 18060.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (944, '3480400236754', '2026-03-13', '03-2026-02', 'นางสาวชุติกาญจน์  ก่ำเสริฐ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884155', 0.00, 0.00, 0.00, 0.00, 370.00, 1560.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1930.00, 0.00, 1930.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (945, '1480400047271', '2026-03-13', '03-2026-02', 'นางแสงระวี    หญ้างาม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641544559', 0.00, 0.00, 0.00, 0.00, 370.00, 1560.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1930.00, 0.00, 1930.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (946, '1480400098754', '2026-03-13', '03-2026-02', 'นางสาวชลิตา  สาสาย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080644280', 0.00, 0.00, 0.00, 0.00, 370.00, 1560.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1930.00, 0.00, 1930.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (947, '1480500116771', '2026-03-13', '03-2026-02', 'นางสาวกมลชนก  อุ่นชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839919687', 0.00, 0.00, 0.00, 0.00, 8640.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13320.00, 0.00, 13320.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (948, '1407500024350', '2026-03-13', '03-2026-02', 'นางสาวพรนัชชา  ชาวยศ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6617840127', 0.00, 0.00, 0.00, 0.00, 8120.00, 3780.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11900.00, 0.00, 11900.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (949, '1480400084516', '2026-03-13', '03-2026-02', 'นางสาวสุธีธิดา  เสียงล้ำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9846118155', 0.00, 0.00, 0.00, 0.00, 7920.00, 5040.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 12960.00, 0.00, 12960.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (950, '1340400229035', '2026-03-13', '03-2026-02', 'นางสาวช่อผกา  ตั้งจรูญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9861455701', 0.00, 0.00, 0.00, 0.00, 7920.00, 3960.00, 0.00, 0.00, 0.00, 0.00, 5550.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 17430.00, 0.00, 17430.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (951, '1421300016803', '2026-03-13', '03-2026-02', 'นายพลวัตร  นิลตานนท์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6605595130', 0.00, 0.00, 0.00, 0.00, 9360.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15540.00, 0.00, 15540.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (952, '1410800101752', '2026-03-13', '03-2026-02', 'นายหัถชัย  หัสเตชะ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6777412689', 0.00, 0.00, 0.00, 0.00, 9360.00, 4680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 14040.00, 0.00, 14040.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (953, '1480400055656', '2026-03-13', '03-2026-02', 'นายยศดนัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646281599', 0.00, 0.00, 0.00, 0.00, 2220.00, 2040.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4260.00, 0.00, 4260.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (954, '1489700029276', '2026-03-13', '03-2026-02', 'นายเอกพร  เจริญผล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629182618', 0.00, 0.00, 0.00, 0.00, 2960.00, 2280.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5240.00, 0.00, 5240.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (955, '1489700005504', '2026-03-13', '03-2026-02', 'น.ส.ธนัญญา  พยุงวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6798226426', 0.00, 0.00, 0.00, 0.00, 370.00, 1560.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1930.00, 0.00, 1930.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (956, '1431100024659', '2026-03-13', '03-2026-02', 'นายเสกสรร  คะสาน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6647039503', 0.00, 0.00, 0.00, 0.00, 2590.00, 2280.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4870.00, 0.00, 4870.00, NULL, 'published', '2026-04-09 16:57:43', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (957, '3480800396724', '2026-03-13', '03-2026-02', 'นางสันสนี     ใหม่วงค์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080078218', 0.00, 0.00, 0.00, 0.00, 360.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 360.00, 0.00, 360.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (958, '3460300724170', '2026-03-13', '03-2026-02', 'นางพัชรินทร์   ทันจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6623088733', 0.00, 0.00, 0.00, 0.00, 1110.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1110.00, 0.00, 1110.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (959, '5480300007814', '2026-03-13', '03-2026-02', 'นางสาวนุชจรี     บุตรบุรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080081707', 0.00, 0.00, 0.00, 0.00, 5040.00, 6120.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11160.00, 1200.00, 9960.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (960, '1480400051120', '2026-03-13', '03-2026-02', 'นงสาวภัคศรัณย์  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6629701402', 0.00, 0.00, 0.00, 0.00, 8640.00, 7200.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 15840.00, 0.00, 15840.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (961, '2480400001392', '2026-03-13', '03-2026-02', 'นางปราณี     ศิลป์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892042', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (962, '3480400408903', '2026-03-13', '03-2026-02', 'นางสาวฐิรพร    ธรรมจันทร์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641880885', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (963, '1209702023722', '2026-03-13', '03-2026-02', 'นายธนเดช  นิยมกูล', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883566', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (964, '1489700006314', '2026-03-13', '03-2026-02', 'นางสาวรัชฎาวรรณ  ผาลี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648155876', 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1480.00, 0.00, 1480.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (965, '3480300749725', '2026-03-13', '03-2026-02', 'นางธนพร  วรรณแสง', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879925', 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 2960.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (966, '1480400086233', '2026-03-13', '03-2026-02', 'นางสาวอินธุอร   ศรีนันทา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883159', 0.00, 0.00, 0.00, 0.00, 630.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 630.00, 0.00, 630.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (967, '3480400226503', '2026-03-13', '03-2026-02', 'นางสาวศศิธร  สุวารีย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886964', 0.00, 0.00, 0.00, 0.00, 3700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3700.00, 0.00, 3700.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (968, '1480700110563', '2026-03-13', '03-2026-02', 'นางสาวลดาวัลย์  ไตยราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884007', 0.00, 0.00, 0.00, 0.00, 5400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 275.00, 5400.00, 275.00, 5125.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (969, '1470800221634', '2026-03-13', '03-2026-02', 'นางสาววิสุดา   บาลจบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886549', 0.00, 0.00, 0.00, 0.00, 3552.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 204.00, 3552.50, 204.00, 3348.50, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (970, '1480800159238', '2026-03-13', '03-2026-02', 'นางสาวพรธิตา  ศิริวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9864992031', 0.00, 0.00, 0.00, 0.00, 4410.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4410.00, 0.00, 4410.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (971, '1489900398356', '2026-03-13', '03-2026-02', 'นายภูริภัทร์  หวายสุด', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083341262', 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 2960.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (972, '1480500097351', '2026-03-13', '03-2026-02', 'นางสาวเพ็ญพร   เอกจักรแก้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4210218235', 0.00, 0.00, 0.00, 0.00, 10440.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 992.00, 10440.00, 992.00, 9448.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (973, '1480400096352', '2026-03-13', '03-2026-02', 'นางสาวพิมศิริ  เกษบัว', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641881962', 0.00, 0.00, 0.00, 0.00, 3700.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3700.00, 0.00, 3700.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (974, '1479900472513', '2026-03-13', '03-2026-02', 'นายกิตติคุณ  มัยวงศ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838933570', 0.00, 0.00, 0.00, 0.00, 14760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 14760.00, 0.00, 14760.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (975, '1103700452320', '2026-03-13', '03-2026-02', 'นางธัญญาลักษณ์  ประยูรเสาวภาคย์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4400361837', 0.00, 0.00, 0.00, 0.00, 6670.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6670.00, 0.00, 6670.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (976, '1481100027500', '2026-03-13', '03-2026-02', 'นางสาวรมิดา  วงษา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '8283268465', 0.00, 0.00, 0.00, 0.00, 16920.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 16920.00, 0.00, 16920.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (977, '3480300048174', '2026-03-13', '03-2026-02', 'นายวิทวัส     ศรีเพชร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4081948976', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (978, '1481000066902', '2026-03-13', '03-2026-02', 'นางสาวสุชาดา   ราชมณี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080508824', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (979, '1489900374651', '2026-03-13', '03-2026-02', 'นางสาวอริญา  ท่าทม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9862817542', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2400.00, 0.00, 2400.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (980, '1350300094855', '2026-03-13', '03-2026-02', 'นางสาวสุภัสสร   วรรณอ่อน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9839067494', 0.00, 0.00, 0.00, 0.00, 4140.00, 0.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6140.00, 0.00, 6140.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (981, '1489700000430', '2026-03-13', '03-2026-02', 'นางสาวจิราพัชร  เขียวคำ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6632605222', 0.00, 0.00, 0.00, 0.00, 2312.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2312.50, 0.00, 2312.50, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (982, '1471300089860', '2026-03-13', '03-2026-02', 'นางสาวเกวรินทร์  โตมาซา', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6645738447', 0.00, 0.00, 0.00, 0.00, 4680.00, 0.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6680.00, 0.00, 6680.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (983, '1509966081571', '2026-03-13', '03-2026-02', 'นายภัทรเชษฐ  รุ่งโรจน์วัฒศิริ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '2613367687', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3000.00, 0.00, 3000.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (984, '3480200214056', '2026-03-13', '03-2026-02', 'นางสาวกวินารัตน์     คำศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4080160356', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1800.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1800.00, 0.00, 1800.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (985, '1419901775099', '2026-03-13', '03-2026-02', 'นางสาวอาทิตยา  โคตรสมบัติ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4083382376', 0.00, 0.00, 0.00, 0.00, 7560.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 300.00, 9960.00, 300.00, 9660.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (986, '1430500375610', '2026-03-13', '03-2026-02', 'นางสาวกรวิภา วงษ์ชัย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6600044357', 0.00, 0.00, 0.00, 0.00, 5760.00, 0.00, 2400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 8160.00, 0.00, 8160.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (987, '1489700006624', '2026-03-13', '03-2026-02', 'นางสาวอริศรา  อุดมกัน', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6628404714', 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2960.00, 0.00, 2960.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (988, '3480400055164', '2026-03-13', '03-2026-02', 'นางเอื้อมพร  สุวรรณใจ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6646540748', 0.00, 0.00, 0.00, 0.00, 2775.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2775.00, 0.00, 2775.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (989, '3480400074142', '2026-03-13', '03-2026-02', 'นายปริญญา    อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641883310', 0.00, 0.00, 0.00, 0.00, 6290.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6290.00, 0.00, 6290.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (990, '3480400073278', '2026-03-13', '03-2026-02', 'นายณัฐภัทร  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879275', 0.00, 0.00, 0.00, 0.00, 6290.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6290.00, 0.00, 6290.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (991, '1410401515481', '2026-03-13', '03-2026-02', 'นายวิศวะ  ศรีวงษราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4180905981', 0.00, 0.00, 0.00, 0.00, 18000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 18000.00, 0.00, 18000.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (992, '1480400095755', '2026-03-13', '03-2026-02', 'นายฤทธิพงษ์  บุญศรี', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '9838489522', 0.00, 0.00, 0.00, 0.00, 4810.00, 1680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 6490.00, 0.00, 6490.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (993, '1480400049761', '2026-03-13', '03-2026-02', 'นายวีระชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641892840', 0.00, 0.00, 0.00, 0.00, 4070.00, 1680.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5750.00, 0.00, 5750.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (994, '3480400065691', '2026-03-13', '03-2026-02', 'นายอิทธิพล    ภาโสม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641879666', 0.00, 0.00, 0.00, 0.00, 9805.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 9805.00, 0.00, 9805.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (995, '1459900068054', '2026-03-13', '03-2026-02', 'นายอนันต์   สีหาบุตร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641936333', 0.00, 0.00, 0.00, 0.00, 10360.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10360.00, 0.00, 10360.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (996, '3480200314247', '2026-03-13', '03-2026-02', 'นายขวัญชัย  คุยพร', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641708675', 0.00, 0.00, 0.00, 0.00, 9805.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 244.00, 9805.00, 244.00, 9561.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (997, '1480400109284', '2026-03-13', '03-2026-02', 'นายทวีวัฒน์  สุพรรณ์', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878066', 0.00, 0.00, 0.00, 0.00, 10915.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10915.00, 0.00, 10915.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (998, '1489900165777', '2026-03-13', '03-2026-02', 'นายธวัชชัย  พรมราช', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641878678', 0.00, 0.00, 0.00, 0.00, 11470.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 11470.00, 0.00, 11470.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (999, '3480400073154', '2026-03-13', '03-2026-02', 'นายสาโรช  สมเทพ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6648907436', 0.00, 0.00, 0.00, 0.00, 10730.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10730.00, 0.00, 10730.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1000, '1480400116612', '2026-03-13', '03-2026-02', 'นางสาวนิตยา  ศรีลาคม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '4300986185', 0.00, 0.00, 0.00, 0.00, 1387.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1387.50, 0.00, 1387.50, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1001, '3430900615584', '2026-03-13', '03-2026-02', 'นางวิลาวัลย์  พรหมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885895', 0.00, 0.00, 0.00, 0.00, 462.50, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 462.50, 0.00, 462.50, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1002, '1480100127210', '2026-03-13', '03-2026-02', 'นางสาวมนัสนันท์  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886050', 0.00, 0.00, 0.00, 0.00, 925.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 925.00, 0.00, 925.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1003, '1301502002332', '2026-03-13', '03-2026-02', 'นายจิรายุส ครุฑใจกล้า', 'นักจัดการทั่วไป', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '9848532757', 0.00, 0.00, 0.00, 0.00, 250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 250.00, 0.00, 250.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1004, '3439900079192', '2026-03-13', '03-2026-02', 'นางสาวรัชดา บุตรวงค์', 'เจ้าพนักงานธุรการ', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4080136374', 0.00, 0.00, 0.00, 0.00, 2760.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 0.00, 0.00, 0.00, 0.00, 0.00, 236.00, 2760.00, 736.00, 2024.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1005, '1480800044627', '2026-03-13', '03-2026-02', 'นางสาวจินตหรา นิมิตร', 'เจ้าพนักงานการเงินและบัญชี', 'งานการเงินและบัญชี', 'ธนาคารกรุงไทย (KTB)', '9850226463', 0.00, 0.00, 0.00, 0.00, 2250.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 316.00, 2250.00, 316.00, 1934.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1006, '1470100279273', '2026-03-13', '03-2026-02', 'นายมงคล โพธิ์นะ', 'นักวิชาการเงินและบัญชี', 'กลุ่มงานบริหารทั่วไป', 'ธนาคารกรุงไทย (KTB)', '4083227877', 0.00, 0.00, 0.00, 0.00, 3040.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 212.00, 3040.00, 212.00, 2828.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1007, '3540400307766', '2026-03-13', '03-2026-02', 'นางสาวกัณณิกา  ช้างมูบ', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641886409', 0.00, 0.00, 0.00, 0.00, 2000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2000.00, 0.00, 2000.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1008, '1480400035213', '2026-03-13', '03-2026-02', 'นายสุวัฒน์ชัย  อภัยโส', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641884724', 0.00, 0.00, 0.00, 0.00, 3120.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3120.00, 0.00, 3120.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1009, '1480400040438', '2026-03-13', '03-2026-02', 'นายวีรพล  เสนจันทร์ฒิไชย', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6641885186', 0.00, 0.00, 0.00, 0.00, 3120.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3120.00, 0.00, 3120.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1010, '1480400046941', '2026-03-13', '03-2026-02', 'นายพงศธร  พรหมจอม', 'ไม่ระบุ', 'ไม่ระบุ', 'ธนาคารกรุงไทย (KTB)', '6643378699', 0.00, 0.00, 0.00, 0.00, 1020.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1020.00, 0.00, 1020.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1011, '1250100358515', '2026-03-13', '03-2026-02', 'นางสาวกนิษฐา วงษ์หอย', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4780601371', 0.00, 0.00, 0.00, 0.00, 9000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 9000.00, 0.00, 9000.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1012, '1480800122181', '2026-03-13', '03-2026-02', 'นายจักรพงศ์ ทิพยศรี', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '4083108983', 0.00, 0.00, 0.00, 0.00, 5400.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5400.00, 0.00, 5400.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');
INSERT INTO `salary_slips` VALUES (1013, '1480400109152', '2026-03-13', '03-2026-02', 'นายธนากร พรหมจอม', 'นักวิชาการคอมพิวเตอร์', 'กลุ่มงานสุขภาพดิจิทัล', 'ธนาคารกรุงไทย (KTB)', '6647047018', 0.00, 0.00, 0.00, 0.00, 900.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 900.00, 0.00, 900.00, NULL, 'published', '2026-04-09 16:57:44', '2026-04-09 16:57:52');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('45qRM2fjJD1fTCYjpb0n4foBSSo7Xe3ZlOWAlsa0', 8, '10.10.10.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoibEVHRE1PcnFJbVRuOWhJSFIydlNjQlRDeGFZTThYOTg0TEJTcUJjVCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTkyLjE2OC42MC4yMDcvYnAtd2ViYXBwL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MTp7aTowO3M6MTM6InN1Y2Nlc3NfbG9naW4iO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjg7czoxMzoic3VjY2Vzc19sb2dpbiI7czo1MToi4LmA4LiC4LmJ4Liy4Liq4Li54LmI4Lij4Liw4Lia4Lia4Liq4Liz4LmA4Lij4LmH4LiIIjt9', 1776839855);
INSERT INTO `sessions` VALUES ('9HRyRB6xWzygCs46VVMq8tXPI3ugL2939tFEXiml', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWTREOUhnVElDbWZXR1JoOHI5YTM3VzdmZ0c5SGg2N2ZxV2UzUW15UyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kb3JtaXRvcnkvYWRtaW4vcmVzaWRlbnRzIjtzOjU6InJvdXRlIjtzOjMxOiJkb3JtaXRvcnkuYWRtaW4ucmVzaWRlbnRzLmluZGV4Ijt9czoxMjoibGluZV9wcm9maWxlIjthOjQ6e3M6MTI6ImxpbmVfdXNlcl9pZCI7czozMzoiVTM1MDIwNTFhNjIyNWU5NjJhNTg0N2E2MzFjOTRkY2ZhIjtzOjE3OiJsaW5lX2Rpc3BsYXlfbmFtZSI7czoxMDoiQm9zcy0xMTEwNiI7czoxNjoibGluZV9waWN0dXJlX3VybCI7czoxMzQ6Imh0dHBzOi8vcHJvZmlsZS5saW5lLXNjZG4ubmV0LzBod1hrUkpqUlRLSGRHS3pvTDdiaFdDRFo3S3gxbFduRmxiMDR3RTNvcEpoZHpUMllrT2gwMEZYcC1ma1I1VG1ZbFAwUm1HQ1lzZHhSS09GOFJXSDNVUTBFYmRVWjZFMlloWTBSdm1RIjtzOjEyOiJsaW5lX3Byb2ZpbGUiO2E6NDp7czo2OiJ1c2VySWQiO3M6MzM6IlUzNTAyMDUxYTYyMjVlOTYyYTU4NDdhNjMxYzk0ZGNmYSI7czoxMToiZGlzcGxheU5hbWUiO3M6MTA6IkJvc3MtMTExMDYiO3M6MTM6InN0YXR1c01lc3NhZ2UiO3M6MTA6IjA5ODYyMTgwNjMiO3M6MTA6InBpY3R1cmVVcmwiO3M6MTM0OiJodHRwczovL3Byb2ZpbGUubGluZS1zY2RuLm5ldC8waHdYa1JKalJUS0hkR0t6b0w3YmhXQ0RaN0t4MWxXbkZsYjA0d0Uzb3BKaGR6VDJZa09oMDBGWHAtZmtSNVRtWWxQMFJtR0NZc2R4UktPRjhSV0gzVVEwRWJkVVo2RTJZaFkwUnZtUSI7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1776846070);
INSERT INTO `sessions` VALUES ('rz3riTkKS4BoMCHUPDrpFJr9lzXBaixR8OIY1ig1', 7, '10.10.10.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidFhXZFI5NHFMRGFESkwxZlduSkJ6MUlCMnJuc1JnNThqZU9VdUpNWiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NztzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0NzoiaHR0cDovLzE5Mi4xNjguNjAuMjA3L2JwLXdlYmFwcC9zc28vdGlja2V0L2luZm8iO3M6NToicm91dGUiO3M6MTA6InNzby50aWNrZXQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1776848764);
INSERT INTO `sessions` VALUES ('Xz2s2sghvttJQgHXLQxLbFLgjmI6Cd7ivLRI152s', 8, '10.10.10.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoibFo2cmJHeHF5ejNxa2Z1OENjSXBIQUdEY2Y1TmozY3FVSllBTHpHNCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjQ3OiJodHRwOi8vMTkyLjE2OC42MC4yMDcvYnAtd2ViYXBwL3Nzby90aWNrZXQvaW5mbyI7czo1OiJyb3V0ZSI7czoxMDoic3NvLnRpY2tldCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjg7fQ==', 1776839857);

-- ----------------------------
-- Table structure for software_categories
-- ----------------------------
DROP TABLE IF EXISTS `software_categories`;
CREATE TABLE `software_categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of software_categories
-- ----------------------------
INSERT INTO `software_categories` VALUES (2, 'HIS', 'ระบบบริหารจัดการโรงพยาบาล', '2026-03-05 09:28:33', '2026-03-05 09:28:52');
INSERT INTO `software_categories` VALUES (4, 'Website', NULL, '2026-03-11 09:19:13', '2026-03-11 09:19:13');
INSERT INTO `software_categories` VALUES (5, 'X-RAY', NULL, '2026-03-11 09:30:10', '2026-03-11 09:30:10');
INSERT INTO `software_categories` VALUES (6, 'Network', NULL, '2026-03-19 16:45:49', '2026-03-19 16:45:49');

-- ----------------------------
-- Table structure for software_installations
-- ----------------------------
DROP TABLE IF EXISTS `software_installations`;
CREATE TABLE `software_installations`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `software_id` bigint UNSIGNED NOT NULL,
  `license_id` bigint UNSIGNED NULL DEFAULT NULL,
  `department_id` bigint UNSIGNED NULL DEFAULT NULL,
  `personel_id` bigint UNSIGNED NULL DEFAULT NULL,
  `computer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `install_date` date NOT NULL,
  `status` enum('Installed','Uninstalled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Installed',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `installed_by` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `software_installations_software_id_foreign`(`software_id` ASC) USING BTREE,
  INDEX `software_installations_license_id_foreign`(`license_id` ASC) USING BTREE,
  INDEX `software_installations_department_id_foreign`(`department_id` ASC) USING BTREE,
  INDEX `software_installations_personel_id_foreign`(`personel_id` ASC) USING BTREE,
  INDEX `software_installations_installed_by_foreign`(`installed_by` ASC) USING BTREE,
  CONSTRAINT `software_installations_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `software_installations_installed_by_foreign` FOREIGN KEY (`installed_by`) REFERENCES `personel` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `software_installations_license_id_foreign` FOREIGN KEY (`license_id`) REFERENCES `software_licenses` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `software_installations_personel_id_foreign` FOREIGN KEY (`personel_id`) REFERENCES `personel` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `software_installations_software_id_foreign` FOREIGN KEY (`software_id`) REFERENCES `softwares` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of software_installations
-- ----------------------------
INSERT INTO `software_installations` VALUES (4, 15, 7, NULL, NULL, 'BOSS-PC', NULL, '2026-01-01', 'Installed', NULL, 1, '2026-03-30 10:10:10', '2026-03-30 10:10:10');
INSERT INTO `software_installations` VALUES (5, 15, 7, NULL, NULL, 'Dent01', NULL, '2026-01-08', 'Installed', NULL, 1, '2026-03-30 10:10:40', '2026-03-30 10:11:20');
INSERT INTO `software_installations` VALUES (6, 15, 7, NULL, NULL, 'Dent02', NULL, '2026-01-02', 'Installed', NULL, 1, '2026-03-30 10:11:03', '2026-03-30 10:11:16');
INSERT INTO `software_installations` VALUES (7, 15, 7, NULL, NULL, 'Doctor_NCD_1', NULL, '2026-01-08', 'Installed', NULL, 1, '2026-03-30 10:11:53', '2026-03-30 10:12:01');
INSERT INTO `software_installations` VALUES (8, 15, 7, NULL, NULL, 'ham', NULL, '2026-01-08', 'Installed', NULL, 1, '2026-03-30 10:12:17', '2026-03-30 10:12:17');

-- ----------------------------
-- Table structure for software_licenses
-- ----------------------------
DROP TABLE IF EXISTS `software_licenses`;
CREATE TABLE `software_licenses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `software_id` bigint UNSIGNED NOT NULL,
  `license_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `license_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `total_seats` int NOT NULL DEFAULT 1,
  `purchase_date` date NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `po_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `supplier_contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `software_licenses_software_id_foreign`(`software_id` ASC) USING BTREE,
  CONSTRAINT `software_licenses_software_id_foreign` FOREIGN KEY (`software_id`) REFERENCES `softwares` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of software_licenses
-- ----------------------------
INSERT INTO `software_licenses` VALUES (4, 6, 'Site License (เหมาจ่าย)', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-11 09:20:59', '2026-03-11 09:28:09');
INSERT INTO `software_licenses` VALUES (5, 7, 'Site License (เหมาจ่าย)', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-11 09:27:56', '2026-03-11 09:27:56');
INSERT INTO `software_licenses` VALUES (6, 13, 'Site License (เหมาจ่าย)', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-11 09:34:21', '2026-03-11 09:34:21');
INSERT INTO `software_licenses` VALUES (7, 15, 'Site License (เหมาจ่าย)', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-30 10:07:57', '2026-03-30 10:07:57');

-- ----------------------------
-- Table structure for softwares
-- ----------------------------
DROP TABLE IF EXISTS `softwares`;
CREATE TABLE `softwares`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `vendor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `software_type` enum('Freeware','Open Source','Commercial','In-House') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Freeware',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `softwares_category_id_foreign`(`category_id` ASC) USING BTREE,
  CONSTRAINT `softwares_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `software_categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of softwares
-- ----------------------------
INSERT INTO `softwares` VALUES (5, 2, 'HOSXP', 'V.3', 'BMS', 'Commercial', 'ระบบบริหารจัดการสำหรับโรงพยาบาล Username : bph11106 / Pass : bph11106@', 1, '2026-03-05 21:28:43', '2026-03-05 21:28:43');
INSERT INTO `softwares` VALUES (6, 2, 'KPHIS IPD Peperless', NULL, NULL, 'Open Source', 'ระบบบริหารจัดการ IPD', 1, '2026-03-11 09:20:38', '2026-03-11 09:26:39');
INSERT INTO `softwares` VALUES (7, 4, 'ระบบติดตาม Chart IPD', NULL, 'รพ.ศรีสงคราม', 'Commercial', 'ระบบติดตามชาร์ทผู้ป่วยใน', 1, '2026-03-11 09:27:34', '2026-03-11 09:27:34');
INSERT INTO `softwares` VALUES (8, 4, 'ระบบสแกนชาร์ทผู้ป่วยนอก', 'V.2', NULL, 'Commercial', 'ระบบสแกนชาร์ทผู้ป่วยนอก', 1, '2026-03-11 09:29:14', '2026-03-11 09:29:14');
INSERT INTO `softwares` VALUES (9, 4, 'ระบบสแกนชาร์ทผู้ป่วยใน', 'V.2', NULL, 'Commercial', NULL, 1, '2026-03-11 09:29:30', '2026-03-11 09:29:30');
INSERT INTO `softwares` VALUES (10, 5, 'PAC', NULL, NULL, 'Commercial', 'ดูฟิล์ม Xray', 1, '2026-03-11 09:31:03', '2026-03-11 09:31:03');
INSERT INTO `softwares` VALUES (11, 4, 'ระบบติดตามทวงหนี้', NULL, 'รพ.ศรีสงคราม', 'Open Source', 'ติดตามทวงหนี้คนไข้', 1, '2026-03-11 09:32:03', '2026-03-11 09:32:03');
INSERT INTO `softwares` VALUES (12, 4, 'ระบบแจ้งซ่อมคอมพิวเตอร์', NULL, 'แก้ว IT', 'Commercial', NULL, 1, '2026-03-11 09:32:46', '2026-03-11 09:32:46');
INSERT INTO `softwares` VALUES (13, 4, 'ระบบสารบรรณอิเล็กทรอนิกส์', NULL, 'บอส IT', 'In-House', 'ระบบบริหารจัดการหนังสือสารบรรณ', 1, '2026-03-11 09:34:05', '2026-03-11 09:34:05');
INSERT INTO `softwares` VALUES (14, 4, 'ระบบขอรายงานสารสนเทศ', NULL, 'IT', 'In-House', NULL, 1, '2026-03-11 09:35:06', '2026-03-11 09:35:06');
INSERT INTO `softwares` VALUES (15, 4, 'Dashboard รพ.บ้านแพง', NULL, 'บอส IT', 'In-House', NULL, 1, '2026-03-11 09:35:38', '2026-03-11 09:35:38');
INSERT INTO `softwares` VALUES (16, 6, 'Licenes Firewall', NULL, NULL, 'Commercial', NULL, 1, '2026-03-19 16:46:47', '2026-03-19 16:46:47');

-- ----------------------------
-- Table structure for sso_tokens
-- ----------------------------
DROP TABLE IF EXISTS `sso_tokens`;
CREATE TABLE `sso_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL COMMENT 'ไอดีพนักงาน',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสตั๋วแบบสุ่ม',
  `target_system` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ระบบปลายทาง เช่น kpi, cqi',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'เวลาที่ตั๋วหมดอายุ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sso_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `sso_tokens_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `sso_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `personel` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 334 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sso_tokens
-- ----------------------------
INSERT INTO `sso_tokens` VALUES (1, 1, 'KDPC0jtuhv5FGwZAdDWU2YtfPyEX2QIj61srYaaFRPWTBJLIXxSKmti1UyTahhja', 'kpi', '2026-03-02 12:07:51', '2026-03-02 12:06:52', '2026-03-02 12:06:52');
INSERT INTO `sso_tokens` VALUES (2, 1, 'aXNfNShothzlPjkYgp0tjxGoU8Rqer04UZcq1AL9hF4jPZdcKXCjDH1P4wAe1hPp', 'kpi', '2026-03-02 13:01:06', '2026-03-02 13:00:06', '2026-03-02 13:00:06');
INSERT INTO `sso_tokens` VALUES (5, 1, 'qY7dZc1ye6SOmd4fGyxYgtE4nvYjf41Pam1nxWUDcWqDv1peqgVZa4O47hQPfyzw', 'cqi', '2026-03-02 13:10:15', '2026-03-02 13:09:15', '2026-03-02 13:09:15');
INSERT INTO `sso_tokens` VALUES (12, 1, 'aPlVM2R0huWskfYFLw5WWHUir5u59C8F56HL6CrNf8hjNnt867ei9Wpaezh7VY1k', 'cqi', '2026-03-05 10:20:20', '2026-03-05 10:19:20', '2026-03-05 10:19:20');
INSERT INTO `sso_tokens` VALUES (13, 1, 'bMvGjsnrxCgiOSyzcExA5WFAhimjSSEHF9iyGiwHCaDxRDyZMtAjw4ASYeqziLFg', 'kpi', '2026-03-05 16:30:01', '2026-03-05 16:29:01', '2026-03-05 16:29:01');
INSERT INTO `sso_tokens` VALUES (14, 1, 'cNCkBD6ERrYu2tTLdC7VFrsPq8GZ9r7Pjh0KdkCccLI4KHQdmgL4WvxHYh8qCANK', 'kpi', '2026-03-05 19:08:43', '2026-03-05 19:07:43', '2026-03-05 19:07:43');
INSERT INTO `sso_tokens` VALUES (15, 1, 'bSuPpaUSASGUymXlzboBPGPqjQ1ijYf0hKTshxwYCol9Ixw1SvwwjJ0pMh0z4CfA', 'cqi', '2026-03-05 19:12:49', '2026-03-05 19:11:49', '2026-03-05 19:11:49');
INSERT INTO `sso_tokens` VALUES (17, 1, 'ObGdp4asGLFWa8XVMCpm2Sfq1i1fvrNnTXu9Z5X0h1jdVIgcMWshwBPeDsiO3f2I', 'kpi', '2026-03-05 19:21:31', '2026-03-05 19:20:31', '2026-03-05 19:20:31');
INSERT INTO `sso_tokens` VALUES (18, 1, 'ZfLHAwoAJqpdxDCUYZVMtlsfnU5bQSWnHcMLkNOgyyj6gGvltaCHqVrOt06lcvnF', 'kpi', '2026-03-05 20:00:48', '2026-03-05 19:59:48', '2026-03-05 19:59:48');
INSERT INTO `sso_tokens` VALUES (19, 1, 'ooKewPgTuUUQJYj7i0vxy9S3tcXpQMqZEl3otYQFKhdtGLg9HIE8ZCojMOQakcQC', 'kpi', '2026-03-05 20:01:11', '2026-03-05 20:00:11', '2026-03-05 20:00:11');
INSERT INTO `sso_tokens` VALUES (20, 1, 'bs6ehq6FplhwXJLTWg0rowA8Ro2gMzxsRtsvndn1BSwMjOUIllM9LKNIT2km9RCQ', 'cqi', '2026-03-05 20:03:20', '2026-03-05 20:02:20', '2026-03-05 20:02:20');
INSERT INTO `sso_tokens` VALUES (21, 1, '6OH1olq4bo7XNXVibgpfOYrSxm1X4WGrXqvwRUcoG4l62f4S6LDVM2YfWgjgEQxf', 'cqi', '2026-03-05 20:07:12', '2026-03-05 20:06:12', '2026-03-05 20:06:12');
INSERT INTO `sso_tokens` VALUES (22, 1, 'HOZuHRFDRE3spb6RwMcq408XkXGeAdjtXm52Twg6mnYyRhhgvQ2icJbb9AEivwJ9', 'cqi', '2026-03-05 20:07:46', '2026-03-05 20:06:46', '2026-03-05 20:06:46');
INSERT INTO `sso_tokens` VALUES (23, 1, 'xCTy7HfO524GvvkxpjLczCikLAL2dYasDTnO0S0677j8LIxk3ktG8Cg3pujdis3j', 'cqi', '2026-03-05 20:11:38', '2026-03-05 20:10:38', '2026-03-05 20:10:38');
INSERT INTO `sso_tokens` VALUES (26, 1, 'V108BSvoWVuc43TniVZy6AMwPWG9WCFpQKcdGPipTkOiIJstNpE8I1y7PW28Xvqt', 'kpi', '2026-03-05 21:14:40', '2026-03-05 21:13:40', '2026-03-05 21:13:40');
INSERT INTO `sso_tokens` VALUES (27, 1, 'Jqr3rUiNQzmtNzsOyMtBj8cnl5KFBuBDVKWyMi8FJtUv7wIwO6idVWBFFbwDOhPU', 'kpi', '2026-03-05 21:21:05', '2026-03-05 21:20:05', '2026-03-05 21:20:05');
INSERT INTO `sso_tokens` VALUES (28, 1, 'xUieZxTkVjmYHIQ5QYOPxzJSxbZnA0gdVmmUWj5SYVwjMjOsmbGUcAMMd3CoRJVz', 'kpi', '2026-03-05 21:21:53', '2026-03-05 21:20:53', '2026-03-05 21:20:53');
INSERT INTO `sso_tokens` VALUES (118, 7, 'ol9k9rMbdjOD0uuVUC7Tc1G7amk3KOLdgzLcNGaRL9oGq5wEqndnhqsmmnKnGkSh', 'info', '2026-03-16 13:04:39', '2026-03-16 13:03:39', '2026-03-16 13:03:39');
INSERT INTO `sso_tokens` VALUES (171, 8, 'fUVRMwQ9btgqdU8N3OoXuL1NnlbVEzCdf8rpjzWB6AlZGWfGU7hB2jE2kwuOSrjf', 'info', '2026-03-24 08:45:22', '2026-03-24 08:44:22', '2026-03-24 08:44:22');
INSERT INTO `sso_tokens` VALUES (200, 7, 'gHlJLG77twgV3YlFcQlETqJ8BDhIKrCExjzsGDayPBNpTEn9Xhe3S90atk79Bwro', 'info', '2026-03-30 12:09:07', '2026-03-30 12:08:07', '2026-03-30 12:08:07');
INSERT INTO `sso_tokens` VALUES (238, 7, 'EywUKzjUx04xdS9rCrj0V8a1asxxIeOGOnTHy9HCWJs26qykO0p2SJEf6BVSRKv4', 'info', '2026-04-03 15:14:59', '2026-04-03 15:13:59', '2026-04-03 15:13:59');
INSERT INTO `sso_tokens` VALUES (240, 8, 'DbrJ0tMYUCDlgnv6W78qfmqEj4LPPJyOzhVSnyI9FNiCLfzB9GIMnvZuFAEQdr0I', 'info', '2026-04-03 15:20:12', '2026-04-03 15:19:12', '2026-04-03 15:19:12');
INSERT INTO `sso_tokens` VALUES (288, 7, '4f4TGfapqfFzGymxW0VYAP6E9UrdRu9MgWfM62xQwg3fZPn57WZuQSskQcCIHZBa', 'info', '2026-04-16 10:56:48', '2026-04-16 10:55:48', '2026-04-16 10:55:48');
INSERT INTO `sso_tokens` VALUES (289, 7, 'MhQAlXh0PipO7bA6oWSfjtER140dcRvtJfEJoyO1sMiNodKOS12688i9YagSJVSX', 'info', '2026-04-16 10:56:48', '2026-04-16 10:55:48', '2026-04-16 10:55:48');
INSERT INTO `sso_tokens` VALUES (325, 7, 'algzdGRLimMKfsafF2YAB5MceI1SxWHCid7klRcuhG8daNz0h5uBCSnbabcGvCGu', 'info', '2026-04-21 16:33:30', '2026-04-21 16:32:30', '2026-04-21 16:32:30');

-- ----------------------------
-- Table structure for system_logs
-- ----------------------------
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `system_logs_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 351 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_logs
-- ----------------------------
INSERT INTO `system_logs` VALUES (58, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: HOSXP', '192.168.60.1', '2026-03-05 21:28:43', '2026-03-05 21:28:43');
INSERT INTO `system_logs` VALUES (59, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: พยาบาล', '192.168.60.1', '2026-03-06 08:49:14', '2026-03-06 08:49:14');
INSERT INTO `system_logs` VALUES (60, 1, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นายจักรพงศ์ ทิพยศรี', '192.168.60.1', '2026-03-06 08:50:42', '2026-03-06 08:50:42');
INSERT INTO `system_logs` VALUES (61, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายธนากร พรหมจอม ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-06 09:32:51', '2026-03-06 09:32:51');
INSERT INTO `system_logs` VALUES (62, 1, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นายธนากร พรหมจอม', '192.168.60.1', '2026-03-06 09:33:35', '2026-03-06 09:33:35');
INSERT INTO `system_logs` VALUES (63, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายธนากร พรหมจอม', '192.168.60.1', '2026-03-06 10:02:56', '2026-03-06 10:02:56');
INSERT INTO `system_logs` VALUES (64, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจักรพงศ์ ทิพยศรี', '192.168.60.1', '2026-03-06 10:03:31', '2026-03-06 10:03:31');
INSERT INTO `system_logs` VALUES (65, 1, 'ลบแผนก', 'ลบแผนกชื่อ: ดิจิทัลทางการแพทย์และสุขภาพ ออกจากระบบ', '192.168.60.1', '2026-03-06 10:04:07', '2026-03-06 10:04:07');
INSERT INTO `system_logs` VALUES (66, 1, 'ลบแผนก', 'ลบแผนกชื่อ: palliative ออกจากระบบ', '192.168.60.1', '2026-03-06 10:04:24', '2026-03-06 10:04:24');
INSERT INTO `system_logs` VALUES (67, 1, 'เพิ่มตำแหน่ง', 'เพิ่มตำแหน่งใหม่ชื่อ: เจ้าพนักงานพัสดุ', '192.168.60.1', '2026-03-06 11:12:13', '2026-03-06 11:12:13');
INSERT INTO `system_logs` VALUES (68, 1, 'เพิ่มตำแหน่ง', 'เพิ่มตำแหน่งใหม่ชื่อ: นักวิชาการพัสดุ', '192.168.60.1', '2026-03-06 11:12:22', '2026-03-06 11:12:22');
INSERT INTO `system_logs` VALUES (69, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวพรนภา พลายงาม ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-06 11:14:12', '2026-03-06 11:14:12');
INSERT INTO `system_logs` VALUES (70, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวพรนภา พลายงาม', '192.168.60.1', '2026-03-06 11:14:23', '2026-03-06 11:14:23');
INSERT INTO `system_logs` VALUES (71, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: เจ้าหน้าที่ทั่วไป', '192.168.60.1', '2026-03-06 11:14:40', '2026-03-06 11:14:40');
INSERT INTO `system_logs` VALUES (72, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: แพทย์', '192.168.60.1', '2026-03-06 11:14:51', '2026-03-06 11:14:51');
INSERT INTO `system_logs` VALUES (73, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: พยาบาล', '192.168.60.1', '2026-03-06 11:14:58', '2026-03-06 11:14:58');
INSERT INTO `system_logs` VALUES (74, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวสุดารัตน์ แพงโท ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-06 11:15:10', '2026-03-06 11:15:10');
INSERT INTO `system_logs` VALUES (75, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวพรนภา พลายงาม', '192.168.60.1', '2026-03-06 11:15:46', '2026-03-06 11:15:46');
INSERT INTO `system_logs` VALUES (76, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายมงคล โพธิ์นะ ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-06 13:07:10', '2026-03-06 13:07:10');
INSERT INTO `system_logs` VALUES (77, 1, 'เพิ่มตำแหน่ง', 'เพิ่มตำแหน่งใหม่ชื่อ: นักจัดการทั่วไป', '192.168.60.1', '2026-03-06 13:13:16', '2026-03-06 13:13:16');
INSERT INTO `system_logs` VALUES (78, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายจิรายุส ครุฑใจกล้า ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-06 13:13:22', '2026-03-06 13:13:22');
INSERT INTO `system_logs` VALUES (79, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจิรายุส ครุฑใจกล้า', '192.168.60.1', '2026-03-06 13:13:33', '2026-03-06 13:13:33');
INSERT INTO `system_logs` VALUES (80, 11, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจักรพงศ์ ทิพยศรี (และถูกรีเซ็ตรหัสผ่านใหม่โดย Admin)', '10.10.10.88', '2026-03-08 19:09:50', '2026-03-08 19:09:50');
INSERT INTO `system_logs` VALUES (81, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: ผู้ดูแลระบบ', '10.10.10.88', '2026-03-08 19:10:08', '2026-03-08 19:10:08');
INSERT INTO `system_logs` VALUES (82, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-08 19:17:38', '2026-03-08 19:17:38');
INSERT INTO `system_logs` VALUES (83, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: เจ้าหน้าที่ทั่วไป', '10.10.10.88', '2026-03-08 19:28:50', '2026-03-08 19:28:50');
INSERT INTO `system_logs` VALUES (84, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: พยาบาล', '10.10.10.88', '2026-03-08 19:28:53', '2026-03-08 19:28:53');
INSERT INTO `system_logs` VALUES (85, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: แพทย์', '10.10.10.88', '2026-03-08 19:28:57', '2026-03-08 19:28:57');
INSERT INTO `system_logs` VALUES (86, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายสาระแน สาระแน', '10.10.10.88', '2026-03-08 19:29:19', '2026-03-08 19:29:19');
INSERT INTO `system_logs` VALUES (87, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจิรายุส ครุฑใจกล้า', '10.10.10.88', '2026-03-08 19:29:29', '2026-03-08 19:29:29');
INSERT INTO `system_logs` VALUES (88, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายมงคล โพธิ์นะ', '10.10.10.88', '2026-03-08 19:29:38', '2026-03-08 19:29:38');
INSERT INTO `system_logs` VALUES (89, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวสุดารัตน์ แพงโท', '10.10.10.88', '2026-03-08 19:29:48', '2026-03-08 19:29:48');
INSERT INTO `system_logs` VALUES (90, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวพรนภา พลายงาม', '10.10.10.88', '2026-03-08 19:29:56', '2026-03-08 19:29:56');
INSERT INTO `system_logs` VALUES (91, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจิรายุส ครุฑใจกล้า', '10.10.10.88', '2026-03-08 20:19:48', '2026-03-08 20:19:48');
INSERT INTO `system_logs` VALUES (92, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายมงคล โพธิ์นะ', '10.10.10.88', '2026-03-08 20:20:01', '2026-03-08 20:20:01');
INSERT INTO `system_logs` VALUES (93, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวสุดารัตน์ แพงโท', '10.10.10.88', '2026-03-08 20:20:21', '2026-03-08 20:20:21');
INSERT INTO `system_logs` VALUES (94, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวพรนภา พลายงาม', '10.10.10.88', '2026-03-08 20:20:38', '2026-03-08 20:20:38');
INSERT INTO `system_logs` VALUES (95, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายธนากร พรหมจอม', '10.10.10.88', '2026-03-08 20:20:48', '2026-03-08 20:20:48');
INSERT INTO `system_logs` VALUES (96, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-08 20:20:58', '2026-03-08 20:20:58');
INSERT INTO `system_logs` VALUES (97, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายสาระแน สาระแน', '10.10.10.88', '2026-03-08 20:21:17', '2026-03-08 20:21:17');
INSERT INTO `system_logs` VALUES (98, 1, 'ลบผู้ใช้งาน', 'ลบบัญชีพนักงาน: นายสาระแน สาระแน ออกจากระบบ', '192.168.60.1', '2026-03-09 08:34:50', '2026-03-09 08:34:50');
INSERT INTO `system_logs` VALUES (99, 1, 'เพิ่มข้อมูลสลิปเงินเดือน (Manual)', 'เพิ่มข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี ประจำเดือน: 03-2026', '10.10.10.88', '2026-03-09 14:28:04', '2026-03-09 14:28:04');
INSERT INTO `system_logs` VALUES (100, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-09 14:58:56', '2026-03-09 14:58:56');
INSERT INTO `system_logs` VALUES (101, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-09 14:59:09', '2026-03-09 14:59:09');
INSERT INTO `system_logs` VALUES (102, 1, 'เพิ่มข้อมูลสลิปเงินเดือน (Manual)', 'เพิ่มข้อมูลสลิปเงินเดือนของ: ธนากร พรหมจอม ประจำเดือน: 03-2026', '10.10.10.88', '2026-03-09 15:05:49', '2026-03-09 15:05:49');
INSERT INTO `system_logs` VALUES (103, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-09 15:23:20', '2026-03-09 15:23:20');
INSERT INTO `system_logs` VALUES (104, 1, 'เพิ่มหมวดหมู่ซอฟต์แวร์', 'เพิ่มหมวดหมู่: Website', '192.168.60.1', '2026-03-11 09:19:13', '2026-03-11 09:19:13');
INSERT INTO `system_logs` VALUES (105, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: KPHIS IPD Peperless', '192.168.60.1', '2026-03-11 09:20:38', '2026-03-11 09:20:38');
INSERT INTO `system_logs` VALUES (106, 1, 'เพิ่มลิขสิทธิ์ซอฟต์แวร์', 'เพิ่มลิขสิทธิ์ให้โปรแกรม: KPHIS IPD Peperless (PO: )', '192.168.60.1', '2026-03-11 09:20:59', '2026-03-11 09:20:59');
INSERT INTO `system_logs` VALUES (107, 1, 'แก้ไขข้อมูลซอฟต์แวร์', 'แก้ไขซอฟต์แวร์: KPHIS IPD Peperless', '192.168.60.1', '2026-03-11 09:26:39', '2026-03-11 09:26:39');
INSERT INTO `system_logs` VALUES (108, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบติดตาม Chart IPD', '192.168.60.1', '2026-03-11 09:27:34', '2026-03-11 09:27:34');
INSERT INTO `system_logs` VALUES (109, 1, 'เพิ่มลิขสิทธิ์ซอฟต์แวร์', 'เพิ่มลิขสิทธิ์ให้โปรแกรม: ระบบติดตาม Chart IPD (PO: )', '192.168.60.1', '2026-03-11 09:27:56', '2026-03-11 09:27:56');
INSERT INTO `system_logs` VALUES (110, 1, 'แก้ไขลิขสิทธิ์ซอฟต์แวร์', 'แก้ไขลิขสิทธิ์ ID: 4 ของโปรแกรม KPHIS IPD Peperless', '192.168.60.1', '2026-03-11 09:28:09', '2026-03-11 09:28:09');
INSERT INTO `system_logs` VALUES (111, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบสแกนชาร์ทผู้ป่วยนอก', '192.168.60.1', '2026-03-11 09:29:14', '2026-03-11 09:29:14');
INSERT INTO `system_logs` VALUES (112, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบสแกนชาร์ทผู้ป่วยใน', '192.168.60.1', '2026-03-11 09:29:30', '2026-03-11 09:29:30');
INSERT INTO `system_logs` VALUES (113, 1, 'เพิ่มหมวดหมู่ซอฟต์แวร์', 'เพิ่มหมวดหมู่: X-RAY', '192.168.60.1', '2026-03-11 09:30:10', '2026-03-11 09:30:10');
INSERT INTO `system_logs` VALUES (114, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: PAC', '192.168.60.1', '2026-03-11 09:31:03', '2026-03-11 09:31:03');
INSERT INTO `system_logs` VALUES (115, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบติดตามทวงหนี้', '192.168.60.1', '2026-03-11 09:32:03', '2026-03-11 09:32:03');
INSERT INTO `system_logs` VALUES (116, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบแจ้งซ่อมคอมพิวเตอร์', '192.168.60.1', '2026-03-11 09:32:46', '2026-03-11 09:32:46');
INSERT INTO `system_logs` VALUES (117, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบสารบรรณอิเล็กทรอนิกส์', '192.168.60.1', '2026-03-11 09:34:05', '2026-03-11 09:34:05');
INSERT INTO `system_logs` VALUES (118, 1, 'เพิ่มลิขสิทธิ์ซอฟต์แวร์', 'เพิ่มลิขสิทธิ์ให้โปรแกรม: ระบบสารบรรณอิเล็กทรอนิกส์ (PO: )', '192.168.60.1', '2026-03-11 09:34:21', '2026-03-11 09:34:21');
INSERT INTO `system_logs` VALUES (119, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: ระบบขอรายงานสารสนเทศ', '192.168.60.1', '2026-03-11 09:35:06', '2026-03-11 09:35:06');
INSERT INTO `system_logs` VALUES (120, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: Dashboard รพ.บ้านแพง', '192.168.60.1', '2026-03-11 09:35:38', '2026-03-11 09:35:38');
INSERT INTO `system_logs` VALUES (121, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 10:23:10', '2026-03-11 10:23:10');
INSERT INTO `system_logs` VALUES (122, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 10:23:33', '2026-03-11 10:23:33');
INSERT INTO `system_logs` VALUES (123, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260311_102859.xlsx', '10.10.10.88', '2026-03-11 10:28:59', '2026-03-11 10:28:59');
INSERT INTO `system_logs` VALUES (124, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 2 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 10:34:51', '2026-03-11 10:34:51');
INSERT INTO `system_logs` VALUES (125, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260311_103502.xlsx', '10.10.10.88', '2026-03-11 10:35:02', '2026-03-11 10:35:02');
INSERT INTO `system_logs` VALUES (126, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 10:48:44', '2026-03-11 10:48:44');
INSERT INTO `system_logs` VALUES (127, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-11 13:47:04', '2026-03-11 13:47:04');
INSERT INTO `system_logs` VALUES (128, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-11 14:23:58', '2026-03-11 14:23:58');
INSERT INTO `system_logs` VALUES (129, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: จักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-11 14:24:46', '2026-03-11 14:24:46');
INSERT INTO `system_logs` VALUES (130, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 2 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 14:45:22', '2026-03-11 14:45:22');
INSERT INTO `system_logs` VALUES (131, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 2 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-11 15:08:55', '2026-03-11 15:08:55');
INSERT INTO `system_logs` VALUES (132, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจิรายุส ครุฑใจกล้า (และถูกรีเซ็ตรหัสผ่านใหม่โดย Admin)', '10.10.10.88', '2026-03-11 16:46:47', '2026-03-11 16:46:47');
INSERT INTO `system_logs` VALUES (133, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายมงคล โพธิ์นะ (และถูกรีเซ็ตรหัสผ่านใหม่โดย Admin)', '10.10.10.87', '2026-03-11 16:59:56', '2026-03-11 16:59:56');
INSERT INTO `system_logs` VALUES (134, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายมงคล โพธิ์นะ', '10.10.10.87', '2026-03-11 17:01:24', '2026-03-11 17:01:24');
INSERT INTO `system_logs` VALUES (135, 9, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 166 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.87', '2026-03-11 17:08:31', '2026-03-11 17:08:31');
INSERT INTO `system_logs` VALUES (136, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.87', '2026-03-11 17:09:50', '2026-03-11 17:09:50');
INSERT INTO `system_logs` VALUES (137, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายจิรายุส ครุฑใจกล้า', '10.10.10.87', '2026-03-11 17:10:42', '2026-03-11 17:10:42');
INSERT INTO `system_logs` VALUES (138, 10, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.87', '2026-03-11 17:11:10', '2026-03-11 17:11:10');
INSERT INTO `system_logs` VALUES (139, 9, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.87', '2026-03-11 17:11:40', '2026-03-11 17:11:40');
INSERT INTO `system_logs` VALUES (140, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวณัฐกานต์ เวียงสิมา ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-11 19:54:15', '2026-03-11 19:54:15');
INSERT INTO `system_logs` VALUES (141, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวณัฐกานต์ เวียงสิมา', '192.168.60.1', '2026-03-11 19:54:23', '2026-03-11 19:54:23');
INSERT INTO `system_logs` VALUES (142, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวณัฐกานต์ เวียงสิมา', '192.168.60.1', '2026-03-11 19:57:09', '2026-03-11 19:57:09');
INSERT INTO `system_logs` VALUES (143, 13, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '192.168.60.1', '2026-03-11 19:57:55', '2026-03-11 19:57:55');
INSERT INTO `system_logs` VALUES (144, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายuser user ให้เข้าใช้งานระบบ', '10.10.10.88', '2026-03-12 08:40:21', '2026-03-12 08:40:21');
INSERT INTO `system_logs` VALUES (145, 1, 'ลบผู้ใช้งาน', 'ลบบัญชีพนักงาน: นายuser user ออกจากระบบ', '10.10.10.88', '2026-03-12 08:41:07', '2026-03-12 08:41:07');
INSERT INTO `system_logs` VALUES (146, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายuser user ให้เข้าใช้งานระบบ', '10.10.10.88', '2026-03-12 08:42:43', '2026-03-12 08:42:43');
INSERT INTO `system_logs` VALUES (147, 15, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-12 08:43:05', '2026-03-12 08:43:05');
INSERT INTO `system_logs` VALUES (148, 1, 'ลบผู้ใช้งาน', 'ลบบัญชีพนักงาน: นายuser user ออกจากระบบ', '10.10.10.88', '2026-03-12 08:43:46', '2026-03-12 08:43:46');
INSERT INTO `system_logs` VALUES (149, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายทดสอบ ทดสอบ ให้เข้าใช้งานระบบ', '10.10.10.88', '2026-03-12 09:01:59', '2026-03-12 09:01:59');
INSERT INTO `system_logs` VALUES (150, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: นายจักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-12 09:52:23', '2026-03-12 09:52:23');
INSERT INTO `system_logs` VALUES (151, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นายทดสอบ ทดสอบ ให้เข้าใช้งานระบบ', '10.10.10.88', '2026-03-12 10:15:57', '2026-03-12 10:15:57');
INSERT INTO `system_logs` VALUES (152, 1, 'เพิ่มข้อมูลสลิปเงินเดือน (Manual)', 'เพิ่มข้อมูลสลิปเงินเดือนของ: นายจักรพงศ์ ทิพยศรี ประจำเดือน: 03-2026', '10.10.10.88', '2026-03-12 16:07:22', '2026-03-12 16:07:22');
INSERT INTO `system_logs` VALUES (153, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: นายจักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-12 16:07:43', '2026-03-12 16:07:43');
INSERT INTO `system_logs` VALUES (154, 1, 'แก้ไขข้อมูลสลิปเงินเดือน', 'แก้ไขข้อมูลสลิปเงินเดือนของ: นายจักรพงศ์ ทิพยศรี', '10.10.10.88', '2026-03-12 16:09:35', '2026-03-12 16:09:35');
INSERT INTO `system_logs` VALUES (155, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-12 16:13:10', '2026-03-12 16:13:10');
INSERT INTO `system_logs` VALUES (156, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-12 16:13:16', '2026-03-12 16:13:16');
INSERT INTO `system_logs` VALUES (157, 6, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวรัชดา บุตรวงค์ ให้เข้าใช้งานระบบ', '10.10.10.15', '2026-03-12 16:28:39', '2026-03-12 16:28:39');
INSERT INTO `system_logs` VALUES (158, 6, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวจินตหรา นิมิตร ให้เข้าใช้งานระบบ', '10.10.10.15', '2026-03-12 16:29:52', '2026-03-12 16:29:52');
INSERT INTO `system_logs` VALUES (159, 6, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวจินตหรา นิมิตร', '10.10.10.15', '2026-03-12 16:30:37', '2026-03-12 16:30:37');
INSERT INTO `system_logs` VALUES (160, 6, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวรัชดา บุตรวงค์', '10.10.10.15', '2026-03-12 16:30:49', '2026-03-12 16:30:49');
INSERT INTO `system_logs` VALUES (161, 1, 'เพิ่มข้อมูล', 'เพิ่มข้อมูลสลิปเงินเดือน (Manual) ของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-12 16:32:50', '2026-03-12 16:32:50');
INSERT INTO `system_logs` VALUES (162, 6, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวจินตหรา นิมิตร', '10.10.10.15', '2026-03-12 16:34:09', '2026-03-12 16:34:09');
INSERT INTO `system_logs` VALUES (163, 6, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวรัชดา บุตรวงค์', '10.10.10.15', '2026-03-12 16:34:42', '2026-03-12 16:34:42');
INSERT INTO `system_logs` VALUES (164, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นายมงคล โพธิ์นะ', '10.10.10.88', '2026-03-12 16:36:53', '2026-03-12 16:36:53');
INSERT INTO `system_logs` VALUES (165, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260313_101755.xlsx', '10.10.10.88', '2026-03-13 10:17:55', '2026-03-13 10:17:55');
INSERT INTO `system_logs` VALUES (166, 1, 'เพิ่มข้อมูล', 'เพิ่มข้อมูลสลิปเงินเดือน (Manual) ของ นางสาวพรนภา พลายงาม', NULL, '2026-03-13 10:36:12', '2026-03-13 10:36:12');
INSERT INTO `system_logs` VALUES (167, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-13 10:36:41', '2026-03-13 10:36:41');
INSERT INTO `system_logs` VALUES (168, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260313_104201.xlsx', '10.10.10.88', '2026-03-13 10:42:01', '2026-03-13 10:42:01');
INSERT INTO `system_logs` VALUES (169, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-13 10:45:11', '2026-03-13 10:45:11');
INSERT INTO `system_logs` VALUES (170, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-13 10:45:28', '2026-03-13 10:45:28');
INSERT INTO `system_logs` VALUES (171, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-13 10:48:44', '2026-03-13 10:48:44');
INSERT INTO `system_logs` VALUES (172, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-13 10:49:16', '2026-03-13 10:49:16');
INSERT INTO `system_logs` VALUES (173, 1, 'เพิ่มข้อมูล', 'เพิ่มข้อมูลสลิปเงินเดือน (Manual) ของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-13 10:54:35', '2026-03-13 10:54:35');
INSERT INTO `system_logs` VALUES (174, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-13 11:12:15', '2026-03-13 11:12:15');
INSERT INTO `system_logs` VALUES (175, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-13 11:12:25', '2026-03-13 11:12:25');
INSERT INTO `system_logs` VALUES (176, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-03-13 13:34:15', '2026-03-13 13:34:15');
INSERT INTO `system_logs` VALUES (177, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.88', '2026-03-13 13:34:18', '2026-03-13 13:34:18');
INSERT INTO `system_logs` VALUES (178, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-03-13 13:41:25', '2026-03-13 13:41:25');
INSERT INTO `system_logs` VALUES (179, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260313_134133.xlsx', '10.10.10.88', '2026-03-13 13:41:33', '2026-03-13 13:41:33');
INSERT INTO `system_logs` VALUES (180, 6, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.15', '2026-03-17 10:15:42', '2026-03-17 10:15:42');
INSERT INTO `system_logs` VALUES (181, 1, 'อนุมัติผู้ใช้งาน', 'อนุมัติพนักงาน: นางสาวกนิษฐา วงษ์หอย ให้เข้าใช้งานระบบ', '192.168.60.1', '2026-03-19 16:19:03', '2026-03-19 16:19:03');
INSERT INTO `system_logs` VALUES (182, 1, 'แก้ไขข้อมูลผู้ใช้งาน', 'แก้ไขข้อมูลส่วนตัวของ: นางสาวกนิษฐา วงษ์หอย', '192.168.60.1', '2026-03-19 16:19:11', '2026-03-19 16:19:11');
INSERT INTO `system_logs` VALUES (183, 1, 'เพิ่มหมวดหมู่ซอฟต์แวร์', 'เพิ่มหมวดหมู่: Network', '192.168.60.1', '2026-03-19 16:45:49', '2026-03-19 16:45:49');
INSERT INTO `system_logs` VALUES (184, 1, 'เพิ่มข้อมูลซอฟต์แวร์', 'เพิ่มทะเบียนซอฟต์แวร์: Licenes Firewall', '192.168.60.1', '2026-03-19 16:46:47', '2026-03-19 16:46:47');
INSERT INTO `system_logs` VALUES (185, 1, 'เพิ่มลิขสิทธิ์ซอฟต์แวร์', 'เพิ่มลิขสิทธิ์ให้โปรแกรม: Dashboard รพ.บ้านแพง (PO: )', '192.168.60.1', '2026-03-30 10:07:57', '2026-03-30 10:07:57');
INSERT INTO `system_logs` VALUES (186, 1, 'บันทึกการติดตั้งซอฟต์แวร์', 'ติดตั้ง Dashboard รพ.บ้านแพง ลงที่เครื่อง BOSS-PC', '192.168.60.1', '2026-03-30 10:10:10', '2026-03-30 10:10:10');
INSERT INTO `system_logs` VALUES (187, 1, 'บันทึกการติดตั้งซอฟต์แวร์', 'ติดตั้ง Dashboard รพ.บ้านแพง ลงที่เครื่อง Dent01', '192.168.60.1', '2026-03-30 10:10:40', '2026-03-30 10:10:40');
INSERT INTO `system_logs` VALUES (188, 1, 'บันทึกการติดตั้งซอฟต์แวร์', 'ติดตั้ง Dashboard รพ.บ้านแพง ลงที่เครื่อง Dent02', '192.168.60.1', '2026-03-30 10:11:03', '2026-03-30 10:11:03');
INSERT INTO `system_logs` VALUES (189, 1, 'แก้ไขประวัติติดตั้งซอฟต์แวร์', 'อัปเดตข้อมูลเครื่อง Dent02 ของโปรแกรม Dashboard รพ.บ้านแพง', '192.168.60.1', '2026-03-30 10:11:16', '2026-03-30 10:11:16');
INSERT INTO `system_logs` VALUES (190, 1, 'แก้ไขประวัติติดตั้งซอฟต์แวร์', 'อัปเดตข้อมูลเครื่อง Dent01 ของโปรแกรม Dashboard รพ.บ้านแพง', '192.168.60.1', '2026-03-30 10:11:20', '2026-03-30 10:11:20');
INSERT INTO `system_logs` VALUES (191, 1, 'บันทึกการติดตั้งซอฟต์แวร์', 'ติดตั้ง Dashboard รพ.บ้านแพง ลงที่เครื่อง Doctor_NCD_1', '192.168.60.1', '2026-03-30 10:11:53', '2026-03-30 10:11:53');
INSERT INTO `system_logs` VALUES (192, 1, 'แก้ไขประวัติติดตั้งซอฟต์แวร์', 'อัปเดตข้อมูลเครื่อง Doctor_NCD_1 ของโปรแกรม Dashboard รพ.บ้านแพง', '192.168.60.1', '2026-03-30 10:12:01', '2026-03-30 10:12:01');
INSERT INTO `system_logs` VALUES (193, 1, 'บันทึกการติดตั้งซอฟต์แวร์', 'ติดตั้ง Dashboard รพ.บ้านแพง ลงที่เครื่อง ham', '192.168.60.1', '2026-03-30 10:12:17', '2026-03-30 10:12:17');
INSERT INTO `system_logs` VALUES (194, 6, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026', '10.10.10.15', '2026-04-02 13:07:00', '2026-04-02 13:07:00');
INSERT INTO `system_logs` VALUES (195, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-04-03 11:58:24', '2026-04-03 11:58:24');
INSERT INTO `system_logs` VALUES (196, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-04-03 11:59:59', '2026-04-03 11:59:59');
INSERT INTO `system_logs` VALUES (197, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 2 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.88', '2026-04-03 12:01:30', '2026-04-03 12:01:30');
INSERT INTO `system_logs` VALUES (198, 1, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 1 รายการ (ทั้งหมดทุกรอบเดือน)', '127.0.0.1', '2026-04-08 14:12:56', '2026-04-08 14:12:56');
INSERT INTO `system_logs` VALUES (199, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 04-2026-01', '127.0.0.1', '2026-04-08 14:13:24', '2026-04-08 14:13:24');
INSERT INTO `system_logs` VALUES (200, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 04-2026-01', '127.0.0.1', '2026-04-08 14:14:26', '2026-04-08 14:14:26');
INSERT INTO `system_logs` VALUES (201, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-04-08 14:49:06', '2026-04-08 14:49:06');
INSERT INTO `system_logs` VALUES (202, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 04-2026-01', '127.0.0.1', '2026-04-08 14:52:48', '2026-04-08 14:52:48');
INSERT INTO `system_logs` VALUES (203, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 04-2026-02', '127.0.0.1', '2026-04-08 14:52:50', '2026-04-08 14:52:50');
INSERT INTO `system_logs` VALUES (204, 1, 'ส่งออกข้อมูลสลิปเงินเดือน (Excel)', 'ดาวน์โหลดไฟล์ SalarySlips_20260408_145659.xlsx', '127.0.0.1', '2026-04-08 14:56:59', '2026-04-08 14:56:59');
INSERT INTO `system_logs` VALUES (205, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-04-08 16:10:22', '2026-04-08 16:10:22');
INSERT INTO `system_logs` VALUES (206, 1, 'แก้ไขข้อมูล', 'แก้ไขข้อมูลสลิปเงินเดือนของ นายจักรพงศ์ ทิพยศรี', NULL, '2026-04-08 16:10:46', '2026-04-08 16:10:46');
INSERT INTO `system_logs` VALUES (207, 9, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 166 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.87', '2026-04-09 13:20:55', '2026-04-09 13:20:55');
INSERT INTO `system_logs` VALUES (208, 9, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026-01', '10.10.10.87', '2026-04-09 13:21:07', '2026-04-09 13:21:07');
INSERT INTO `system_logs` VALUES (209, 9, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 166 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.87', '2026-04-09 16:50:08', '2026-04-09 16:50:08');
INSERT INTO `system_logs` VALUES (210, 9, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 02-2026-01', '10.10.10.87', '2026-04-09 16:50:15', '2026-04-09 16:50:15');
INSERT INTO `system_logs` VALUES (211, 9, 'เผยแพร่สลิปเงินเดือนทั้งหมด', 'เผยแพร่สลิปเงินเดือนรวดเดียว จำนวน 141 รายการ (ทั้งหมดทุกรอบเดือน)', '10.10.10.87', '2026-04-09 16:57:52', '2026-04-09 16:57:52');
INSERT INTO `system_logs` VALUES (212, 9, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026-02', '10.10.10.87', '2026-04-09 16:57:59', '2026-04-09 16:57:59');
INSERT INTO `system_logs` VALUES (213, 1, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026-02', '192.168.60.1', '2026-04-10 11:15:07', '2026-04-10 11:15:07');
INSERT INTO `system_logs` VALUES (214, 1, 'ปฏิเสธการอนุมัติบุคลากร', 'ปฏิเสธการอนุมัติและลบคำขอสมัครของ: Jakkrapong Thippayasri', '127.0.0.1', '2026-04-16 13:29:40', '2026-04-16 13:29:40');
INSERT INTO `system_logs` VALUES (215, 1, 'ยกเลิกการผูก LINE', 'ผู้ใช้ยกเลิกการเชื่อมต่อบัญชี LINE ออกจากโปรไฟล์ของตนเอง', '127.0.0.1', '2026-04-17 10:09:05', '2026-04-17 10:09:05');
INSERT INTO `system_logs` VALUES (216, 1, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '127.0.0.1', '2026-04-17 10:09:29', '2026-04-17 10:09:29');
INSERT INTO `system_logs` VALUES (217, 1, 'ยกเลิกการผูก LINE', 'ผู้ใช้ยกเลิกการเชื่อมต่อบัญชี LINE ออกจากโปรไฟล์ของตนเอง', '192.168.60.1', '2026-04-17 10:41:43', '2026-04-17 10:41:43');
INSERT INTO `system_logs` VALUES (218, 1, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '192.168.60.1', '2026-04-17 10:41:58', '2026-04-17 10:41:58');
INSERT INTO `system_logs` VALUES (219, 1, 'ยกเลิกการผูก LINE', 'ผู้ใช้ยกเลิกการเชื่อมต่อบัญชี LINE ออกจากโปรไฟล์ของตนเอง', '192.168.60.1', '2026-04-17 10:42:15', '2026-04-17 10:42:15');
INSERT INTO `system_logs` VALUES (220, 6, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '192.168.60.1', '2026-04-17 10:45:32', '2026-04-17 10:45:32');
INSERT INTO `system_logs` VALUES (221, 1, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '192.168.60.1', '2026-04-17 10:47:04', '2026-04-17 10:47:04');
INSERT INTO `system_logs` VALUES (222, 7, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '10.10.10.20', '2026-04-17 10:51:40', '2026-04-17 10:51:40');
INSERT INTO `system_logs` VALUES (223, 1, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '127.0.0.1', '2026-04-17 11:10:49', '2026-04-17 11:10:49');
INSERT INTO `system_logs` VALUES (224, 1, 'ยกเลิกการผูก LINE', 'ผู้ใช้ยกเลิกการเชื่อมต่อบัญชี LINE ออกจากโปรไฟล์ของตนเอง', '127.0.0.1', '2026-04-17 11:12:13', '2026-04-17 11:12:13');
INSERT INTO `system_logs` VALUES (225, 1, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '127.0.0.1', '2026-04-17 11:12:19', '2026-04-17 11:12:19');
INSERT INTO `system_logs` VALUES (226, 1, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักแถวที่ 2\"', NULL, '2026-04-19 21:27:36', '2026-04-19 21:27:36');
INSERT INTO `system_logs` VALUES (227, 1, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นางสาวณัฐกานต์ เวียงสิมา', '127.0.0.1', '2026-04-19 21:37:36', '2026-04-19 21:37:36');
INSERT INTO `system_logs` VALUES (228, 1, 'ลบข้อมูล', 'บ้านพัก: ลบบิล \"BILL-202604181656\" สำหรับห้อง \"339/1\"', NULL, '2026-04-19 22:12:39', '2026-04-19 22:12:39');
INSERT INTO `system_logs` VALUES (229, 1, 'ลบข้อมูล', 'บ้านพัก: ลบบิล \"BILL-202604183006\" สำหรับห้อง \"339/1\"', NULL, '2026-04-19 22:12:42', '2026-04-19 22:12:42');
INSERT INTO `system_logs` VALUES (230, 13, 'เพิ่มข้อมูล', 'บ้านพัก: สร้างบิล \"BILL-202604221341\" สำหรับห้อง \"339/1\"', NULL, '2026-04-19 22:13:41', '2026-04-19 22:13:41');
INSERT INTO `system_logs` VALUES (231, 7, 'ดู/พิมพ์ ใบรับรองเงินเดือน', 'รอบเดือน: 03-2026-01', '10.10.10.20', '2026-04-20 08:33:36', '2026-04-20 08:33:36');
INSERT INTO `system_logs` VALUES (232, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบิล \"BILL-202604221341\" สำหรับห้อง \"339/1\"', NULL, '2026-04-20 08:51:19', '2026-04-20 08:51:19');
INSERT INTO `system_logs` VALUES (233, 1, 'แก้ไขข้อมูล', 'บ้านพัก: อัปเดตสถานะการชำระของบิล \"BILL-202604221341\" เป็น \"paid\"', NULL, '2026-04-20 08:52:09', '2026-04-20 08:52:09');
INSERT INTO `system_logs` VALUES (234, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบิล \"BILL-202604221341\" สำหรับห้อง \"339/1\"', NULL, '2026-04-20 09:25:43', '2026-04-20 09:25:43');
INSERT INTO `system_logs` VALUES (235, 1, 'ปรับสถานะบิล', 'บ้านพัก: เปลี่ยนสถานะบิลจาก \"ฉบับร่าง\" เป็น \"ออกบิล\" จำนวน 1 รายการ', NULL, '2026-04-20 09:25:49', '2026-04-20 09:25:49');
INSERT INTO `system_logs` VALUES (236, 1, 'แก้ไขข้อมูล', 'บ้านพัก: อัปเดตสถานะการชำระของบิล \"BILL-202604221341\" เป็น \"pending\"', NULL, '2026-04-20 10:07:56', '2026-04-20 10:07:56');
INSERT INTO `system_logs` VALUES (237, 1, 'แก้ไขข้อมูล', 'บ้านพัก: อัปเดตสถานะการชำระของบิล \"BILL-202604221341\" เป็น \"paid\"', NULL, '2026-04-20 10:07:59', '2026-04-20 10:07:59');
INSERT INTO `system_logs` VALUES (238, 9, 'ลบข้อมูล', 'บ้านพัก: ลบห้องพัก \"339/1\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-20 16:01:56', '2026-04-20 16:01:56');
INSERT INTO `system_logs` VALUES (239, 9, 'ลบข้อมูล', 'บ้านพัก: ลบห้องพัก \"339/2\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-20 16:02:00', '2026-04-20 16:02:00');
INSERT INTO `system_logs` VALUES (240, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวภณิพิมพ์  ฟองพิสุทธิกุล\"', NULL, '2026-04-20 16:11:28', '2026-04-20 16:11:28');
INSERT INTO `system_logs` VALUES (241, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวอิงลดา  กิจพิมล\"', NULL, '2026-04-20 16:12:01', '2026-04-20 16:12:01');
INSERT INTO `system_logs` VALUES (242, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวมาลิน  บุพศิริ\"', NULL, '2026-04-20 16:12:25', '2026-04-20 16:12:25');
INSERT INTO `system_logs` VALUES (243, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาววลีรัตญา  นิลคง\"', NULL, '2026-04-20 16:12:48', '2026-04-20 16:12:48');
INSERT INTO `system_logs` VALUES (244, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางรังสิมา สิถิระบุตร\"', NULL, '2026-04-20 16:13:30', '2026-04-20 16:13:30');
INSERT INTO `system_logs` VALUES (245, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวณิชกช อาตวงศ์\"', NULL, '2026-04-20 16:14:09', '2026-04-20 16:14:09');
INSERT INTO `system_logs` VALUES (246, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวสุจิตรา  ขออาศัย\"', NULL, '2026-04-20 16:14:32', '2026-04-20 16:14:32');
INSERT INTO `system_logs` VALUES (247, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นาย มงคล โพธิ์นะ\"', NULL, '2026-04-20 16:14:41', '2026-04-20 16:14:41');
INSERT INTO `system_logs` VALUES (248, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวมาฆศิริ  ศรีนาทม\"', NULL, '2026-04-20 16:15:27', '2026-04-20 16:15:27');
INSERT INTO `system_logs` VALUES (249, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นายโชคอนันต์  ภูมิประสาท\"', NULL, '2026-04-20 16:15:57', '2026-04-20 16:15:57');
INSERT INTO `system_logs` VALUES (250, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวนลินี ทนุพร\"', NULL, '2026-04-20 16:16:16', '2026-04-20 16:16:16');
INSERT INTO `system_logs` VALUES (251, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นายเอกสิทธิ์  เสนเพ็ง\"', NULL, '2026-04-20 16:16:35', '2026-04-20 16:16:35');
INSERT INTO `system_logs` VALUES (252, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาววลัยภรณ์  จองไว\"', NULL, '2026-04-20 16:16:56', '2026-04-20 16:16:56');
INSERT INTO `system_logs` VALUES (253, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางพัชราภรณ์  ศรีเพชร\"', NULL, '2026-04-20 16:17:29', '2026-04-20 16:17:29');
INSERT INTO `system_logs` VALUES (254, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางจิณณ์ภัคธนา   เนตรวงค์\"', NULL, '2026-04-20 16:18:02', '2026-04-20 16:18:02');
INSERT INTO `system_logs` VALUES (255, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวอภิญญา    อุปเสน\"', NULL, '2026-04-20 16:18:22', '2026-04-20 16:18:22');
INSERT INTO `system_logs` VALUES (256, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวเพียงพิศ  สมรฤทธิ์\"', NULL, '2026-04-20 16:18:43', '2026-04-20 16:18:43');
INSERT INTO `system_logs` VALUES (257, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวสุทธิดา    สีหา\"', NULL, '2026-04-20 16:19:01', '2026-04-20 16:19:01');
INSERT INTO `system_logs` VALUES (258, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวกมลชนก  อุ่นชัย\"', NULL, '2026-04-20 16:19:19', '2026-04-20 16:19:19');
INSERT INTO `system_logs` VALUES (259, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวมัยญรัตน์  อุดมทนานุกูล\"', NULL, '2026-04-20 16:19:38', '2026-04-20 16:19:38');
INSERT INTO `system_logs` VALUES (260, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวสาวิตรี  นาโสก\"', NULL, '2026-04-20 16:19:58', '2026-04-20 16:19:58');
INSERT INTO `system_logs` VALUES (261, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวพรนัชชา  ชาวยศ\"', NULL, '2026-04-20 16:20:24', '2026-04-20 16:20:24');
INSERT INTO `system_logs` VALUES (262, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสันสนี   ใหม่วงค์\"', NULL, '2026-04-20 16:21:00', '2026-04-20 16:21:00');
INSERT INTO `system_logs` VALUES (263, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวนุชจรี  บุตรบุรี\"', NULL, '2026-04-20 16:21:20', '2026-04-20 16:21:20');
INSERT INTO `system_logs` VALUES (264, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวบุษกร   สำเภา\"', NULL, '2026-04-20 16:21:46', '2026-04-20 16:21:46');
INSERT INTO `system_logs` VALUES (265, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวอินธุอร   ศรีนันทา\"', NULL, '2026-04-20 16:22:08', '2026-04-20 16:22:08');
INSERT INTO `system_logs` VALUES (266, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวลดาวัลย์  ไตยราช\"', NULL, '2026-04-20 16:22:27', '2026-04-20 16:22:27');
INSERT INTO `system_logs` VALUES (267, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาววิสุดา   บาลจบ\"', NULL, '2026-04-20 16:22:47', '2026-04-20 16:22:47');
INSERT INTO `system_logs` VALUES (268, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวพรธิตา  ศิริวงศ์\"', NULL, '2026-04-20 16:23:05', '2026-04-20 16:23:05');
INSERT INTO `system_logs` VALUES (269, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวเพ็ญพร   เอกจักรแก้ว\"', NULL, '2026-04-20 16:23:23', '2026-04-20 16:23:23');
INSERT INTO `system_logs` VALUES (270, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นายกิตติคุณ  มัยวงศ์\"', NULL, '2026-04-20 16:24:44', '2026-04-20 16:24:44');
INSERT INTO `system_logs` VALUES (271, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มข้อมูลผู้พัก \"นางสาวรมิดา  วงษา\"', NULL, '2026-04-20 16:25:09', '2026-04-20 16:25:09');
INSERT INTO `system_logs` VALUES (272, 9, 'เชื่อมต่อ LINE', 'ผู้ใช้เชื่อมต่อบัญชี LINE กับโปรไฟล์ของตนเอง', '10.10.10.87', '2026-04-20 16:27:17', '2026-04-20 16:27:17');
INSERT INTO `system_logs` VALUES (273, 1, 'ลบข้อมูล', 'บ้านพัก: ลบบิล \"BILL-202604221341\" สำหรับห้อง \"-\"', NULL, '2026-04-21 10:25:36', '2026-04-21 10:25:36');
INSERT INTO `system_logs` VALUES (274, 1, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นางสาวจินตหรา นิมิตร', '192.168.60.1', '2026-04-21 10:29:29', '2026-04-21 10:29:29');
INSERT INTO `system_logs` VALUES (275, 1, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นายมงคล โพธิ์นะ', '192.168.60.1', '2026-04-21 10:29:56', '2026-04-21 10:29:56');
INSERT INTO `system_logs` VALUES (276, 1, 'ปรับปรุงสิทธิ์กลุ่ม', 'อัปเดตสิทธิ์ของบทบาท: ผู้ดูแลระบบ', '192.168.60.1', '2026-04-21 10:30:20', '2026-04-21 10:30:20');
INSERT INTO `system_logs` VALUES (277, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบ้านพัก \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 14:50:26', '2026-04-21 14:50:26');
INSERT INTO `system_logs` VALUES (278, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบ้านพัก \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 14:50:43', '2026-04-21 14:50:43');
INSERT INTO `system_logs` VALUES (279, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบ้านพัก \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 14:50:51', '2026-04-21 14:50:51');
INSERT INTO `system_logs` VALUES (280, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง\"', NULL, '2026-04-21 14:51:13', '2026-04-21 14:51:13');
INSERT INTO `system_logs` VALUES (281, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบ้านพัก \"บ้านพักเป็นหลัง 1\"', NULL, '2026-04-21 14:51:21', '2026-04-21 14:51:21');
INSERT INTO `system_logs` VALUES (282, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 2\"', NULL, '2026-04-21 14:51:36', '2026-04-21 14:51:36');
INSERT INTO `system_logs` VALUES (283, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 3\"', NULL, '2026-04-21 14:51:51', '2026-04-21 14:51:51');
INSERT INTO `system_logs` VALUES (284, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 4\"', NULL, '2026-04-21 14:52:12', '2026-04-21 14:52:12');
INSERT INTO `system_logs` VALUES (285, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 5\"', NULL, '2026-04-21 14:52:31', '2026-04-21 14:52:31');
INSERT INTO `system_logs` VALUES (286, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขบ้านพัก \"บ้านพักเป็นหลัง 5\"', NULL, '2026-04-21 14:52:36', '2026-04-21 14:52:36');
INSERT INTO `system_logs` VALUES (287, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 6\"', NULL, '2026-04-21 14:52:44', '2026-04-21 14:52:44');
INSERT INTO `system_logs` VALUES (288, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 7\"', NULL, '2026-04-21 14:52:52', '2026-04-21 14:52:52');
INSERT INTO `system_logs` VALUES (289, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 8\"', NULL, '2026-04-21 14:53:59', '2026-04-21 14:53:59');
INSERT INTO `system_logs` VALUES (290, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 9\"', NULL, '2026-04-21 14:54:14', '2026-04-21 14:54:14');
INSERT INTO `system_logs` VALUES (291, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 10\"', NULL, '2026-04-21 14:54:23', '2026-04-21 14:54:23');
INSERT INTO `system_logs` VALUES (292, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 11\"', NULL, '2026-04-21 14:54:47', '2026-04-21 14:54:47');
INSERT INTO `system_logs` VALUES (293, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 12\"', NULL, '2026-04-21 14:54:54', '2026-04-21 14:54:54');
INSERT INTO `system_logs` VALUES (294, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มบ้านพัก \"บ้านพักเป็นหลัง 13\"', NULL, '2026-04-21 14:55:02', '2026-04-21 14:55:02');
INSERT INTO `system_logs` VALUES (295, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"22\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 15:02:13', '2026-04-21 15:02:13');
INSERT INTO `system_logs` VALUES (296, 9, 'เพิ่มข้อมูล', 'บ้านพัก: ผูกผู้พัก \"นาย มงคล โพธิ์นะ\" เข้ากับห้อง \"22\"', NULL, '2026-04-21 15:02:49', '2026-04-21 15:02:49');
INSERT INTO `system_logs` VALUES (297, 9, 'เพิ่มข้อมูล', 'บ้านพัก: ผูกผู้พัก \"นาย จิรายุส ครุฑใจกล้า\" เข้ากับห้อง \"22\"', NULL, '2026-04-21 15:02:59', '2026-04-21 15:02:59');
INSERT INTO `system_logs` VALUES (298, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"3\" ใน \"บ้านพักเป็นหลัง 1\"', NULL, '2026-04-21 16:13:50', '2026-04-21 16:13:50');
INSERT INTO `system_logs` VALUES (299, 9, 'เพิ่มข้อมูล', 'บ้านพัก: ผูกผู้พัก \"นางสาวบุษกร   สำเภา\" เข้ากับห้อง \"3\"', NULL, '2026-04-21 16:14:25', '2026-04-21 16:14:25');
INSERT INTO `system_logs` VALUES (300, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"4\" ใน \"บ้านพักเป็นหลัง 2\"', NULL, '2026-04-21 16:16:42', '2026-04-21 16:16:42');
INSERT INTO `system_logs` VALUES (301, 9, 'เพิ่มข้อมูล', 'บ้านพัก: ผูกผู้พัก \"นางสาวมาฆศิริ  ศรีนาทม\" เข้ากับห้อง \"4\"', NULL, '2026-04-21 16:17:06', '2026-04-21 16:17:06');
INSERT INTO `system_logs` VALUES (302, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"5\" ใน \"บ้านพักเป็นหลัง 3\"', NULL, '2026-04-21 16:18:20', '2026-04-21 16:18:20');
INSERT INTO `system_logs` VALUES (303, 9, 'เพิ่มข้อมูล', 'บ้านพัก: ผูกผู้พัก \"นางสาววิสุดา   บาลจบ\" เข้ากับห้อง \"5\"', NULL, '2026-04-21 16:18:32', '2026-04-21 16:18:32');
INSERT INTO `system_logs` VALUES (304, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"10\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 16:19:38', '2026-04-21 16:19:38');
INSERT INTO `system_logs` VALUES (305, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"11\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 16:20:19', '2026-04-21 16:20:19');
INSERT INTO `system_logs` VALUES (306, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"12\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 16:20:37', '2026-04-21 16:20:37');
INSERT INTO `system_logs` VALUES (307, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"13\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 16:20:56', '2026-04-21 16:20:56');
INSERT INTO `system_logs` VALUES (308, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"14\" ใน \"บ้านพักแถวที่ 1\"', NULL, '2026-04-21 16:21:07', '2026-04-21 16:21:07');
INSERT INTO `system_logs` VALUES (309, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"15\" ใน \"บ้านพักเป็นหลัง 4\"', NULL, '2026-04-21 16:21:55', '2026-04-21 16:21:55');
INSERT INTO `system_logs` VALUES (310, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"16\" ใน \"บ้านพักเป็นหลัง 5\"', NULL, '2026-04-21 16:22:10', '2026-04-21 16:22:10');
INSERT INTO `system_logs` VALUES (311, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"17\" ใน \"บ้านพักเป็นหลัง 6\"', NULL, '2026-04-21 16:22:26', '2026-04-21 16:22:26');
INSERT INTO `system_logs` VALUES (312, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"18\" ใน \"บ้านพักเป็นหลัง 7\"', NULL, '2026-04-21 16:22:50', '2026-04-21 16:22:50');
INSERT INTO `system_logs` VALUES (313, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"19\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:23:22', '2026-04-21 16:23:22');
INSERT INTO `system_logs` VALUES (314, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"20\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:23:36', '2026-04-21 16:23:36');
INSERT INTO `system_logs` VALUES (315, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"21\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:23:51', '2026-04-21 16:23:51');
INSERT INTO `system_logs` VALUES (316, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขห้องพัก \"21\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:24:22', '2026-04-21 16:24:22');
INSERT INTO `system_logs` VALUES (317, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"23\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:24:57', '2026-04-21 16:24:57');
INSERT INTO `system_logs` VALUES (318, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"24\" ใน \"บ้านพักเป็นหลัง 7\"', NULL, '2026-04-21 16:25:22', '2026-04-21 16:25:22');
INSERT INTO `system_logs` VALUES (319, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขห้องพัก \"21\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:25:36', '2026-04-21 16:25:36');
INSERT INTO `system_logs` VALUES (320, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขห้องพัก \"24\" ใน \"บ้านพักเป็นหลัง 8\"', NULL, '2026-04-21 16:25:56', '2026-04-21 16:25:56');
INSERT INTO `system_logs` VALUES (321, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"25\" ใน \"บ้านพักเป็นหลัง 9\"', NULL, '2026-04-21 16:26:15', '2026-04-21 16:26:15');
INSERT INTO `system_logs` VALUES (322, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"26\" ใน \"บ้านพักเป็นหลัง 10\"', NULL, '2026-04-21 16:26:49', '2026-04-21 16:26:49');
INSERT INTO `system_logs` VALUES (323, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"27\" ใน \"บ้านพักเป็นหลัง 11\"', NULL, '2026-04-21 16:27:01', '2026-04-21 16:27:01');
INSERT INTO `system_logs` VALUES (324, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"28\" ใน \"บ้านพักเป็นหลัง 12\"', NULL, '2026-04-21 16:27:22', '2026-04-21 16:27:22');
INSERT INTO `system_logs` VALUES (325, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"30\" ใน \"บ้านพักเป็นหลัง 13\"', NULL, '2026-04-21 16:27:38', '2026-04-21 16:27:38');
INSERT INTO `system_logs` VALUES (326, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"101\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:27:52', '2026-04-21 16:27:52');
INSERT INTO `system_logs` VALUES (327, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"102\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:28:05', '2026-04-21 16:28:05');
INSERT INTO `system_logs` VALUES (328, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"103\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:28:23', '2026-04-21 16:28:23');
INSERT INTO `system_logs` VALUES (329, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"104\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:28:35', '2026-04-21 16:28:35');
INSERT INTO `system_logs` VALUES (330, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขห้องพัก \"22\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:31:00', '2026-04-21 16:31:00');
INSERT INTO `system_logs` VALUES (331, 9, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขห้องพัก \"22\" ใน \"บ้านพักแถวที่ 2\"', NULL, '2026-04-21 16:31:47', '2026-04-21 16:31:47');
INSERT INTO `system_logs` VALUES (332, 9, 'เพิ่มข้อมูล', 'บ้านพัก: สร้างบิล \"BILL-202604163152\" สำหรับห้อง \"22\"', NULL, '2026-04-21 16:32:41', '2026-04-21 16:32:41');
INSERT INTO `system_logs` VALUES (333, 9, 'ปรับสถานะบิล', 'บ้านพัก: เปลี่ยนสถานะบิลจาก \"ฉบับร่าง\" เป็น \"ออกบิล\" จำนวน 1 รายการ', NULL, '2026-04-21 16:33:29', '2026-04-21 16:33:29');
INSERT INTO `system_logs` VALUES (334, 9, 'แก้ไขข้อมูล', 'บ้านพัก: อัปเดตสถานะการชำระของบิล \"BILL-202604163152\" เป็น \"paid\"', NULL, '2026-04-21 16:35:10', '2026-04-21 16:35:10');
INSERT INTO `system_logs` VALUES (335, 9, 'ลบข้อมูล', 'บ้านพัก: ลบรายการชำระเงินของบิล \"BILL-202604163152\" วิธี \"หักจากโอที\"', NULL, '2026-04-21 16:35:21', '2026-04-21 16:35:21');
INSERT INTO `system_logs` VALUES (336, 9, 'ปรับปรุงสิทธิ์การเข้าถึง', 'เปลี่ยนแปลงสิทธิ์การใช้งานของ: นายจิรายุส ครุฑใจกล้า', '10.10.10.87', '2026-04-21 16:37:48', '2026-04-21 16:37:48');
INSERT INTO `system_logs` VALUES (337, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"201\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:40:31', '2026-04-21 16:40:31');
INSERT INTO `system_logs` VALUES (338, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"202\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:40:45', '2026-04-21 16:40:45');
INSERT INTO `system_logs` VALUES (339, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"203\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:41:01', '2026-04-21 16:41:01');
INSERT INTO `system_logs` VALUES (340, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"204\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:41:14', '2026-04-21 16:41:14');
INSERT INTO `system_logs` VALUES (341, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"301\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:41:29', '2026-04-21 16:41:29');
INSERT INTO `system_logs` VALUES (342, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"302\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:41:43', '2026-04-21 16:41:43');
INSERT INTO `system_logs` VALUES (343, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"303\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:41:59', '2026-04-21 16:41:59');
INSERT INTO `system_logs` VALUES (344, 9, 'เพิ่มข้อมูล', 'บ้านพัก: เพิ่มห้องพัก \"304\" ใน \"แฟลต 3 ชั้น\"', NULL, '2026-04-21 16:42:13', '2026-04-21 16:42:13');
INSERT INTO `system_logs` VALUES (345, 1, 'ลบข้อมูล', 'บ้านพัก: ลบบิล \"BILL-202604163152\" สำหรับห้อง \"22\"', NULL, '2026-04-22 09:27:18', '2026-04-22 09:27:18');
INSERT INTO `system_logs` VALUES (346, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขข้อมูลผู้พัก \"นายกิตติคุณ  มัยวงศ์\"', NULL, '2026-04-22 09:31:32', '2026-04-22 09:31:32');
INSERT INTO `system_logs` VALUES (347, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขข้อมูลผู้พัก \"นาย มงคล โพธิ์นะ\"', NULL, '2026-04-22 09:32:10', '2026-04-22 09:32:10');
INSERT INTO `system_logs` VALUES (348, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขข้อมูลผู้พัก \"นาย จิรายุส ครุฑใจกล้า\"', NULL, '2026-04-22 09:32:50', '2026-04-22 09:32:50');
INSERT INTO `system_logs` VALUES (349, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขข้อมูลผู้พัก \"นาย จักรพงศ์ ทิพยศรี\"', NULL, '2026-04-22 09:33:20', '2026-04-22 09:33:20');
INSERT INTO `system_logs` VALUES (350, 1, 'แก้ไขข้อมูล', 'บ้านพัก: แก้ไขข้อมูลผู้พัก \"นางสาว จินตหรา นิมิตร\"', NULL, '2026-04-22 09:33:33', '2026-04-22 09:33:33');

SET FOREIGN_KEY_CHECKS = 1;
