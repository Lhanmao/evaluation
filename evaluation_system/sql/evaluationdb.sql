/*
 Navicat MySQL Data Transfer

 Source Server         : gengxiangyi
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : evaluationdb

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 15/05/2024 11:45:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for audit
-- ----------------------------
DROP TABLE IF EXISTS `audit`;
CREATE TABLE `audit`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` int NULL DEFAULT NULL COMMENT '文章id',
  `audit_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of audit
-- ----------------------------
INSERT INTO `audit` VALUES (1, 13, '审核通过');
INSERT INTO `audit` VALUES (2, 21, '审核通过');
INSERT INTO `audit` VALUES (9, 17, '未审核');
INSERT INTO `audit` VALUES (10, 12, '审核不通过');
INSERT INTO `audit` VALUES (11, 28, '未审核');
INSERT INTO `audit` VALUES (12, 27, '未审核');
INSERT INTO `audit` VALUES (17, 9, '审核通过');
INSERT INTO `audit` VALUES (21, 36, '审核通过');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签',
  `user_id` int NULL DEFAULT NULL COMMENT '发布人ID',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布日期',
  `read_count` int NULL DEFAULT NULL COMMENT '浏览量',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `people_like` int NULL DEFAULT NULL COMMENT '热度',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '博客信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (7, '闪现1', '<p>闪现1</p>', '今天入手一双态极科技的篮球鞋，做个简单测评', '1714618813055', '[\"篮球鞋\",\"休闲鞋\"]', 2, '2024-03-13 15:26:40', 53, 5, 44, '1');
INSERT INTO `blog` VALUES (9, '闪现3', '<p><img src=\"http://localhost:8080/api/files/1710683647289-闪现3豆绿鞋跟.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '一款好鞋', '1710683640884', '[\"篮球鞋\",\"休闲鞋\"]', 1, '2024-03-13 16:35:41', 26, 4, 22, '1');
INSERT INTO `blog` VALUES (10, '水花2', '<p>这双鞋的中底偏向于韧而非软，并没有出现像当初kt4啊，水花一代的那种只软不弹，一脚踩塌的感觉。<br/></p>', '这双鞋的中底偏向于韧而非软，并没有出现像当初kt4啊，水花一代的那种只软不弹，一脚踩塌的感觉。', '1712762105182', '[\"篮球鞋\",\"休闲鞋\",\"通勤鞋\"]', 1, '2024-03-13 17:56:29', 30, 1, 25, '1');
INSERT INTO `blog` VALUES (11, '测评闪击10', '<p>兄弟们给个机会，777</p>', '一周实测闪击10', '1712762237309', '[\"通勤鞋\",\"休闲鞋\",\"篮球鞋\"]', 12, '2024-03-13 17:56:29', 9, 3, 8, '1');
INSERT INTO `blog` VALUES (12, '狂潮4', '<ul><li>耐磨性。狂潮4鞋底采用<a href=\"https://m.baidu.com/s?word=%E6%B0%B4%E6%B3%A5%E5%85%8B%E6%98%9F%E8%AE%BE%E8%AE%A1&amp;sa=re_dqa_zy\" target=\"_self\">水泥克星设计</a>，非常耐磨，适合在水泥地上穿着。</li></ul><ul><li>脚感。鞋底使用了<a href=\"https://m.baidu.com/s?word=%E5%85%A8%E6%8E%8C%E6%B0%AE%E7%A7%91%E6%8A%80&amp;sa=re_dqa_zy\" target=\"_self\">全掌氮科技</a>，脚感偏软，提供良好的包裹性和舒适性，适合正常脚型和瘦脚，但对于宽脚和高脚背的人来说，可能会感觉有些挤脚。</li></ul><ul><li>鞋楦设计。鞋楦偏窄，适合标准脚型和瘦脚，宽脚和高脚背的人可能会觉得不太合适。</li><li>透气性。鞋面透气性一般，夏天穿着可能会感觉有些热。</li><li>鞋面支撑。鞋面的支撑性能会随着使用时间的增加而有所下降，鞋头内侧的舒适度高，但长时间使用后支撑性可能会减弱，外侧则通过动态飞线和热贴加固，提供良好的侧向支撑。</li></ul><ul><li>启动性。鞋子的外侧TPU和内侧外底设计有浪形引导槽，有助于轻松启动和过渡，适合各种跑动和提速后的动作。</li></ul><p>总的来说，狂潮4是一款适合标准脚型和瘦脚的篮球鞋，具有较好的耐磨性和舒适的脚感，但在宽脚和高脚背的人穿着时可能会感觉有些不适。</p>', '狂潮系列是平民战靴', '1712762264528', '[\"休闲鞋\",\"篮球鞋\"]', 1, '2024-03-13 17:56:29', 35, 1, 29, '0');
INSERT INTO `blog` VALUES (13, '闪电9', '<section>通过拆解我们能看到这双闪电9的鞋面最外层用的是和AJ36那种同样材料的高强度纱线材料，不仅透气而且强度非常高的同时还很轻质。在使用了众多TPU加强的同时还能把US9码的重量做到400个以下，这个鞋面有很大的功劳。<br/></section><section>同时为了提升鞋面舒适度和鞋面的可调节性，增加的全掌内靴在整个脚背部分的填充也很厚实，通过拆解的物料我们就能看出来。所以虽然这双鞋楦有点偏窄，但是对于轻度宽脚和标准脚也是没有问题的。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/75fe1ca39758525ea6dc782b53cf6af5.gif\" width=\"30%\"/></p><section>除此之外鞋面包裹上有一个小问题，在用力拉紧鞋带之后对于瘦脚和标准脚的人，因为内靴的前面填充不算特别多，所以鞋面会产生一个小隆起，导致鞋头的位置不够贴合。不过两侧是能牢牢锁死的，并不影响穿着时候的锁定。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/ae79e117a220c023d1d9f0c85ee8e03c.gif\" width=\"30%\"/></p><section>而在鞋面支撑上的强度表现就是非常好的水平了，通过拆解组合你们就能看出来这双鞋的鞋面是整个包在中底里的，除此之外鞋面的前掌也有做一整圈的热贴加固，而通过拆解你也能看到鞋面两侧中腰的锁定结构是在鞋面的夹层里一直延伸到前掌内外两侧的，不仅能提供侧向支撑，同时还能提供足弓支撑，对于高足弓的朋友也是非常利好的点。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/74d18a10ab57cf002cfd9037908b27ed.gif\" width=\"30%\"/></p><section>后跟内置的港宝强度就算是拆解以后也是非常到位的。而且在内靴夹层里填充了很到位的泡棉来搭配最上层的鞋带孔提供后跟锁定。所以拉紧鞋带以后整双鞋也没有出现不跟脚。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/75fe1ca39758525ea6dc782b53cf6af5.gif\" width=\"30%\"/></p><section><strong>缺点：<br/></strong></section><section><strong>拉紧鞋带后前掌上方不够贴合</strong></section><section><strong>中底性能</strong></section><section>后跟中底厚度约为21.5mm；前掌中底厚度约为14.5mm；前后中底的龙骨落差约为7mm。本次闪电9对比前作闪现3上比较大的升级应该就是龙骨落差的调整了。首先后跟轻量化态极不使用一模双密而是内嵌也就意味着前后龙骨落差在运动时候会更低。<br/></section><section>而6-8mm的龙骨落差在后卫鞋和前锋鞋都是一双好鞋该有的龙骨落差，同时大家如果仔细注意到这双鞋的中底足弓处就会发现中底是做了隆起的而不是单单靠外侧的这块TPU去做足弓支撑。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/8de39fb58ace7063b344d23b6eaa4f63.gif\" width=\"30%\"/></p><section>而且这块带有加强筋的约为112.6mm长、约38.4mm宽的足弓支撑板也是有覆盖到后跟嵌入的态极模块上的。</section><section>所以这双闪电9的前后力传导非常流畅的同时也不会有明显的力量断层感。<br/></section><section>不过因为超级魔弹的硬度约为42，后跟轻量化态极约为30，所以10度的硬度差还是会有脚感上不同的体验。<br/></section><section>前掌的重心很低且前掌较薄的同时，在我们打球的习惯发力点，脚掌内侧的TPU这个位置，脚感体验不明显甚至会有体验起来比较硬的感觉，好处是前掌非常贴地而且场地感好的同时整个前掌的触地非常迅速。丝毫不会拖沓，而力量足的朋友还能感受到来自这块TPU的推进感。这对于以突破和速度为主的朋友来说是非常好的点。<br/></section><section>而后跟嵌入的轻量化态极对于体重85kg以下的朋友也是够用的状态。如果你注意到轻量化态极延伸至后跟向外的话，那你就能明白这双鞋这款嵌入的意义有多大。如果还有人记得我们之前说AJ34后跟缓震会感觉硬的原因，这样的放置你自然就能理解了。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/3dc5295832b19bcaf1e59b64dfac148d.gif\" width=\"30%\"/></p><section>另外这双鞋开箱初体验时候我们说的这块后跟外侧贴片加强稳定，在内侧下方后跟外侧受力点放置TPU连接内侧足弓支撑在提升一个运动时候稳定的同时还有力传导顺畅的作用，但是完全裸露的中底会存在泄力和支撑不足的问题，这块外嵌的TPU就是起到了支撑后跟稳定的作用。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/25ed81df59ff36229e408cf3692d1be8.gif\" width=\"30%\"/></p><section><strong>缺点：</strong></section><section><strong>前掌脚感偏硬</strong></section><section><strong>外底性能</strong></section><section>厚度约为3.5mm的外底，硬度约为70。这样的外底的硬度和厚度对于打外场的学生党或者一些频繁打外场的朋友来说，耐磨属性肯定是够了的。值得一提的水晶底和橡胶底在这方面是一样的。不过水晶底相对来说在实际的体验上还是会有偏软的体验，特别是防侧翻的位置，这个我们稍微再说。<br/></section><section>我们仔细看这个外底的纹路和区域划分，不难看出闪电9的外底是用切槽的形式把主要变向和切入突破时候的受力区域做了分割，无论是向前突破时候的这块易弯折划分，还是变向时候尽可能点触面的划分都是为了应对突破时候的各种情况。</section><section>有一点要说的是闪电9的前掌鞋头上翘并不算特别高，所以整个外底向前的推进感不会给你很明显的加持，也不会让你在投篮时有力的推进。整体来说更偏向稳定的状态。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/24247c37861726acd99de2b045c26300.gif\" width=\"30%\"/></p><section>抓地力在内场没有吸灰的情况下橡胶底表现不用担心，吸灰以后会有打滑的现象，水晶底相对来说在内场表现更好一些。实际上匹克的抓地力有多好，懂的都懂。基本上不必太过于担心，打外场选橡胶底，打内场选水晶底就好。<br/></section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/f4bc53b18e23daff9a1cbc7466c3ce21.gif\" width=\"30%\"/></p><section><strong>缺点：</strong><br/></section><section><strong>鞋头上翘不够高，对突破的推进感加持不大</strong></section><section><strong>安全性能</strong></section><section>抗扭我觉得不用多说了吧？超大的足弓支撑板内置，外底和中底间的前后贯穿式异形TPU，无论是哪个位置都不会出现抗扭翻车的情况。整个对折当中的弯折点也是非常合理的，不会出现在足弓位置。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/b8da8cd057cdf94251aceb3118e995dd.gif\" width=\"30%\"/></p><section>目前很多人反馈比较大的其实是防侧翻的问题。首先我们目前没遇到说防侧翻被吃掉的情况，至少在这双橡胶底上没有。所以可能是橡胶底的整体刚性要比水晶底的强一些，所以介意的朋友可以试试橡胶底。其次是这块贴片，大家注意一下，它的下方也就是嵌入中底和外底之间的这块区域相比薄了一些，在一些特别极限的情况下超级魔弹中底发生衰减以后，防侧翻的支撑性就完全是在外侧做了结构处理的部分，这部分的强度是没问题的。所以在防侧翻上并不需要过度得担心。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/dde0551d873d6451c8ec907c92107412.gif\" width=\"30%\"/></p><section>不过必须要说的一点是外底的这块防侧翻延伸相对来说是对于自家的系列是延伸的小了一些。不过加宽的大底和鞋面两侧的补强以及整个鞋前后掌的加固支撑，防侧翻其实真的不用担心。何况整双鞋的重心这么低呢？<br/></section><section><strong>缺点：</strong></section><section><strong>防侧翻延伸较小</strong></section><section><strong>性能评分（客观配置）</strong></section><section><strong>体验评分（主观体验）</strong></section><section><strong>透气：优秀</strong></section><section>闪电9说到底更像一款专门针对后卫和锋线使用的全能水桶鞋，前掌贴地后掌有缓震，找不出安全硬伤的同时把性价比拉满的一款纯实战篮球鞋。最尴尬的事情其实是在于橡胶底的质感并不算强，而水晶底的质感强但是外底材料又让大家有些担心。</section><p><img src=\"https://pic.rmb.bdstatic.com/bjh/down/7a1673f7c87c927fe1551119a75364e0.gif\" width=\"30%\"/></p><section>目前第三方价格在四百以内，后期必然也是300-400区间的鞋，对于打球为主的征战外场的后卫和小体重锋线来说，闪电9的性价比实在是太高了。当然，你别把它当成谁谁谁的平替就行。</section>', '后卫好鞋，性价比拉满，值得学生党入手', '1714618690092', '[\"篮球鞋\",\"休闲鞋\"]', 1, '2024-03-13 16:35:41', 9, 5, 8, '1');
INSERT INTO `blog` VALUES (14, '极钉', '<p>安踏足球鞋</p>', '安踏足球鞋', '1714618696936', '[\"足球鞋\"]', 34, '2024-03-13 16:35:41', 17, 1, 15, '1');
INSERT INTO `blog` VALUES (16, '闪现3', '<p>颜值：整体颜值的话这个配色可以打个7.5分，很清爽的豆绿配色，在国产鞋里也算中等偏上的存在了，流线型的设计，鞋舌处有可爱涂鸦底部还有很细节的泼墨设计。<br/></p><p>鞋盒：收到货之后这一款的鞋盒还是蛮好看的个黑色的鞋盒中间有一块三角透明部分有着匹克标志logo。<br/></p><p>鞋舌：很轻薄的设计有固定孔实战后也没有位移的情况。</p><p>鞋跟：有海绵垫和提手方便穿脱增强包裹性还有一圈防撞条的设计。</p><p>鞋底:橡胶大底TPU抗扭片纤维碳板匹克态极缓震SUPER.P-MOTIVE科技。<br/></p><p>重量：使用家里的电子秤，单只355g重量。</p><p>　　脚感：个人实战脚感中等回弹防滑和耐磨，非常nice，整体鞋型偏窄包裹感蛮强第一次实战有明显挤压感，第二次就好很多。</p><p>　　接下来说说缺点，主要是包裹的问题。我选择的是平常us码，开始两天包裹还好，但是后来越穿越宽松，越穿越肥大，但是鞋带没有办法解决这个问题，首先鞋带摩擦力太大了，很难拉到最紧；其次就算鞋带拉紧，也会在第一组鞋带孔处产生很高的凸起，导致前掌包裹的缺乏。</p><p><img src=\"http://localhost:8080/api/files/1714700472548-屏幕截图 2024-05-03 094014.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '闪现3是一双性价比较高的实战篮球鞋，适合后卫球员使用。前掌的态极脚感舒适，但可能对后卫球员来说重心较高，加速反馈较慢。', '1712761938690', '[\"篮球鞋\",\"通勤鞋\",\"休闲鞋\"]', 1, '2024-03-17 21:15:45', 167, 5, 135, '1');
INSERT INTO `blog` VALUES (17, '驭帅15', '<p>李宁旗下不平民的性价比战靴，可以观望</p>', '很贵，但不错', '1714618829874', '[\"篮球鞋\",\"休闲鞋\"]', 1, '2024-03-18 11:59:29', 18, 2, 16, '-1');
INSERT INTO `blog` VALUES (18, '狂潮4测评', '<p><a href=\"https://m.baidu.com/s?word=%E7%8B%82%E6%BD%AE4&amp;sa=re_dqa_zy\" target=\"_self\">狂潮4</a>鞋子的测评如下：</p><p><img src=\"http://localhost:8080/api/files/1710765661075-狂潮4.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"557\" height=\"537.86\"/></p><ul><li>耐磨性。狂潮4鞋底采用<a href=\"https://m.baidu.com/s?word=%E6%B0%B4%E6%B3%A5%E5%85%8B%E6%98%9F%E8%AE%BE%E8%AE%A1&amp;sa=re_dqa_zy\" target=\"_self\">水泥克星设计</a>，非常耐磨，适合在水泥地上穿着。</li></ul><ul><li>脚感。鞋底使用了<a href=\"https://m.baidu.com/s?word=%E5%85%A8%E6%8E%8C%E6%B0%AE%E7%A7%91%E6%8A%80&amp;sa=re_dqa_zy\" target=\"_self\">全掌氮科技</a>，脚感偏软，提供良好的包裹性和舒适性，适合正常脚型和瘦脚，但对于宽脚和高脚背的人来说，可能会感觉有些挤脚。</li></ul><ul><li>鞋楦设计。鞋楦偏窄，适合标准脚型和瘦脚，宽脚和高脚背的人可能会觉得不太合适。</li><li>透气性。鞋面透气性一般，夏天穿着可能会感觉有些热。</li><li>鞋面支撑。鞋面的支撑性能会随着使用时间的增加而有所下降，鞋头内侧的舒适度高，但长时间使用后支撑性可能会减弱，外侧则通过动态飞线和热贴加固，提供良好的侧向支撑。</li></ul><ul><li>启动性。鞋子的外侧TPU和内侧外底设计有浪形引导槽，有助于轻松启动和过渡，适合各种跑动和提速后的动作。</li></ul><p>总的来说，狂潮4是一款适合标准脚型和瘦脚的篮球鞋，具有较好的耐磨性和舒适的脚感，但在宽脚和高脚背的人穿着时可能会感觉有些不适。</p>', '狂潮系列是平民战靴', '1710765650531', '[\"休闲鞋\",\"通勤鞋\",\"篮球鞋\"]', 37, '2024-03-18 20:41:27', 125, 1, 101, '1');
INSERT INTO `blog` VALUES (21, '测评闪击10', '<h3>一、设计理念与外观展示</h3><p>ABAT085的设计灵感来源于英雄联盟中的无极剑圣，将游戏中的英雄元素巧妙地融入到鞋子的设计中，使得这款鞋子在外观上充满了电竞的魅力。同时，鞋面采用了纺织品与TPU的组合，既保证了鞋子的透气性，又增强了其稳定性。在配色上，ABAT085同样下足了功夫。无论是荧光鲜绿色、黑色、标准白还是嫩樱粉，都为穿着者提供了丰富的选择。特别是后跟的织带反光设计，不仅增添了时尚感，更能在昏暗的赛场上为球员提供一丝安全保障。</p><h3>二、科技加持，性能出众</h3><p><strong>GCU地面控制系统</strong>：这是李宁的顶级止滑大底科技，它采用了蜂窝抓地止滑设计，能够大幅度提升后跟的稳定性。在实际体验中，无论是在干燥的室内场地还是湿润的室外场地，GCU都能为穿着者提供出色的抓地力，有效防止滑倒。</p><p><strong>PROBARLOC全掌轻弹科技</strong>：这是李宁全新的前掌缓震技术，相较于上一代产品，前掌缓震性能提升了16%，后跟回弹性能提升了13%。在实际穿着中，可以明显感受到前掌的缓震效果更加出色，能够为球员提供更舒适的穿着体验。</p><p><strong>SOLIDSYSTEM鞋面束紧环抱系统</strong>：这是一种可调节的鞋面环抱装置，可以根据需要调整环抱松紧度，提升合脚性和舒适性。在实际体验中，我们发现这一系统确实能够有效地提升鞋子的包裹性，使得脚部在快速移动中依然能够得到稳定的支撑。</p><h3>三、舒适度与透气性</h3><p>ABAT085在舒适度上做得非常出色。鞋子的内部空间适中，既不会过于紧绷也不会过于宽松。同时，鞋垫采用了柔软的材料制成，能够有效地吸收冲击力，为脚部提供舒适的缓冲。</p><p>在透气性方面，鞋面采用了大面积的网布设计，能够有效地排出脚部的湿气和热量，保持脚部的干爽舒适。即使在激烈的比赛中，也不会出现脚部过热的情况。</p><h3>四、耐磨性与耐用性</h3><p>虽然有些用户反映鞋子在某些场地上耐磨性稍差，但总体来说，ABAT085在耐磨性和耐用性方面还是表现得相当不错的。鞋底的橡胶材质能够有效地抵抗磨损，延长鞋子的使用寿命。同时，鞋面的TPU材料也具有很好的抗撕裂性能，能够在激烈的比赛中保持鞋子的完整性。</p><h3>五、总结与建议</h3><p>总体来说，李宁ABAT085篮球鞋是一款性能出众、设计时尚的篮球鞋款。它凭借出色的抓地力、缓震性能和包裹性为穿着者提供了极致的穿着体验。虽然耐磨性方面有待加强但在其他方面的表现足以弥补这一不足。如果你是一位热爱篮球的朋友不妨尝试一下这款鞋子相信它会为你带来全新的赛场体验！</p>', '李宁旗舰篮球鞋闪击系列，闪击10新鞋测评', '1714618926821', '[\"篮球鞋\",\"通勤鞋\",\"休闲鞋\"]', 1, '2024-03-24 21:07:23', 26, 2, 21, '1');
INSERT INTO `blog` VALUES (22, '水花3测评', '<p>这次的水花3从设计、用料上对这些问题都进行了全方位升级！首先就是鞋面覆盖了大面积的TPU纱材料，非常透气，同时韧性十足。鞋面的内侧，大面积热熔压胶的材质起到了防踢的作用。鞋带扣周围同样是有着热熔的加固。作为一双中帮球鞋，一共是有6组鞋带扣，辅以在水花2身上备受好评的可拆卸魔术贴绑带。后跟的内置填充非常厚实，港宝面积也相当可观。<br/></p><p>对比前作，鞋面可以说在强度上做了肉眼可见的升级。外底同样不含糊，水波纹的纹路，搭配上厚实的橡胶外底，妥妥的外场标配。</p><p>中底更是令人惊喜，和KT6一样的全掌ALTI-FLASH材质，软韧兼顾，同时这双鞋用到的是加厚的鞋垫，这无疑可以使得脚感更加软弹。</p><p>足弓位置用到了名为A-shock stablizer的抗扭配置。可以看到这块面积巨大的足弓支撑板直接延伸到了后跟的位置，让鞋面与大底间的一体性更加出色。<br/></p><p>这双鞋上脚之后给我留下的第一反应就是透气真的太出色了，这几天恰好北京风很大，穿出街之后可以感受到非常明显的透气性。</p><p>我们一直在说实战鞋的透气性和支撑性很难兼得，但是这次的水花三代却是给我带来了很大的惊喜。</p>', '透气、耐磨、有脚感、性能不错，还要便宜有颜值', '1714619627708', '[\"篮球鞋\",\"休闲鞋\"]', 37, '2024-05-02 11:08:37', 18, 1, 15, '1');
INSERT INTO `blog` VALUES (24, '韦德之道808', '<p>鞋垫的中足部分则是一块异型的Probarloc承托盘来提供足弓支撑，真的求求了不要再说什么抗扭片了，这是PROBAR LOC的科技吊牌，上面清清楚楚写着：嵌入中底足弓处连接前掌及后跟的稳定装置，可以令足弓在运动的每一步中得到适当的支撑及保护，提高稳定性，降低足弓疲劳。<br/></p>', '国产球鞋第一次使用可替换式中底直接组合鞋面的篮球鞋', '1714620183084', '[\"篮球鞋\",\"通勤鞋\"]', 37, '2024-05-02 11:24:01', 0, 2, 0, '1');
INSERT INTO `blog` VALUES (25, '水花3', '<p>这次的水花3从设计、用料上对这些问题都进行了全方位升级！首先就是鞋面覆盖了大面积的TPU纱材料，非常透气，同时韧性十足。鞋面的内侧，大面积热熔压胶的材质起到了防踢的作用。鞋带扣周围同样是有着热熔的加固。作为一双中帮球鞋，一共是有6组鞋带扣，辅以在水花2身上备受好评的可拆卸魔术贴绑带。后跟的内置填充非常厚实，港宝面积也相当可观。<br/><br/>对比前作，鞋面可以说在强度上做了肉眼可见的升级。外底同样不含糊，水波纹的纹路，搭配上厚实的橡胶外底，妥妥的外场标配。<br/><br/>中底更是令人惊喜，和KT6一样的全掌ALTI-FLASH材质，软韧兼顾，同时这双鞋用到的是加厚的鞋垫，这无疑可以使得脚感更加软弹。<br/><br/>足弓位置用到了名为A-shock stablizer的抗扭配置。可以看到这块面积巨大的足弓支撑板直接延伸到了后跟的位置，让鞋面与大底间的一体性更加出色。<br/><br/>这双鞋上脚之后给我留下的第一反应就是透气真的太出色了，这几天恰好北京风很大，穿出街之后可以感受到非常明显的透气性。<br/><br/>我们一直在说实战鞋的透气性和支撑性很难兼得，但是这次的水花三代却是给我带来了很大的惊喜。</p>', '安踏水花3测评，一款耐打的篮球鞋', '1714620693084', '[\"篮球鞋\"]', 12, '2024-05-02 11:31:35', 0, 1, 0, '1');
INSERT INTO `blog` VALUES (26, '水花3', '<p>这次的水花3从设计、用料上对这些问题都进行了全方位升级！首先就是鞋面覆盖了大面积的TPU纱材料，非常透气，同时韧性十足。鞋面的内侧，大面积热熔压胶的材质起到了防踢的作用。鞋带扣周围同样是有着热熔的加固。作为一双中帮球鞋，一共是有6组鞋带扣，辅以在水花2身上备受好评的可拆卸魔术贴绑带。后跟的内置填充非常厚实，港宝面积也相当可观。<br/><br/>对比前作，鞋面可以说在强度上做了肉眼可见的升级。外底同样不含糊，水波纹的纹路，搭配上厚实的橡胶外底，妥妥的外场标配。<br/><br/>中底更是令人惊喜，和KT6一样的全掌ALTI-FLASH材质，软韧兼顾，同时这双鞋用到的是加厚的鞋垫，这无疑可以使得脚感更加软弹。<br/><br/>足弓位置用到了名为A-shock stablizer的抗扭配置。可以看到这块面积巨大的足弓支撑板直接延伸到了后跟的位置，让鞋面与大底间的一体性更加出色。<br/><br/>这双鞋上脚之后给我留下的第一反应就是透气真的太出色了，这几天恰好北京风很大，穿出街之后可以感受到非常明显的透气性。<br/><br/>我们一直在说实战鞋的透气性和支撑性很难兼得，但是这次的水花三代却是给我带来了很大的惊喜。</p>', '这次的水花三代却是给我带来了很大的惊喜', NULL, '[\"篮球鞋\"]', 33, '2024-05-02 11:40:09', 1, 1, 1, '1');
INSERT INTO `blog` VALUES (27, '闪现3', '<p>颜值：整体颜值的话这个配色可以打个7.5分，很清爽的豆绿配色，在国产鞋里也算中等偏上的存在了，流线型的设计，鞋舌处有可爱涂鸦底部还有很细节的泼墨设计。<br/></p><p>鞋盒：收到货之后这一款的鞋盒还是蛮好看的个黑色的鞋盒中间有一块三角透明部分有着匹克标志logo。<br/></p><p>鞋舌：很轻薄的设计有固定孔实战后也没有位移的情况。</p><p>鞋跟：有海绵垫和提手方便穿脱增强包裹性还有一圈防撞条的设计。</p><p>鞋底:橡胶大底TPU抗扭片纤维碳板匹克态极缓震SUPER.P-MOTIVE科技。<br/></p><p>重量：使用家里的电子秤，单只355g重量。</p><p>　　脚感：个人实战脚感中等回弹防滑和耐磨，非常nice，整体鞋型偏窄包裹感蛮强第一次实战有明显挤压感，第二次就好很多。</p><p>　　接下来说说缺点，主要是包裹的问题。我选择的是平常us码，开始两天包裹还好，但是后来越穿越宽松，越穿越肥大，但是鞋带没有办法解决这个问题，首先鞋带摩擦力太大了，很难拉到最紧；其次就算鞋带拉紧，也会在第一组鞋带孔处产生很高的凸起，导致前掌包裹的缺乏。</p>', '很清爽的豆绿配色，在国产鞋里也算中等偏上的存在了', NULL, '[\"篮球鞋\"]', 12, '2024-05-02 12:26:39', 0, 5, 0, '-1');
INSERT INTO `blog` VALUES (28, '安踏狂潮4', '<ul><li>耐磨性。狂潮4鞋底采用<a href=\"https://m.baidu.com/s?word=%E6%B0%B4%E6%B3%A5%E5%85%8B%E6%98%9F%E8%AE%BE%E8%AE%A1&amp;sa=re_dqa_zy\" target=\"_self\">水泥克星设计</a>，非常耐磨，适合在水泥地上穿着。</li></ul><ul><li>脚感。鞋底使用了<a href=\"https://m.baidu.com/s?word=%E5%85%A8%E6%8E%8C%E6%B0%AE%E7%A7%91%E6%8A%80&amp;sa=re_dqa_zy\" target=\"_self\">全掌氮科技</a>，脚感偏软，提供良好的包裹性和舒适性，适合正常脚型和瘦脚，但对于宽脚和高脚背的人来说，可能会感觉有些挤脚。</li></ul><ul><li>鞋楦设计。鞋楦偏窄，适合标准脚型和瘦脚，宽脚和高脚背的人可能会觉得不太合适。</li><li>透气性。鞋面透气性一般，夏天穿着可能会感觉有些热。</li><li>鞋面支撑。鞋面的支撑性能会随着使用时间的增加而有所下降，鞋头内侧的舒适度高，但长时间使用后支撑性可能会减弱，外侧则通过动态飞线和热贴加固，提供良好的侧向支撑。</li></ul><ul><li>启动性。鞋子的外侧TPU和内侧外底设计有浪形引导槽，有助于轻松启动和过渡，适合各种跑动和提速后的动作。</li></ul><p>总的来说，狂潮4是一款适合标准脚型和瘦脚的篮球鞋，具有较好的耐磨性和舒适的脚感，但在宽脚和高脚背的人穿着时可能会感觉有些不适。</p>', '新一代水泥战靴，狂潮4', NULL, '[\"篮球鞋\",\"休闲鞋\",\"通勤鞋\"]', 12, '2024-05-02 16:33:12', 0, 1, 0, '-1');
INSERT INTO `blog` VALUES (36, '测试测试测试', '<p>测试测试测试测试测试测试</p>', '测试测试测试测试测试测试', NULL, '[\"足球鞋\"]', 1, '2024-05-09 21:31:05', 0, 2, 0, '1');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '目录名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '安踏');
INSERT INTO `category` VALUES (2, '李宁');
INSERT INTO `category` VALUES (3, 'Nike');
INSERT INTO `category` VALUES (4, '361°');
INSERT INTO `category` VALUES (5, '匹克');
INSERT INTO `category` VALUES (7, '特步');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` int NULL DEFAULT NULL COMMENT '评论的文章ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论的内容',
  `user_id` int NULL DEFAULT NULL COMMENT '评论人ID',
  `pid` int NULL DEFAULT NULL COMMENT '父级评论',
  `target_id` int NULL DEFAULT NULL COMMENT '回复对象的ID',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (32, 18, '好鞋', 1, 0, 0, '2024-03-24 11:18:24');
INSERT INTO `comment` VALUES (33, 18, '点赞', 1, 32, 0, '2024-03-24 11:18:35');
INSERT INTO `comment` VALUES (34, 11, '什么玩意', 1, 0, 0, '2024-03-24 11:18:48');
INSERT INTO `comment` VALUES (35, 16, '点赞+收藏', 1, 0, 0, '2024-03-24 11:19:01');
INSERT INTO `comment` VALUES (36, 17, '来波666', 1, 0, 0, '2024-03-24 11:19:10');
INSERT INTO `comment` VALUES (37, 18, '你是会宣传的', 37, 32, 33, '2024-03-24 11:19:53');
INSERT INTO `comment` VALUES (38, 18, '点赞+收藏一波', 37, 32, 33, '2024-03-24 11:20:02');
INSERT INTO `comment` VALUES (39, 18, '点赞+收藏一波', 37, 0, 0, '2024-03-24 11:20:38');
INSERT INTO `comment` VALUES (40, 17, '可以', 37, 0, 0, '2024-03-24 11:23:47');
INSERT INTO `comment` VALUES (41, 17, '666', 37, 36, 0, '2024-03-24 11:23:55');
INSERT INTO `comment` VALUES (42, 17, '恐怖如斯', 37, 36, 0, '2024-03-24 11:24:05');
INSERT INTO `comment` VALUES (43, 14, '一叶知秋？？', 37, 0, 0, '2024-03-24 11:27:07');
INSERT INTO `comment` VALUES (44, 14, '对', 12, 43, 0, '2024-03-24 11:27:56');
INSERT INTO `comment` VALUES (45, 14, '啥玩意', 12, 0, 0, '2024-03-24 11:28:09');
INSERT INTO `comment` VALUES (46, 16, '好咯\n', 12, 35, 0, '2024-03-24 11:28:25');
INSERT INTO `comment` VALUES (47, 17, '666', 12, 36, 41, '2024-03-24 11:28:36');
INSERT INTO `comment` VALUES (48, 17, '确实不平民', 12, 0, 0, '2024-03-24 11:28:53');
INSERT INTO `comment` VALUES (54, 18, '厉害厉害\n', 3, 0, 0, '2024-03-24 11:39:32');
INSERT INTO `comment` VALUES (55, 17, '贵贵贵', 3, 0, 0, '2024-03-24 11:43:33');
INSERT INTO `comment` VALUES (58, 16, '好鞋好鞋', 12, 0, 0, '2024-03-24 11:52:38');
INSERT INTO `comment` VALUES (59, 7, '好', 37, 0, 0, '2024-05-02 16:34:05');
INSERT INTO `comment` VALUES (60, 12, '好，666\n', 37, 0, 0, '2024-05-02 16:34:24');

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作时间',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人IP',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 219 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (1, '删除用户操作', '2024-03-07 17:32:37', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (3, '删除用户操作', '2024-03-07 17:44:03', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (4, '用户登录', '2024-03-07 17:51:13', '阮经天', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (8, '用户登录', '2024-03-07 17:55:40', '火云邪神', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (9, '用户登录', '2024-03-07 19:51:48', '疯狂的石头', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (10, '用户登录', '2024-03-07 19:57:22', '叶秋', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (39, '用户登录', '2024-03-10 20:18:37', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (41, '用户登录', '2024-03-11 20:41:45', '张颂文', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (44, '用户登录', '2024-03-11 21:16:52', '肯德基', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (46, '用户登录', '2024-03-11 21:51:02', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (56, '用户登录', '2024-03-13 21:36:14', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (91, '用户登录', '2024-03-18 17:00:26', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (94, '用户登录', '2024-03-19 09:52:59', '周树人', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (102, '用户登录', '2024-03-19 16:14:39', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (104, '用户登录', '2024-03-19 21:25:35', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (105, '用户登录', '2024-03-19 21:53:36', '周树人', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (106, '用户登录', '2024-03-19 21:55:09', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (107, '用户登录', '2024-03-20 09:25:24', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (108, '用户登录', '2024-03-20 14:29:57', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (109, '用户登录', '2024-03-20 15:23:09', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (110, '用户登录', '2024-03-20 17:23:39', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (111, '用户登录', '2024-03-21 09:35:23', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (112, '用户登录', '2024-03-21 10:35:13', '李四', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (113, '用户登录', '2024-03-21 12:03:10', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (114, '用户登录', '2024-03-21 14:50:10', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (115, '用户登录', '2024-03-21 17:08:38', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (116, '用户登录', '2024-03-21 17:58:48', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (117, '用户登录', '2024-03-21 19:38:15', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (118, '用户登录', '2024-03-21 19:51:00', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (119, '用户登录', '2024-03-21 19:57:06', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (120, '用户登录', '2024-03-22 09:43:38', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (121, '用户登录', '2024-03-22 11:44:04', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (122, '用户登录', '2024-03-22 14:33:11', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (123, '用户登录', '2024-03-22 16:40:15', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (124, '用户登录', '2024-03-22 19:26:20', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (125, '用户登录', '2024-03-22 20:29:57', '周树人', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (126, '用户登录', '2024-03-22 20:30:46', '甄子丹', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (127, '用户登录', '2024-03-23 10:38:15', '张颂文', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (128, '用户登录', '2024-03-23 11:01:05', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (129, '用户登录', '2024-03-24 10:22:26', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (130, '用户登录', '2024-03-24 11:19:31', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (131, '用户登录', '2024-03-24 11:27:46', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (132, '用户登录', '2024-03-24 11:30:20', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (133, '用户登录', '2024-03-24 11:38:29', '甄子丹', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (134, '用户登录', '2024-03-24 11:39:08', '李连杰', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (135, '用户登录', '2024-03-24 11:46:11', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (136, '用户登录', '2024-03-24 11:59:15', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (137, '用户登录', '2024-03-24 15:26:24', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (138, '用户登录', '2024-03-24 19:30:49', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (139, '用户登录', '2024-03-24 21:52:11', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (140, '用户登录', '2024-03-25 09:44:43', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (141, '用户登录', '2024-03-25 11:27:31', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (142, '用户登录', '2024-03-25 14:40:28', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (143, '用户登录', '2024-03-25 19:07:47', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (144, '用户登录', '2024-03-25 21:09:05', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (145, '用户登录', '2024-03-25 21:38:26', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (146, '用户登录', '2024-03-26 09:30:21', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (147, '用户登录', '2024-03-26 11:35:26', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (148, '用户登录', '2024-03-26 11:39:17', '甄子丹', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (149, '用户登录', '2024-03-26 12:10:51', '甄子丹', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (150, '用户登录', '2024-03-26 14:35:11', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (151, '用户登录', '2024-03-26 15:31:54', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (152, '用户登录', '2024-03-26 15:32:14', '甄子丹', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (153, '用户登录', '2024-03-26 15:32:36', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (154, '用户登录', '2024-03-27 17:48:23', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (155, '用户登录', '2024-03-28 10:42:56', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (156, '用户登录', '2024-03-29 10:41:12', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (157, '用户登录', '2024-03-29 14:31:41', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (158, '用户登录', '2024-03-29 15:23:25', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (159, '用户登录', '2024-03-29 15:24:16', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (160, '用户登录', '2024-03-29 15:25:28', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (161, '用户登录', '2024-03-29 15:58:11', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (162, '用户登录', '2024-03-30 09:43:33', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (163, '用户登录', '2024-03-30 11:33:33', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (164, '用户登录', '2024-03-30 14:57:40', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (165, '用户登录', '2024-03-30 16:39:22', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (166, '用户登录', '2024-04-04 18:51:17', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (167, '用户登录', '2024-04-08 19:05:19', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (168, '用户登录', '2024-04-09 14:26:59', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (169, '用户登录', '2024-04-09 17:41:06', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (170, '用户登录', '2024-04-09 21:27:02', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (171, '用户登录', '2024-04-10 14:58:56', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (172, '用户登录', '2024-04-10 22:56:24', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (173, '用户登录', '2024-04-10 23:14:15', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (174, '用户登录', '2024-04-11 10:47:59', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (175, '用户登录', '2024-04-11 10:48:48', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (176, '用户登录', '2024-04-11 10:57:36', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (177, '用户登录', '2024-04-11 10:58:27', '李连杰', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (178, '用户登录', '2024-04-11 10:58:54', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (179, '用户登录', '2024-04-11 17:20:29', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (180, '用户登录', '2024-04-12 11:53:19', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (181, '用户登录', '2024-04-24 21:10:03', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (182, '用户登录', '2024-05-01 13:54:50', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (183, '用户登录', '2024-05-02 10:51:09', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (184, '用户登录', '2024-05-02 11:06:02', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (185, '用户登录', '2024-05-02 11:30:39', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (186, '用户登录', '2024-05-02 11:39:11', '疯狂的石头', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (187, '用户登录', '2024-05-02 11:52:34', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (188, '用户登录', '2024-05-02 12:26:02', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (189, '用户登录', '2024-05-02 16:30:47', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (190, '用户登录', '2024-05-02 16:32:26', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (191, '用户登录', '2024-05-02 16:33:53', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (192, '用户登录', '2024-05-03 09:28:06', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (193, '用户登录', '2024-05-03 10:01:44', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (194, '用户登录', '2024-05-03 10:05:02', '包子', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (195, '用户登录', '2024-05-03 10:15:18', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (196, '用户登录', '2024-05-03 10:48:28', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (197, '用户登录', '2024-05-03 10:49:06', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (198, '用户登录', '2024-05-03 11:03:10', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (199, '用户登录', '2024-05-03 14:41:27', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (200, '用户登录', '2024-05-03 14:42:00', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (201, '用户登录', '2024-05-03 14:42:35', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (202, '用户登录', '2024-05-06 15:51:59', 'cess', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (203, '用户登录', '2024-05-06 16:00:25', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (204, '用户登录', '2024-05-06 16:03:46', '李清照', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (205, '用户登录', '2024-05-06 16:04:33', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (206, '用户登录', '2024-05-06 17:48:37', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (207, '用户登录', '2024-05-06 20:13:15', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (208, '用户登录', '2024-05-06 20:28:50', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (209, '用户登录', '2024-05-08 18:53:19', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (210, '删除用户操作', '2024-05-08 19:01:45', '', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (211, '删除用户操作', '2024-05-08 19:01:47', '', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (212, '用户登录', '2024-05-08 19:18:23', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (213, '用户登录', '2024-05-09 21:03:17', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (214, '用户登录', '2024-05-09 21:07:54', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (215, '用户登录', '2024-05-09 21:19:52', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (216, '删除用户操作', '2024-05-09 21:25:49', '', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (217, '删除用户操作', '2024-05-09 21:25:50', '', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (218, '用户登录', '2024-05-09 21:29:09', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (219, '用户登录', '2024-05-11 19:15:39', 'admin', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告内容',
  `create_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今日上新', '会员权益', '2024-03-29 11:49:37');
INSERT INTO `notice` VALUES (2, '今日上新', '平台上线20+新鞋测评', '2024-03-29 11:50:37');
INSERT INTO `notice` VALUES (4, '最新公告', '充值12个月会员赠送12个月', '2024-03-29 16:02:52');

-- ----------------------------
-- Table structure for peoplelike
-- ----------------------------
DROP TABLE IF EXISTS `peoplelike`;
CREATE TABLE `peoplelike`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` int NULL DEFAULT NULL COMMENT '博客ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `peolike` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '点赞',
  `collect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户点赞收藏文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of peoplelike
-- ----------------------------
INSERT INTO `peoplelike` VALUES (18, 17, 37, '1', '1');
INSERT INTO `peoplelike` VALUES (21, 7, 1, '1', '0');
INSERT INTO `peoplelike` VALUES (22, 13, 1, '1', '1');
INSERT INTO `peoplelike` VALUES (23, 17, 1, '1', '1');
INSERT INTO `peoplelike` VALUES (24, 16, 1, '1', '1');
INSERT INTO `peoplelike` VALUES (25, 18, 1, '1', '1');
INSERT INTO `peoplelike` VALUES (26, 17, 2, '1', '0');
INSERT INTO `peoplelike` VALUES (27, 16, 2, '1', '1');
INSERT INTO `peoplelike` VALUES (28, 18, 2, '1', '0');
INSERT INTO `peoplelike` VALUES (29, 16, 3, '1', '0');
INSERT INTO `peoplelike` VALUES (30, 17, 3, '1', '0');
INSERT INTO `peoplelike` VALUES (31, 18, 3, '1', '0');
INSERT INTO `peoplelike` VALUES (32, 14, 3, '1', '0');
INSERT INTO `peoplelike` VALUES (33, 9, 3, '1', '1');
INSERT INTO `peoplelike` VALUES (34, 7, 3, '1', '0');
INSERT INTO `peoplelike` VALUES (36, 11, 12, '1', '0');
INSERT INTO `peoplelike` VALUES (37, 16, 12, '1', '1');
INSERT INTO `peoplelike` VALUES (38, 14, 12, '1', '0');
INSERT INTO `peoplelike` VALUES (39, 9, 1, '1', '0');
INSERT INTO `peoplelike` VALUES (40, 7, 2, '1', '0');
INSERT INTO `peoplelike` VALUES (41, 12, 1, '1', '0');
INSERT INTO `peoplelike` VALUES (42, 7, 37, '1', '0');
INSERT INTO `peoplelike` VALUES (43, 10, 37, '1', '1');
INSERT INTO `peoplelike` VALUES (44, 12, 37, '1', '0');
INSERT INTO `peoplelike` VALUES (45, 21, 1, '1', '0');
INSERT INTO `peoplelike` VALUES (46, 10, 1, '1', '0');

-- ----------------------------
-- Table structure for sessioncontent
-- ----------------------------
DROP TABLE IF EXISTS `sessioncontent`;
CREATE TABLE `sessioncontent`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `session_id` int NULL DEFAULT NULL COMMENT '会话id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会话内容',
  `user_id` int NULL DEFAULT NULL COMMENT '内容发出用户',
  `target_user_id` int NULL DEFAULT NULL COMMENT '内容接收用户',
  `create_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发出时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessioncontent
-- ----------------------------
INSERT INTO `sessioncontent` VALUES (1, 1, '在吗，2', 1, 2, '2024-03-25 20:01:47');
INSERT INTO `sessioncontent` VALUES (2, 1, '在，1', 2, 1, '2024-03-25 20:02:32');
INSERT INTO `sessioncontent` VALUES (3, 2, '在吗，3', 1, 3, '2024-03-25 19:59:26');
INSERT INTO `sessioncontent` VALUES (7, 1, '在干嘛呢\n', 1, 2, '2024-03-25 22:01:49');
INSERT INTO `sessioncontent` VALUES (8, 1, '回宿舍咯', 1, 2, '2024-03-25 22:02:49');
INSERT INTO `sessioncontent` VALUES (9, 1, '我现在回去\n', 1, 2, '2024-03-25 22:03:42');
INSERT INTO `sessioncontent` VALUES (10, 3, '杨师傅这么看\n', 2, 4, '2024-03-26 11:57:09');
INSERT INTO `sessioncontent` VALUES (11, 3, '在吗\n', 2, 4, '2024-03-26 11:58:05');
INSERT INTO `sessioncontent` VALUES (12, 3, '??\n', 2, 4, '2024-03-26 15:32:22');
INSERT INTO `sessioncontent` VALUES (16, 8, '你好', 12, 2, '2024-04-11 10:53:46');
INSERT INTO `sessioncontent` VALUES (17, 2, '有什么想问的吗\n', 3, 3, '2024-04-11 10:58:44');
INSERT INTO `sessioncontent` VALUES (18, 9, '你好\n', 12, 37, '2024-05-03 10:04:49');
INSERT INTO `sessioncontent` VALUES (19, 9, '早上好\n', 37, 37, '2024-05-03 10:14:33');
INSERT INTO `sessioncontent` VALUES (20, 5, '评测很不错\n', 37, 37, '2024-05-03 10:14:50');
INSERT INTO `sessioncontent` VALUES (21, 5, '谢谢\n', 1, 37, '2024-05-03 10:17:30');
INSERT INTO `sessioncontent` VALUES (22, 7, '测评很好\n', 12, 12, '2024-05-06 16:03:57');
INSERT INTO `sessioncontent` VALUES (23, 7, '谢谢\n', 1, 12, '2024-05-06 16:04:52');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户类型',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `login_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录时间',
  `create_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '超级管理员', '123456', '管理员', 24, '男', '1709955503235', '18888888888', '1111111111@qq.com', '2024-05-11 19:15:39', '2024-03-09', '2024-05-11 19:15:39');
INSERT INTO `user` VALUES (2, '甄子丹', '叶问', '123456', '管理员', 41, '男', '1709812514131', '19999999999', NULL, '2024-03-26 15:32:14', '2024-03-08', '2024-03-26 15:32:14');
INSERT INTO `user` VALUES (3, '李连杰', '黄飞鸿', '123456', '用户', 30, '男', NULL, '18888888888', NULL, '2024-04-11 10:58:27', '2024-03-08', '2024-04-11 10:58:27');
INSERT INTO `user` VALUES (4, '杨紫琼', '杨紫琼', '123456', '用户', 50, '女', NULL, '17777777777', NULL, NULL, '2024-03-02', NULL);
INSERT INTO `user` VALUES (5, '张无忌', '张无忌', '123456', '用户', 18, '男', NULL, '17777777777', NULL, NULL, '2024-03-02', NULL);
INSERT INTO `user` VALUES (6, '李四', '李四', '123456', '用户', 22, '女', '1709638798755', '18888888888', NULL, '2024-03-21 10:35:13', '2024-03-05', '2024-03-21 10:35:13');
INSERT INTO `user` VALUES (7, '赵德刚', '赵德刚1', '123456', '用户', 27, '男', NULL, '19988888899', NULL, NULL, '2024-03-03', NULL);
INSERT INTO `user` VALUES (9, '孟浩然', '孟氏', '123456', '用户', 38, '男', NULL, '17777788899', NULL, NULL, '2024-03-05', NULL);
INSERT INTO `user` VALUES (10, '李白', '李氏', '123456', '用户', 38, '男', NULL, '17777788899', NULL, NULL, '2024-03-05', NULL);
INSERT INTO `user` VALUES (11, '苏轼', '苏氏', '123456', '用户', 30, '男', NULL, '17777788899', NULL, NULL, '2024-03-05', NULL);
INSERT INTO `user` VALUES (12, '李清照', '李清照', '123456', '用户', 30, '女', '1714701719806', '12222222222', '222222222@qq.com', '2024-05-06 16:03:46', '2024-03-04', '2024-05-06 16:03:46');
INSERT INTO `user` VALUES (13, '刘勇', '耳根', '123456', '管理员', 35, '男', NULL, '15555555555', '333333333@qq.com', '2024-03-07 12:12:22', '2024-03-04', NULL);
INSERT INTO `user` VALUES (14, '老鹰捉小鸡', '修仙老祖', '123456', '用户', 29, '男', NULL, '11155555555', NULL, NULL, '2024-03-06', NULL);
INSERT INTO `user` VALUES (15, '张颂文', '高启强', '111111', '用户', 37, '男', '1709642589577', '12288800999', NULL, '2024-03-23 10:38:16', '2024-03-07', '2024-03-23 10:38:16');
INSERT INTO `user` VALUES (22, '1111', '11112', '123456', '管理员', 30, '男', NULL, '18888888888', '111111111@qq.com', NULL, '2024-03-06', NULL);
INSERT INTO `user` VALUES (25, '4441', '44332', '123123', '用户', 23, '女', NULL, '18999988888', '111111111@qq.com', NULL, '2024-03-04', '2024-03-11 21:11:34');
INSERT INTO `user` VALUES (26, '5551', '55221', '121212', '用户', 12, '男', NULL, '19911111111', '111111111@qq.com', '2024-03-07 15:11:10', '2024-03-05', '2024-03-11 21:17:49');
INSERT INTO `user` VALUES (27, '王昌龄', '边塞诗人', '111111', '用户', 37, '男', NULL, '13322233355', NULL, '2024-03-07 15:07:51', '2024-03-07', NULL);
INSERT INTO `user` VALUES (28, '周树人', '鲁迅', '333333', '用户', 35, '男', '1709781092975', '15522233355', '22222222222@qq.com', '2024-03-22 20:29:57', '2024-03-07', '2024-03-22 20:29:57');
INSERT INTO `user` VALUES (30, '阮经天', '陈桂林', '123456', '管理员', 22, '男', NULL, '17777777777', '1777@qq.com', '2024-03-07 17:51:13', '2024-03-07', '2024-03-07 17:51:13');
INSERT INTO `user` VALUES (32, '火云邪神', '小龙', '222222', '用户', 33, '男', NULL, '12222222222', NULL, '2024-03-07 17:55:40', '2024-03-07', '2024-03-07 17:55:40');
INSERT INTO `user` VALUES (33, '疯狂的石头', '小白鞋_5j30e6', '123456', '用户', 19, '男', '1709812514131', '1111111111', NULL, '2024-05-02 11:39:11', '2024-03-10', '2024-05-02 11:39:11');
INSERT INTO `user` VALUES (34, '叶秋', '小白鞋_gebcaz', '222222', '用户', 25, '男', '1709812514131', '12222222333', NULL, '2024-03-07 19:57:22', '2024-03-07', '2024-03-07 19:57:22');
INSERT INTO `user` VALUES (35, '肯德基', '小白鞋_7mdzj9', '111111', '用户', 100, '男', '1709812514131', '13333333333', NULL, '2024-03-11 21:16:52', '2024-03-11', '2024-03-11 21:16:52');
INSERT INTO `user` VALUES (36, '樱桃小丸子', '小白鞋_tm29ja', '222222', '用户', 12, '女', '1709812514131', '16666666666', NULL, NULL, '2024-03-11', NULL);
INSERT INTO `user` VALUES (37, '包子', '小白鞋_1xtven', '222222', '用户', 22, '男', '1709812514131', '15555555555', NULL, '2024-05-03 10:05:02', '2024-03-12', '2024-05-03 10:05:02');
INSERT INTO `user` VALUES (38, '苏沐橙', '小白鞋_bp6vav', '666666', '用户', 19, '女', '1709812514131', '16666666666', NULL, NULL, '2024-03-12', NULL);
INSERT INTO `user` VALUES (39, '黎明', '小白鞋_1cmrps', '111111', '用户', 40, '男', '1709812514131', '11111111111', NULL, NULL, '2024-03-12', NULL);
INSERT INTO `user` VALUES (40, '邓紫棋', '小白鞋_yzgsj3', '111111', '用户', 34, '女', '1709812514131', '15555555555', NULL, NULL, '2024-03-12', NULL);
INSERT INTO `user` VALUES (41, '张靓颖', '小白鞋_x4ha3s', '222222', '用户', 33, '女', '1709812514131', '11111111111', NULL, NULL, '2024-03-12', '2024-03-23 10:36:34');
INSERT INTO `user` VALUES (42, 'asd', 'asda', '123456', '用户', 21, '男', NULL, NULL, NULL, NULL, '2024-03-13', NULL);
INSERT INTO `user` VALUES (43, '橙留香', '小白鞋_3zmjxi', '111111', '用户', 12, '男', '1709812514131', '13380932094', NULL, NULL, '2024-03-23', NULL);
INSERT INTO `user` VALUES (44, '陆小果', '小白鞋_oqcsz9', '123456', '用户', 13, '男', '1709812514131', '13380932094', NULL, NULL, '2024-03-23', NULL);
INSERT INTO `user` VALUES (52, '测试1', NULL, '123456', '用户', NULL, '男', NULL, NULL, NULL, NULL, '2024-05-09', NULL);
INSERT INTO `user` VALUES (53, '测试2', NULL, '123456', '管理员', NULL, '女', NULL, NULL, NULL, NULL, '2024-05-09', NULL);

-- ----------------------------
-- Table structure for usersession
-- ----------------------------
DROP TABLE IF EXISTS `usersession`;
CREATE TABLE `usersession`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `target_user_id` int NULL DEFAULT NULL COMMENT '对象id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usersession
-- ----------------------------
INSERT INTO `usersession` VALUES (1, 1, 2);
INSERT INTO `usersession` VALUES (2, 1, 3);
INSERT INTO `usersession` VALUES (3, 2, 4);
INSERT INTO `usersession` VALUES (4, 2, 37);
INSERT INTO `usersession` VALUES (5, 1, 37);
INSERT INTO `usersession` VALUES (6, 1, 34);
INSERT INTO `usersession` VALUES (7, 1, 12);
INSERT INTO `usersession` VALUES (8, 12, 2);
INSERT INTO `usersession` VALUES (9, 12, 37);

SET FOREIGN_KEY_CHECKS = 1;
