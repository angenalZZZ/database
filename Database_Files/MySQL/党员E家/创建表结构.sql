CREATE TABLE `PartyCreditRuleSettings` (
	`Id` char(36) NOT NULL,
  `LastModificationTime` datetime(6) DEFAULT NULL,
  `LastModifierUserId` char(36) DEFAULT NULL,
	`Action` varchar(20) NOT NULL COMMENT '策略唯一标识Key',
	`ActionType` int NOT NULL COMMENT '获取积分的方式', 
	`RuleType` int NOT NULL COMMENT '获取积分的是党员还是组织', 
	`RuleName` varchar(200) NOT NULL COMMENT '策略名称',
	`FuncName` varchar(50) NOT NULL COMMENT '功能名称',
	`CycleType` int NOT NULL COMMENT '周期:0.一次;1.每天;2.整点;3.间隔分钟;4.不限;5.每月;6.每季度;7每年', 
	`CycleTime` int NOT NULL COMMENT '周期内 间隔时间-小时|分钟 对应周期2-3', 
	`CycleRewardNum` int NOT NULL COMMENT '周期内 奖励次数 最多奖励次数:0为不限次数', 
	`CycleCreditS1` float NOT NULL COMMENT '周期内 每次奖励 获得积分数',
	`CycleCreditMaxS1` float NOT NULL COMMENT '周期内 奖励N次 获得的积分数上限:0为不限数',
	`CreditMaxS1` float NOT NULL COMMENT '全年总积分数上限:0为不限数',
	`InBlackList` bit(1) NOT NULL COMMENT '拉入黑名单，不再获取积分', 
	`NotShopping` bit(1) NOT NULL COMMENT '不得使用积分商城', 
	PRIMARY KEY (`Id`),
  KEY `Action` (`Action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分规则设置';

CREATE TABLE `PartyCreditRuleLog` (
	`Id` char(36) NOT NULL,
	`RuleId` char(36) NOT null COMMENT '积分规则ID',
	`Action` varchar(20) NOT NULL COMMENT '策略唯一标识Key',
	`ActionType` int NOT NULL COMMENT '获取积分的方式', 
	`RuleType` int NOT NULL COMMENT '获取积分的是党员还是组织', 
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`OrgId` char(36) NOT NULL COMMENT '党组织-组织ID',
	`Total` int NOT NULL COMMENT '策略被执行总次数', 
	`TotalCreditS1` float NOT NULL COMMENT '策略累计总积分数 小于等于 全年积分数上限',
	`CycleNum` int NOT NULL COMMENT '周期被执行次数',
	`TotalCycleCreditS1` float NOT NULL COMMENT '周期内累计总积分数',
	`StartTime` datetime(6) NOT NULL COMMENT '周期开始时间',
	`DateLine` datetime(6) NOT NULL COMMENT '策略最后执行时间',
	PRIMARY KEY (`Id`),
  KEY `Action` (`Action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分规则日志表(积分记录表的汇总);用于处理积分的计算逻辑';

CREATE TABLE `PartyCreditAssessmentSettings` (
	`Id` char(36) NOT NULL,
  `CreationTime` datetime(6) NOT NULL,
  `CreatorUserId` char(36) DEFAULT NULL,
  `LastModificationTime` datetime(6) DEFAULT NULL,
  `LastModifierUserId` char(36) DEFAULT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `DeleterUserId` char(36) DEFAULT NULL,
  `DeletionTime` datetime(6) DEFAULT NULL,
	`PartyMemeberAssess` varchar(100) NOT NULL COMMENT '考核对象：正式党员,预备党员,发展对象,入党积极分子,党组织书记和班子成员,仅考核线下积分学员',
	`PassTotalScore` float NOT NULL COMMENT '总积分最低要求（年）',
	`StudyPassTotalScore` float NOT NULL COMMENT '集中学习培训积分最低要求（年）',
	`MustStudy` bit(1) NOT NULL COMMENT '必修课学习', 
  PRIMARY KEY (`Id`),
  KEY `PartyMemeberAssess` (`PartyMemeberAssess`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员考核设置-考核标准';

drop table if exists `PartyCreditLogOfMember`;
CREATE TABLE `PartyCreditLogOfMember` (
	`Id` char(36) NOT NULL,
	`Action` varchar(20) NOT NULL COMMENT '积分策略唯一标识',
	`ActionType` int NOT NULL COMMENT '获取积分的方式', 
	`FuncName` varchar(50) NOT NULL COMMENT '功能名称',
	`Text` varchar(200) NOT NULL COMMENT '积分内容 (允许人工录入)',
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`CreditS1` float NOT NULL COMMENT '获取积分数 (允许人工录入)',
	`DateLine` datetime(6) NOT NULL COMMENT '执行时间',
	PRIMARY KEY (`Id`),
  KEY `Action` (`Action`),
  KEY `UserId` (`UserId`),
  KEY `DateLine` (`DateLine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人积分记录表';

drop table if exists `PartyCreditLogOfOrganization`;
CREATE TABLE `PartyCreditLogOfOrganization` (
	`Id` char(36) NOT NULL,
	`Action` varchar(20) NOT NULL COMMENT '积分策略唯一标识',
	`ActionType` int NOT NULL COMMENT '获取积分的方式', 
	`FuncName` varchar(50) NOT NULL COMMENT '功能名称',
	`Text` varchar(200) NOT NULL COMMENT '积分内容 (允许人工录入)',
	`OrgId` char(36) NOT NULL COMMENT '组部织ID(支部ID)', 
	`CreditS1` float NOT NULL COMMENT '获取积分数 (允许人工录入)',
	`DateLine` datetime(6) NOT NULL COMMENT '执行时间',
	PRIMARY KEY (`Id`),
  KEY `Action` (`Action`),
  KEY `OrgId` (`OrgId`),
  KEY `DateLine` (`DateLine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织部积分记录表';

drop table if exists `PartyMemberCreditStatistics`;
CREATE TABLE `PartyMemberCreditStatistics` (
	`Id` char(36) NOT NULL COMMENT '主键ID', 
	`Year` int NOT NULL COMMENT '年份',
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`OrgId` char(36) NOT NULL COMMENT '党组织-组织ID',
	`TotalCreditS1` float NOT NULL COMMENT '累计积分数', 
	`StatusCreditS1` float NOT NULL COMMENT '状态分', 
	`LoginCreditS1` float NOT NULL COMMENT '登录', 
	`OnlineStudyCreditS1` float NOT NULL COMMENT '线上培训', 
	`OfflineStudyCreditS1` float NOT NULL COMMENT '线下培训', 
	`LivesStudyCreditS1` float NOT NULL COMMENT '直播课堂', 
	`SelfStudyCreditS1` float NOT NULL COMMENT '自主学习', 
	`PartyMeetingCreditS1` float NOT NULL COMMENT '组织生活', 
	`ExamEveryDayCreditS1` float NOT NULL COMMENT '每日一题', 
	`ExamIntelligentCreditS1` float NOT NULL COMMENT '智能测试', 
	`ExamPaperCreditS1` float NOT NULL COMMENT '测评中心', 
	`OpinionsReplyCreditS1` float NOT NULL COMMENT '意见建议', 
	`ForumCreditS1` float NOT NULL COMMENT '活动互动', 
	`ExceptionCreditS1` float NOT NULL COMMENT '异常行为扣分', 
	`OtherCreditS1` float NOT NULL COMMENT '人工扣分加分', 
	`StudyCreditS1` float NOT NULL COMMENT '集中学习培训积分', 
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`,`OrgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员积分统计';

drop table if exists `PartyMemberCreditStatisticsOrganization`;
CREATE TABLE `PartyMemberCreditStatisticsOrganization` (
	`Id` char(36) NOT NULL COMMENT '党组织-组织ID', 
	`ParentId` char(36) DEFAULT NULL COMMENT '父组织id', 
	`Year` int NOT NULL COMMENT '年份',
	`OrganPath` varchar(500) NOT NULL COMMENT '组织路径',
	`IsOrganBranch` bit(1) NOT NULL COMMENT '是否为党支部; 组织部(根据[党员积分>党支部]积分变化向上累计)', 
	`Backup` varchar(500) NOT NULL COMMENT '党支部积分统计的备份(避免组织部变更问题); JSON格式{"TotalCreditS1":0}',
	`TotalCreditS1` float NOT NULL COMMENT '总积分', 
	`StudyCreditS1` float NOT NULL COMMENT '集中学习培训积分', 
	`UpToScratchUserCount` int NOT NULL COMMENT '达标人数 (达标率=达标人数/参与考核党员总人数)', 
-- 	`UserCount` int NOT NULL COMMENT '学员总数', 
-- 	`AssessUserCount` int NOT NULL COMMENT '参与考核党员总人数', 
-- 	`ZSDYCount` int NOT NULL COMMENT '正式党员', 
-- 	`YBDYCount` int NOT NULL COMMENT '预备党员', 
-- 	`BZCount` int NOT NULL COMMENT '党组织书记和班子成员', 
  PRIMARY KEY (`Id`),
  KEY `OrganPath` (`OrganPath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党组织部积分统计(所有组织)';

drop table if exists `PartyMemberCreditUpToScratch`;
CREATE TABLE `PartyMemberCreditUpToScratch` (
	`Id` char(36) NOT NULL COMMENT '主键ID', 
	`Year` int NOT NULL COMMENT '年份',
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`OrgId` char(36) NOT NULL COMMENT '党组织-组织ID',
	`OrganPath` varchar(500) NOT NULL COMMENT '组织路径',
	`Study` int NOT NULL COMMENT '党员必修课记录数', 
	`MustStudy` int NOT NULL COMMENT '组织应必修课数量', 
	`UpToScratch` bit(1) NOT NULL COMMENT '是否达标', 
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`,`OrgId`),
  KEY `OrganPath` (`OrganPath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员是否达标';

drop table if exists `PartyMemberCreditDailyStatistics`;
CREATE TABLE `PartyMemberCreditDailyStatistics` (
	`Id` char(36) NOT NULL COMMENT '主键ID', 
	`Year` int NOT NULL COMMENT '年份',
	`Month` int NOT NULL COMMENT '月份',
	`Day` int NOT NULL COMMENT '日期',
	`DayOfYear` int NOT NULL COMMENT 'DayOfYear',
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`OrgId` char(36) NOT NULL COMMENT '党组织-组织ID',
	`TotalCreditS1` float NOT NULL COMMENT '累计积分数', 
	`StatusCreditS1` float NOT NULL COMMENT '状态分', 
	`LoginCreditS1` float NOT NULL COMMENT '登录', 
	`OnlineStudyCreditS1` float NOT NULL COMMENT '线上培训', 
	`OfflineStudyCreditS1` float NOT NULL COMMENT '线下培训', 
	`LivesStudyCreditS1` float NOT NULL COMMENT '直播课堂', 
	`SelfStudyCreditS1` float NOT NULL COMMENT '自主学习', 
	`PartyMeetingCreditS1` float NOT NULL COMMENT '组织生活', 
	`ExamEveryDayCreditS1` float NOT NULL COMMENT '每日一题', 
	`ExamIntelligentCreditS1` float NOT NULL COMMENT '智能测试', 
	`ExamPaperCreditS1` float NOT NULL COMMENT '测评中心', 
	`OpinionsReplyCreditS1` float NOT NULL COMMENT '意见建议', 
	`ForumCreditS1` float NOT NULL COMMENT '活动互动', 
	`ExceptionCreditS1` float NOT NULL COMMENT '异常行为扣分', 
	`OtherCreditS1` float NOT NULL COMMENT '人工扣分加分', 
	`StudyCreditS1` float NOT NULL COMMENT '集中学习培训积分', 
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`,`OrgId`),
  KEY `DayOfYear` (`DayOfYear`),
  KEY `Month` (`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员积分统计(每天累计)';

drop table if exists `PartyMemberOrgCreditWeeklyStatistics`;
CREATE TABLE `PartyMemberOrgCreditWeeklyStatistics` (
	`Id` char(36) NOT NULL COMMENT '主键ID', 
	`Year` int NOT NULL COMMENT '年份',
	`WeekOfYear` int NOT NULL COMMENT '１～５２周',
	`Month` int NOT NULL COMMENT '月份',
	`WeekOfMonth` int NOT NULL COMMENT '１～４周',
	`OrgId` char(36) NOT NULL COMMENT '党组织-组织ID',
	`AvgCreditS1` float NOT NULL COMMENT '累计平均数', 
	`TotalCreditS1` float NOT NULL COMMENT '累计积分数', 
  PRIMARY KEY (`Id`),
  KEY `OrgId` (`OrgId`),
  KEY `WeekOfYear` (`WeekOfYear`),
  KEY `Month` (`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员积分统计+支部平均分+全市平均分(每周累计)';

drop table if exists `PartyMemberPerCreditWeeklyStatistics`;
CREATE TABLE `PartyMemberPerCreditWeeklyStatistics` (
	`Id` char(36) NOT NULL COMMENT '主键ID', 
	`Year` int NOT NULL COMMENT '年份',
	`WeekOfYear` int NOT NULL COMMENT '１～５２周',
	`Month` int NOT NULL COMMENT '月份',
	`WeekOfMonth` int NOT NULL COMMENT '１～４周',
	`UserId` char(36) NOT NULL COMMENT '党员-用户ID', 
	`TotalCreditS1` float NOT NULL COMMENT '累计积分数', 
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`),
  KEY `WeekOfYear` (`WeekOfYear`),
  KEY `Month` (`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='党员积分统计+总积分(每周累计)';

drop table if exists `PartyOrganizationCreditStatistics`;
CREATE TABLE `PartyOrganizationCreditStatistics` (
	`Id` char(36) NOT NULL COMMENT '党组织-组织ID', 
	`Year` int NOT NULL COMMENT '年份',
	`OrganPath` varchar(500) NOT NULL COMMENT '组织路径',
	`IsOrganBranch` bit(1) NOT NULL COMMENT '是否为党支部; 组织部(根据[党支部]积分变化向上累计)', 
	`Backup` varchar(500) NOT NULL COMMENT '党支部积分统计的备份(避免组织部变更问题); JSON格式{"TotalCreditS1":0}',
	`TotalCreditS1` float NOT NULL COMMENT '累计积分数', 
	`StatusCreditS1` float NOT NULL COMMENT '状态分', 
	`LoginCreditS1` float NOT NULL COMMENT '登录', 
	`PartyMeetingCreditS1` float NOT NULL COMMENT '组织生活',
	`ForumCreditS1` float NOT NULL COMMENT '活动互动', 
	`OpinionsReplyCreditS1` float NOT NULL COMMENT '意见建议', 
	`OnlineStudyCreditS1` float NOT NULL COMMENT '线上培训', 
	`OfflineStudyCreditS1` float NOT NULL COMMENT '线下培训', 
	`LivesStudyCreditS1` float NOT NULL COMMENT '直播课堂', 
	`ExceptionCreditS1` float NOT NULL COMMENT '异常行为扣分', 	
	`OtherCreditS1` float NOT NULL COMMENT '人工扣分加分', 
  PRIMARY KEY (`Id`),
  KEY `OrganPath` (`OrganPath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织部积分统计(所有组织)';


/*统计库的组织统计表*/
alter TABLE `organizationstatistics` add column `UserCount` int(11) NOT NULL DEFAULT '0';
alter TABLE `organizationstatistics` add column `CreditAssessUserCount` int(11) NOT NULL DEFAULT '0';
alter TABLE `organizationstatistics` add column `CreditZSDYCount` int(11) NOT NULL DEFAULT '0';
alter TABLE `organizationstatistics` add column `CreditYBDYCount` int(11) NOT NULL DEFAULT '0';
alter TABLE `organizationstatistics` add column `CreditBZCount` int(11) NOT NULL DEFAULT '0';


-- CREATE DEFINER=`admin`@`%` PROCEDURE `dbstatistics`.`OrganStatistics`()
-- BEGIN 
-- 	DECLARE maxLevel int;
-- 	DECLARE createTime datetime;
-- 	#统计数据选择的时间范围，前一天的时间,用于统计月数据用
-- 	DECLARE dataLimitTime datetime;
-- 	set createTime = NOW();
-- 	set dataLimitTime = DATE_ADD(NOW(),INTERVAL -1 day);
--   TRUNCATE OrganizationStatisticstemp;
-- 	select MAX(`Level`) into maxLevel from Organization where IsDeleted=0;  
-- 	#开始循环
-- 	WHILE maxLevel>0 DO
-- 	INSERT into OrganizationStatisticstemp(Id,ParentId,OrganType,UnitNatrueType,OrganName,OrganPath,`Level`,OrganCount,DWOrganCount
-- 	,DZZOrganCount,DZBOrganCount,DZOrganCount
-- 	,AssessUserCount
-- 	,ZSDYCount,YBDYCount,JJFZCount,FZDYCount,ManCount,WomenCount
-- 	,HanNationCount,ZangNationCount,MiaoNationCount,HuiNationCount,OtherNationCount
-- 	,XXEduCount,CZEduCount,GZEduCount,ZDZYEduCount,BZKEduCount,YJSEduCount,OtherEduCount
-- 	,TwentyBelowCount,TwentyToThirthCount,ThirthToFortyCount,ForthToFiftyCount,FiftyToSixtyCount,SixtyUpCount
-- 	,ZZPostCount,NMYMPostCount,JFJWJPostCount,XSPostCount,LTXPostCout,OtherPostCount
-- 	,PartyDuesNeedCount,DifficultMemberCount
-- 	,TeachPlanCount,TeachPlanOnScheduleOrganCount,TeachPlanOnAdvanceOrganCount,TeachPlanNoDevelopCount,TeachPlanOrganCount 
-- 	,UserCount,CreditAssessUserCount,CreditZSDYCount,CreditYBDYCount,CreditBZCount
-- 	,CreationTime
-- 	)
--  select users.Id,users.ParentId,users.OrganType,users.UnitNatrueType,users.OrganName,users.OrganPath,users.`Level`
-- 	/*组织总数*/
-- 	,1+IFNULL(TemOrg.OrganCount,0)  
-- 	/*党委总数*/
-- 	,(case WHEN(users.OrganType like 'OrganType-100%' or users.OrganType like 'OrganType-101%' or users.OrganType like 'OrganType-103%' OR users.OrganType ='OrganType-105-100' OR users.OrganType ='OrganType-104-100' ) then 1 else 0 end) + IFNULL(TemOrg.DWOrganCount,0)
-- 	/*党总支数*/
-- 	,(case WHEN(users.OrganType = 'OrganType-621' or users.OrganType ='OrganType-921' ) then 1 else 0 end) + IFNULL(TemOrg.DZZOrganCount,0)
-- 	/*党支部总数*/
-- 	,(case WHEN(users.OrganType like 'OrganType-63%' or users.OrganType like 'OrganType-93%') then 1 else 0 end) + IFNULL(TemOrg.DZBOrganCount,0)
-- 	/*党组总数*/
-- 	,(case WHEN(users.OrganType like 'OrganType-63%' or users.OrganType like 'OrganType-93%') then 1 else 0 end) + IFNULL(TemOrg.DZOrganCount,0)	
-- 	/*用户情况统计*/
-- 	
-- 	,IFNULL(users.AssessUserCount,0) + IFNULL(TemOrg.AssessUserCount,0)
-- 	,IFNULL(users.ZSDYCount,0) + IFNULL(TemOrg.ZSDYCount,0)
--   ,IFNULL(users.YBDYCount,0) + IFNULL(TemOrg.YBDYCount,0)
-- 	,IFNULL(users.JJFZCount,0) + IFNULL(TemOrg.JJFZCount,0)
-- 	,IFNULL(users.FZDYCount,0) + IFNULL(TemOrg.FZDYCount,0)
-- 	,IFNULL(users.ManCount,0) + IFNULL(TemOrg.ManCount,0)
-- 	,IFNULL(users.WomenCount,0) + IFNULL(TemOrg.WomenCount,0)
-- 	,IFNULL(users.HanNationCount,0) + IFNULL(TemOrg.HanNationCount,0)
-- 	,IFNULL(users.ZangNationCount,0) + IFNULL(TemOrg.ZangNationCount,0)
-- 	,IFNULL(users.MiaoNationCount,0) + IFNULL(TemOrg.MiaoNationCount,0)
-- 	,IFNULL(users.HuiNationCount,0) + IFNULL(TemOrg.HuiNationCount,0)
--   ,IFNULL(users.ZSDYCount,0) + IFNULL(users.YBDYCount,0) - (IFNULL(users.HanNationCount,0)+IFNULL(users.ZangNationCount,0)+IFNULL(users.MiaoNationCount,0)+IFNULL(users.HuiNationCount,0)) + IFNULL(TemOrg.OtherNationCount,0)
-- 	
-- 	,IFNULL(users.XXEduCount,0) + IFNULL(TemOrg.XXEduCount,0)
-- 	,IFNULL(users.CZEduCount,0) + IFNULL(TemOrg.CZEduCount,0)
-- 	,IFNULL(users.GZEduCount,0) + IFNULL(TemOrg.GZEduCount,0)
-- 	,IFNULL(users.ZDZYEduCount,0) + IFNULL(TemOrg.ZDZYEduCount,0)
-- 	,IFNULL(users.BZKEduCount,0) + IFNULL(TemOrg.BZKEduCount,0)
-- 	,IFNULL(users.YJSEduCount,0) + IFNULL(TemOrg.YJSEduCount,0)
-- 	,IFNULL(users.OtherEduCount,0) + IFNULL(TemOrg.OtherEduCount,0)
-- 
-- 	,IFNULL(users.TwentyBelowCount,0) + IFNULL(TemOrg.TwentyBelowCount,0)
-- 	,IFNULL(users.TwentyToThirthCount,0) + IFNULL(TemOrg.TwentyToThirthCount,0)
-- 	,IFNULL(users.ThirthToFortyCount,0) + IFNULL(TemOrg.ThirthToFortyCount,0)
-- 	,IFNULL(users.ForthToFiftyCount,0) + IFNULL(TemOrg.ForthToFiftyCount,0)
-- 	,IFNULL(users.FiftyToSixtyCount,0) + IFNULL(TemOrg.FiftyToSixtyCount,0)
-- 	,IFNULL(users.SixtyUpCount,0) + IFNULL(TemOrg.SixtyUpCount,0)
-- 
-- 	,IFNULL(users.ZZPostCount,0) + IFNULL(TemOrg.ZZPostCount,0)
-- 	,IFNULL(users.NMYMPostCount,0) + IFNULL(TemOrg.NMYMPostCount,0)
-- 	,IFNULL(users.JFJWJPostCount,0) + IFNULL(TemOrg.JFJWJPostCount,0)
-- 	,IFNULL(users.XSPostCount,0) + IFNULL(TemOrg.XSPostCount,0)
-- 	,IFNULL(users.LTXPostCout,0) + IFNULL(TemOrg.LTXPostCout,0)
-- 	,IFNULL(users.OtherPostCount,0) + IFNULL(TemOrg.OtherPostCount,0)  
-- 	
-- 	,IFNULL(users.PartyDuesNeedCount,0) + IFNULL(TemOrg.PartyDuesNeedCount,0)  
-- 	,IFNULL(users.DifficultMemberCount,0) + IFNULL(TemOrg.DifficultMemberCount,0)  
-- 	
-- 	,IFNULL(users.TeachPlanCount,0) + IFNULL(TemOrg.TeachPlanCount,0)  
-- 	,IFNULL(users.TeachPlanOnScheduleOrganCount,0) + IFNULL(TemOrg.TeachPlanOnScheduleOrganCount,0)  
-- 	,IFNULL(users.TeachPlanOnAdvanceOrganCount,0) + IFNULL(TemOrg.TeachPlanOnAdvanceOrganCount,0)  
-- 	
-- 	,IFNULL(users.TeachPlanOnPostOrganCount,0) + IFNULL(TemOrg.TeachPlanOnPostOrganCount,0)  
-- 	,IFNULL(users.TeachPlanOrganCount,0) + IFNULL(TemOrg.TeachPlanOrganCount,0)  
-- 	
-- 	,IFNULL(users.UserCount,0) + IFNULL(TemOrg.UserCount,0)
-- 	,IFNULL(users.CreditAssessUserCount,0) + IFNULL(TemOrg.CreditAssessUserCount,0)
-- 	,IFNULL(users.CreditZSDYCount,0) + IFNULL(TemOrg.CreditZSDYCount,0)
-- 	,IFNULL(users.CreditYBDYCount,0) + IFNULL(TemOrg.CreditYBDYCount,0)
-- 	,IFNULL(users.CreditBZCount,0) + IFNULL(TemOrg.CreditBZCount,0)
-- 	
-- 	,createTime from (
-- select a.Id,a.ParentId,a.OrganType,Unit.UnitNatrueType,a.OrganName,a.OrganPath,a.`Level`
-- 	
-- 
-- 	,(SUM(case when b.AssessType>1 then 1 else 0 end) - SUM(case when d.IsLostMember=1 then 1 else 0 end) ) AssessUserCount 
-- 	,SUM(CASE WHEN(d.PartyMemeberType='PartyMemeberType-1') then 1 ELSE 0 END) ZSDYCount
-- 	,SUM(CASE WHEN(d.PartyMemeberType='PartyMemeberType-2') then 1 ELSE 0 END) YBDYCount
-- 	,SUM(CASE WHEN(d.PartyMemeberType='PartyMemeberType-4') then 1 ELSE 0 END) JJFZCount
-- 	,SUM(CASE WHEN(d.PartyMemeberType='PartyMemeberType-3') then 1 ELSE 0 END) FZDYCount
--   /*党员的性别类型统计 AssessType>3表示党员,需要考核的行政班子成员（AssessType=6）也是党员*/
-- 	,SUM(CASE WHEN(c.Sex = 'Sex-100' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) ManCount
-- 	,SUM(CASE WHEN(c.Sex = 'Sex-101' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) WomenCount
-- 	/*预备党员数据通过用户表中取出的才准确，党员发展成预备党员后会生成党员数据*/
-- 	,SUM(CASE WHEN(c.Sex = 'Sex-101' and d.PartyMemeberType='PartyMemeberType-3') then 1 ELSE 0 END) DevelopPrePerWomenCount
-- 	/*党员民族统计*/
-- 	,SUM(CASE WHEN(c.Nation = 'Nation-100' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) HanNationCount
-- 	,SUM(CASE WHEN(c.Nation = 'Nation-103' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) ZangNationCount
-- 	,SUM(CASE WHEN(c.Nation = 'Nation-105' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) MiaoNationCount
-- 	,SUM(CASE WHEN(c.Nation = 'Nation-102' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) HuiNationCount
-- 	,SUM(CASE WHEN(c.Nation <> 'Nation-100' and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) DevelopPrePerMinorityCount
-- 	/*学历统计*/
-- 
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-8%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) XXEduCount
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-7%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) CZEduCount
--   ,SUM(CASE WHEN((c.Education LIKE 'Education-6%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) GZEduCount
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-4%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) ZDZYEduCount
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-2%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) BZKEduCount
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-1%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) YJSEduCount
-- 	,SUM(CASE WHEN((c.Education LIKE 'Education-9%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) OtherEduCount
-- 
-- 	,SUM(CASE WHEN( c.Education LIKE 'Education-2%' || c.Education LIKE 'Education-1%') and (d.PartyMemeberType='PartyMemeberType-3') then 1 ELSE 0 END) DevelopPrePerDZJYSCount
-- 	/*年龄段*/
-- 	,SUM(CASE WHEN(c.Birthday> DATE_SUB(dataLimitTime,INTERVAL 20 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) TwentyBelowCount
-- 	,SUM(CASE WHEN(c.Birthday<= DATE_SUB(dataLimitTime,INTERVAL 20 YEAR) AND c.Birthday>= DATE_SUB(CURDATE(),INTERVAL 30 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) TwentyToThirthCount
-- 	,SUM(CASE WHEN(c.Birthday< DATE_SUB(dataLimitTime,INTERVAL 30 YEAR) AND c.Birthday>= DATE_SUB(CURDATE(),INTERVAL 40 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) ThirthToFortyCount
-- 	,SUM(CASE WHEN(c.Birthday< DATE_SUB(dataLimitTime,INTERVAL 40 YEAR) AND c.Birthday>= DATE_SUB(CURDATE(),INTERVAL 50 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) ForthToFiftyCount
-- 	,SUM(CASE WHEN(c.Birthday< DATE_SUB(dataLimitTime,INTERVAL 50 YEAR) AND c.Birthday>= DATE_SUB(CURDATE(),INTERVAL 60 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) FiftyToSixtyCount
-- 	,SUM(CASE WHEN(c.Birthday> DATE_SUB(dataLimitTime,INTERVAL 60 YEAR) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2')) then 1 ELSE 0 END) SixtyUpCount
-- 	/*行业*/
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-0%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) ZZPostCount
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-1%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) NMYMPostCount
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-2%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) JFJWJPostCount
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-3%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) XSPostCount
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-4%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) LTXPostCout
-- 	,SUM(CASE WHEN((c.Post LIKE 'Post-5%' ) and (d.PartyMemeberType='PartyMemeberType-1' or d.PartyMemeberType='PartyMemeberType-2') ) then 1 ELSE 0 END) OtherPostCount
-- 	/*不是失联党员则都需要缴费*/
-- 	,SUM(CASE WHEN(d.IsLostMember=0) then 1 ELSE 0 END) PartyDuesNeedCount
-- 	,SUM(CASE WHEN(d.IsDifficult=1) then 1 ELSE 0 END) DifficultMemberCount
-- 	
-- 	 /*获取党组织本月 线上 的一个开班计划,线上开班，线下开班*/
-- 	,SUM(CASE WHEN(t.TimeType='Month' and t.`Year`=YEAR(NOW()) and t.`Month` =MONTH(NOW()) ) then 1 ELSE 0 END) TeachPlanCount
-- 	,SUM(CASE WHEN(t.isOnline=1  and t.TimeType='Month'  and t.`Year`=YEAR(NOW()) and t.`Month` =MONTH(NOW()) ) then 1 ELSE 0 END) TeachPlanOnScheduleOrganCount
-- 	,SUM(CASE WHEN(t.isOnline<>1  and t.TimeType='Month'  and t.`Year`=YEAR(NOW()) and t.`Month` =MONTH(NOW()) ) then 1 ELSE 0 END ) TeachPlanOnAdvanceOrganCount
-- 	/*获取是否成立党小组，党支部*/
-- 	,(case WHEN((a.OrganType like 'OrganType-63%' or a.OrganType like 'OrganType-93%') and Porg.IsOrganGroup = 1 ) then 1 else 0 end)  TeachPlanOnPostOrganCount
-- 	,(case WHEN((a.OrganType like 'OrganType-63%' or a.OrganType like 'OrganType-93%') and Porg.IsBranch = 1 ) then 1 else 0 end)  TeachPlanOrganCount
-- 	/*积分学时统计*/
-- 	,SUM(1) UserCount /*学员总数*/
-- 	,SUM(CASE WHEN (d.PartyMemeberAssess='PartyMemberAssessment-100' or d.PartyMemeberAssess='PartyMemberAssessment-102' or d.PartyMemeberAssess='PartyMemberAssessment-103' or d.PartyMemeberAssess='PartyMemberAssessment-104' or d.PartyMemeberAssess='PartyMemberAssessment-105' or d.PartyMemeberAssess='PartyMemberAssessment-106') THEN 1 ELSE 0 END) CreditAssessUserCount /*参与考核党员总人数*/
--     ,SUM(CASE WHEN (d.PartyMemeberAssess='PartyMemberAssessment-100' or d.PartyMemeberAssess='PartyMemberAssessment-102' or d.PartyMemeberAssess='PartyMemberAssessment-103' or d.PartyMemeberAssess='PartyMemberAssessment-104' or d.PartyMemeberAssess='PartyMemberAssessment-105' or d.PartyMemeberAssess='PartyMemberAssessment-106') and d.PartyMemeberType='PartyMemeberType-1' THEN 1 ELSE 0 END) CreditZSDYCount /*正式党员*/
--     ,SUM(CASE WHEN (d.PartyMemeberAssess='PartyMemberAssessment-100' or d.PartyMemeberAssess='PartyMemberAssessment-102' or d.PartyMemeberAssess='PartyMemberAssessment-103' or d.PartyMemeberAssess='PartyMemberAssessment-104' or d.PartyMemeberAssess='PartyMemberAssessment-105' or d.PartyMemeberAssess='PartyMemberAssessment-106') and d.PartyMemeberType='PartyMemeberType-2' THEN 1 ELSE 0 END) CreditYBDYCount /*预备党员*/
--     ,SUM(CASE WHEN (d.PartyMemeberAssess='PartyMemberAssessment-100' or d.PartyMemeberAssess='PartyMemberAssessment-102' or d.PartyMemeberAssess='PartyMemberAssessment-103' or d.PartyMemeberAssess='PartyMemberAssessment-104' or d.PartyMemeberAssess='PartyMemberAssessment-105' or d.PartyMemeberAssess='PartyMemberAssessment-106') and b.AssessType=6 THEN 1 ELSE 0 END) CreditBZCount /*党组织书记和班子成员*/
-- 		
-- 	from  organization a INNER JOIN PartyOrganization Porg on a.Id=Porg.Id LEFT JOIN Unit ON Porg.UnitId=Unit.Id STRAIGHT_JOIN abpusers b on a.Id=b.OrganId  left join UserAdditionInfo c on b.Id=c.Id  LEFT JOIN PartyMemberInfo d on b.Id = d.Id  left join TeachingPlan t on a.Id=t.CreateOrganId 
-- 
-- where a.`Level`=maxLevel and a.IsDeleted=0 and a.AuditStatus=1 and b.IsDeleted=0 and d.IsDeleted=0
--  group by a.Id,a.OrganType order by null
-- ) users
-- 
-- 
-- LEFT JOIN (SELECT ParentId
-- 	,SUM(OrganCount) OrganCount
-- 	,SUM(DWOrganCount) DWOrganCount
-- 	,SUM(DZZOrganCount) DZZOrganCount
-- 	,SUM(DZBOrganCount) DZBOrganCount
-- 	,SUM(DZOrganCount) DZOrganCount
-- 	,SUM(AssessUserCount) AssessUserCount
-- 	,SUM(ZSDYCount) ZSDYCount
-- 	,SUM(YBDYCount) YBDYCount
-- 	,SUM(JJFZCount) JJFZCount
-- 	,SUM(FZDYCount) FZDYCount
-- 	,SUM(ManCount) ManCount
-- 	,SUM(WomenCount) WomenCount
-- 	,SUM(HanNationCount) HanNationCount
-- 	,SUM(ZangNationCount) ZangNationCount
-- 	,SUM(MiaoNationCount) MiaoNationCount
-- 	,SUM(HuiNationCount) HuiNationCount
-- 	,SUM(OtherNationCount) OtherNationCount	
-- 	,SUM(XXEduCount) XXEduCount
-- 	,SUM(CZEduCount) CZEduCount
-- 	,SUM(GZEduCount) GZEduCount
-- 	,SUM(ZDZYEduCount) ZDZYEduCount
-- 	,SUM(BZKEduCount) BZKEduCount
-- ,SUM(YJSEduCount) YJSEduCount
-- ,SUM(OtherEduCount) OtherEduCount
-- 
-- 	,SUM(TwentyBelowCount) TwentyBelowCount
-- 	,SUM(TwentyToThirthCount) TwentyToThirthCount
-- 	,SUM(ThirthToFortyCount) ThirthToFortyCount
-- 	,SUM(ForthToFiftyCount) ForthToFiftyCount
-- 	,SUM(FiftyToSixtyCount) FiftyToSixtyCount
-- 	,SUM(SixtyUpCount) SixtyUpCount
-- 
-- 	,SUM(ZZPostCount) ZZPostCount
-- 	,SUM(NMYMPostCount) NMYMPostCount
-- 	,SUM(JFJWJPostCount) JFJWJPostCount
-- 	,SUM(XSPostCount) XSPostCount
-- 	,SUM(LTXPostCout) LTXPostCout
-- 	,SUM(OtherPostCount) OtherPostCount
-- 
--   
--   ,SUM(ApplicationCount) ApplicationCount
-- 	,SUM(DevelopeMemberCount) DevelopeMemberCount  
-- 	,SUM(DevelopeZZPostCount) DevelopeZZPostCount
-- 	,SUM(DevelopeNMYMPostCount) DevelopeNMYMPostCount
-- 	,SUM(DevelopeJFJWJPostCount) DevelopeJFJWJPostCount
-- 	,SUM(DevelopeXSPostCount) DevelopeXSPostCount
-- 	,SUM(DevelopeLTXPostCout) DevelopeLTXPostCout
-- 	,SUM(DevelopeOtherPostCount) DevelopeOtherPostCount
-- 
-- 	,SUM(DevelopApplicationWomenCount) DevelopApplicationWomenCount
-- 	,SUM(DevelopActiveWomenCount) DevelopActiveWomenCount
-- 	,SUM(DevelopDevelopWomenCount) DevelopDevelopWomenCount
-- 	,SUM(DevelopApplicationMinorityCount) DevelopApplicationMinorityCount
-- 	,SUM(DevelopActiveMinorityCount) DevelopActiveMinorityCount
-- 	,SUM(DevelopDevelopMinorityCount) DevelopDevelopMinorityCount
-- 	,SUM(DevelopApplicationDZJYSCount) DevelopApplicationDZJYSCount
-- 	,SUM(DevelopActiveDZJYSCount) DevelopActiveDZJYSCount
-- 	,SUM(DevelopDevelopDZJYSCount) DevelopDevelopDZJYSCount
-- 	,SUM(DevelopeMemberLeftCount) DevelopeMemberLeftCount   
-- 	,SUM(DevelopPrePerWomenCount) DevelopPrePerWomenCount   
-- 	,SUM(DevelopPrePerMinorityCount) DevelopPrePerMinorityCount   
-- 	,SUM(DevelopPrePerDZJYSCount) DevelopPrePerDZJYSCount   
-- 
-- 
-- 	,SUM(MeetingCount) MeetingCount  
-- 	,SUM(ZBWYHMeetingCount) ZBWYHMeetingCount
-- 	,SUM(DZZSHMeetingCount) DZZSHMeetingCount
-- 	,SUM(DXZMeetingCount) DXZMeetingCount
-- 	,SUM(DKMeetingCount) DKMeetingCount
-- 	,SUM(DYDHMeetingCount) DYDHMeetingCount
-- 	,SUM(DZBMeetingCount) DZBMeetingCount
-- 	,SUM(KFSZZSHMeetingCount) KFSZZSHMeetingCount
-- 	,SUM(PartyDuesNeedCount) PartyDuesNeedCount
-- 	,SUM(PartyDuesCount) PartyDuesCount
-- 	,SUM(PartyDuesInSum) PartyDuesInSum
-- 	,SUM(PartyDuesOutSum) PartyDuesOutSum
-- 	,SUM(VolunteerCount) VolunteerCount
-- 	,SUM(VolunteerUserCount) VolunteerUserCount
-- 	,SUM(VolunteerCompleteCount) VolunteerCompleteCount
-- 	,SUM(VolunteerNoCompleteCount) VolunteerNoCompleteCount
-- 
-- 	,SUM(DifficultMemberCount) DifficultMemberCount
-- 	,SUM(DifficultHelpCount) DifficultHelpCount
-- 	,SUM(DifficultHelpUserCount) DifficultHelpUserCount
-- 	
-- 	,SUM(AppraisalCount) AppraisalCount 
-- 	,SUM(AppraisalPartyBranchCount) AppraisalPartyBranchCount 
-- 	,SUM(AppraisalCommendCount) AppraisalCommendCount
-- 	,SUM(AppraisalUnPassCount) AppraisalUnPassCount
-- 
-- 	,SUM(TeachPlanCount) TeachPlanCount 
-- 	,SUM(TeachPlanOnScheduleOrganCount) TeachPlanOnScheduleOrganCount 
-- 	,SUM(TeachPlanOnAdvanceOrganCount) TeachPlanOnAdvanceOrganCount
-- 	,SUM(TeachPlanOnPostOrganCount) TeachPlanOnPostOrganCount
-- 	,SUM(TeachPlanNoDevelopCount) TeachPlanNoDevelopCount
-- 	,SUM(TeachPlanOrganCount) TeachPlanOrganCount
-- 	
-- 	,SUM(UserCount) UserCount
-- 	,SUM(CreditAssessUserCount) CreditAssessUserCount
-- 	,SUM(CreditZSDYCount) CreditZSDYCount
-- 	,SUM(CreditYBDYCount) CreditYBDYCount
-- 	,SUM(CreditBZCount) CreditBZCount
-- 
-- 	,SUM(ExamOpenOrganCount) ExamOpenOrganCount
-- 	,SUM(ExamCount) ExamCount
-- 	,SUM(ExamUserCount) ExamUserCount
-- 	,SUM(ExamJoinUserCount) ExamJoinUserCount
-- 	,SUM(ExamPassUserCount) ExamPassUserCount
-- 	,SUM(LowerFiftyJoinRateOrganCount) LowerFiftyJoinRateOrganCount
-- 	,SUM(LowerFiftyPassRateOrganCount) LowerFiftyPassRateOrganCount
-- 	
--   from OrganizationStatisticstemp where `Level` = maxLevel+1 GROUP BY ParentId order by null) as TemOrg on users.Id=TemOrg.ParentId;
-- 	SET maxLevel = maxLevel-1;
-- 	end WHILE;
-- 
-- 
-- truncate table OrganizationStatistics;
-- insert into OrganizationStatistics (Id,ParentId,OrganType,UnitNatrueType,OrganName,OrganPath,`Level`,OrganCount,DWOrganCount
-- 	,DZZOrganCount,DZBOrganCount,DZOrganCount,ZSDYCount,YBDYCount,JJFZCount,FZDYCount,ManCount,WomenCount
-- 	,HanNationCount,ZangNationCount,MiaoNationCount,HuiNationCount,OtherNationCount
-- 	,XXEduCount,CZEduCount,GZEduCount,ZDZYEduCount,BZKEduCount,YJSEduCount,OtherEduCount
-- 	,TwentyBelowCount,TwentyToThirthCount,ThirthToFortyCount,ForthToFiftyCount,FiftyToSixtyCount,SixtyUpCount
-- 	,ZZPostCount,NMYMPostCount,JFJWJPostCount,XSPostCount,LTXPostCout,OtherPostCount
--   ,ApplicationCount,DevelopeMemberCount,DevelopeZZPostCount,DevelopeNMYMPostCount,DevelopeJFJWJPostCount,DevelopeXSPostCount,DevelopeLTXPostCout,DevelopeOtherPostCount
-- 	,DevelopApplicationWomenCount,	DevelopActiveWomenCount,DevelopDevelopWomenCount,DevelopApplicationMinorityCount,DevelopActiveMinorityCount,DevelopDevelopMinorityCount
-- 	,DevelopApplicationDZJYSCount,DevelopActiveDZJYSCount,DevelopDevelopDZJYSCount,DevelopeMemberLeftCount,DevelopPrePerWomenCount,DevelopPrePerMinorityCount,DevelopPrePerDZJYSCount
--   ,MeetingCount,ZBWYHMeetingCount,DZZSHMeetingCount,DXZMeetingCount,DKMeetingCount,DYDHMeetingCount,DZBMeetingCount,KFSZZSHMeetingCount
-- 	,PartyDuesNeedCount
-- 	,PartyDuesCount
-- 	,PartyDuesInSum, PartyDuesOutSum
-- 	,VolunteerCount
-- 	,VolunteerUserCount
-- 	,VolunteerCompleteCount
-- 	,VolunteerNoCompleteCount
-- 	,DifficultMemberCount
-- 	,DifficultHelpCount
-- 	,DifficultHelpUserCount
-- 	,AppraisalCount 
-- 	,AppraisalPartyBranchCount 
-- 	,AppraisalCommendCount 
-- 	,AppraisalUnPassCount
-- 	,AssessUserCount
-- 		,TeachPlanCount
-- 	,TeachPlanOnScheduleOrganCount
-- 	,TeachPlanOnAdvanceOrganCount
-- 	,TeachPlanOnPostOrganCount
-- 	,TeachPlanNoDevelopCount
-- 	,TeachPlanOrganCount
-- 	,TeachPlanOnScheduleRate
-- #考试
-- 	,ExamOpenOrganCount
-- 	,ExamCount
-- 	,ExamUserCount
-- 	,ExamJoinUserCount
-- 	,ExamPassUserCount
-- 	,LowerFiftyJoinRateOrganCount
-- 	,LowerFiftyPassRateOrganCount
-- 	
-- 	,UserCount
-- 	,CreditAssessUserCount
-- 	,CreditZSDYCount
-- 	,CreditYBDYCount
-- 	,CreditBZCount
-- 
-- ,CreationTime) select Id,ParentId,OrganType,UnitNatrueType,OrganName,OrganPath,`Level`,OrganCount,DWOrganCount
-- 	,DZZOrganCount,DZBOrganCount,DZOrganCount,ZSDYCount,YBDYCount,JJFZCount,FZDYCount,ManCount,WomenCount
-- 	,HanNationCount,ZangNationCount,MiaoNationCount,HuiNationCount,OtherNationCount
-- 	,XXEduCount,CZEduCount,GZEduCount,ZDZYEduCount,BZKEduCount,YJSEduCount,OtherEduCount
-- 	,TwentyBelowCount,TwentyToThirthCount,ThirthToFortyCount,ForthToFiftyCount,FiftyToSixtyCount,SixtyUpCount
-- 	,ZZPostCount,NMYMPostCount,JFJWJPostCount,XSPostCount,LTXPostCout,OtherPostCount
--   ,ApplicationCount,DevelopeMemberCount,DevelopeZZPostCount,DevelopeNMYMPostCount,DevelopeJFJWJPostCount,DevelopeXSPostCount,DevelopeLTXPostCout,DevelopeOtherPostCount
-- 	,DevelopApplicationWomenCount,	DevelopActiveWomenCount,DevelopDevelopWomenCount,DevelopApplicationMinorityCount,DevelopActiveMinorityCount,DevelopDevelopMinorityCount
-- 	,DevelopApplicationDZJYSCount,DevelopActiveDZJYSCount,DevelopDevelopDZJYSCount,DevelopeMemberLeftCount,DevelopPrePerWomenCount,DevelopPrePerMinorityCount,DevelopPrePerDZJYSCount
--   ,MeetingCount,ZBWYHMeetingCount,DZZSHMeetingCount,DXZMeetingCount,DKMeetingCount,DYDHMeetingCount,DZBMeetingCount,KFSZZSHMeetingCount
-- 	,PartyDuesNeedCount
-- 	,PartyDuesCount
-- 	,PartyDuesInSum, PartyDuesOutSum
-- 	,VolunteerCount
-- 	,VolunteerUserCount
-- 	,VolunteerCompleteCount
-- 	,VolunteerNoCompleteCount
-- 	,DifficultMemberCount
-- 	,DifficultHelpCount
-- 	,DifficultHelpUserCount
-- 	
-- 	,AppraisalCount 
-- 	,AppraisalPartyBranchCount 
-- 	,AppraisalCommendCount 
-- 	,AppraisalUnPassCount
-- 	,AssessUserCount
-- 	,TeachPlanCount
-- 	,TeachPlanOnScheduleOrganCount
-- 	,TeachPlanOnAdvanceOrganCount
-- 	,TeachPlanOnPostOrganCount
-- 	,TeachPlanNoDevelopCount
-- 	,TeachPlanOrganCount
-- 	,TeachPlanOnScheduleRate
-- #考试
-- 	,ExamOpenOrganCount
-- 	,ExamCount
-- 	,ExamUserCount
-- 	,ExamJoinUserCount
-- 	,ExamPassUserCount
-- 	,LowerFiftyJoinRateOrganCount
-- 	,LowerFiftyPassRateOrganCount
-- 	
-- 	,UserCount
-- 	,CreditAssessUserCount
-- 	,CreditZSDYCount
-- 	,CreditYBDYCount
-- 	,CreditBZCount
-- 
-- ,createTime from OrganizationStatisticstemp;
-- END
