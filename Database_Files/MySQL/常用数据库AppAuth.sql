CREATE TABLE `AuthOrg` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '机构ID', 
	`Code` varchar(32) NOT NULL COMMENT '机构代号', 
	`Name` varchar(128) NOT NULL COMMENT '机构名', 
	`FullName` varchar(128) NOT NULL COMMENT '机构路径全称', 
	`ShortName` varchar(128) NOT NULL COMMENT '机构简称', 
	`SortCode` varchar(32) NOT NULL COMMENT '排序代码', 
	`ParentId` varchar(32) NOT NULL COMMENT '上级机构', 
	`Level` varchar(32) NOT NULL COMMENT '机构级别', 
	`OrgType` varchar(32) NOT NULL COMMENT '机构类型', 
	`Leader` varchar(32) NOT NULL COMMENT '负责人', 
	`Remark` varchar(512) NOT NULL COMMENT '机构说明', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='部门机构 ';

CREATE TABLE `AuthOrgProperty` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '机构属性ID', 
	`OrgId` varchar(32) NOT NULL COMMENT '机构ID', 
	`Name` varchar(48) NOT NULL COMMENT '属性名称', 
	`Value` varchar(1024) NOT NULL COMMENT '属性值', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='机构属性';

CREATE TABLE `AuthPermit` (
	`Code` varchar(128) NOT NULL PRIMARY KEY COMMENT '权限代码', 
	`Name` varchar(128) NOT NULL COMMENT '权限名称', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='权限信息 自定义权限';

CREATE TABLE `AuthRole` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '角色ID', 
	`Code` varchar(32) NOT NULL COMMENT '角色代码', 
	`SortCode` varchar(8) NOT NULL COMMENT '排序代码', 
	`Name` varchar(48) NOT NULL COMMENT '角色名', 
	`Type` varchar(32) NOT NULL COMMENT '角色类型', 
	`InWorkFlow` varchar(1) NOT NULL COMMENT '是否应用于工作流', 
	`Status` varchar(32) NOT NULL COMMENT '角色状态', 
	`Summary` varchar(512) NOT NULL COMMENT '角色描述', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='角色信息';

CREATE TABLE `AuthRolePermit` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '角色权限ID', 
	`PermitCode` varchar(128) NOT NULL COMMENT '权限代码', 
	`RoleId` varchar(32) NOT NULL COMMENT '角色ID', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='角色权限';

CREATE TABLE `AuthUser` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '用户ID', 
	`Code` varchar(32) NOT NULL COMMENT '用户代码', 
	`Name` varchar(48) NOT NULL COMMENT '用户名', 
	`Password` varchar(32) NOT NULL COMMENT '密码', 
	`Salt` varchar(24) NOT NULL COMMENT '密码盐值', 
	`Avatar` varchar(64) NOT NULL COMMENT '头像', 
	`OrgId` varchar(32) NOT NULL COMMENT '机构', 
	`Email` varchar(32) NOT NULL COMMENT '邮件', 
	`Phone` varchar(48) NOT NULL COMMENT '手机号', 
	`Status` varchar(32) NOT NULL COMMENT '状态', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户信息';

CREATE TABLE `AuthUserAccount` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '账号ID', 
	`UserId` varchar(32) NOT NULL COMMENT '用户ID', 
	`AccountCode` varchar(32) NOT NULL COMMENT '账号代号', 
	`AccountType` varchar(32) NOT NULL COMMENT '账号类型', 
	`Password` varchar(32) NOT NULL COMMENT '账号密码', 
	`Status` varchar(32) NOT NULL COMMENT '账号状态', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户账号';

CREATE TABLE `AuthUserBehavior` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '用户行为ID', 
	`UserId` varchar(32) NOT NULL COMMENT '用户ID', 
	`ObjectId` varchar(32) NOT NULL COMMENT '关联对象ID', 
	`ObjectType` varchar(32) NOT NULL COMMENT '关联对象类型', 
	`Type` varchar(32) NOT NULL COMMENT '行为类型', 
	`Value` varchar(32) NOT NULL COMMENT '行为数值', 
	`Memo` varchar(512) NOT NULL COMMENT '行为说明', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户行为';

CREATE TABLE `AuthUserPermit` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '用户权限ID', 
	`PermitCode` varchar(128) NOT NULL COMMENT '权限代码', 
	`UserId` varchar(32) NOT NULL COMMENT '用户ID', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户直接权限';

CREATE TABLE `AuthUserProperty` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '用户属性ID', 
	`UserId` varchar(32) NOT NULL COMMENT '用户ID', 
	`Name` varchar(48) NOT NULL COMMENT '属性名', 
	`Value` varchar(1024) NOT NULL COMMENT '属性值', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户属性';

CREATE TABLE `AuthUserRole` (
	`Id` varchar(32) NOT NULL PRIMARY KEY COMMENT '职责ID', 
	`OrgId` varchar(32) NOT NULL COMMENT '机构ID', 
	`RoleId` varchar(32) NOT NULL COMMENT '角色ID', 
	`UserId` varchar(32) NOT NULL COMMENT '用户ID', 
	`PositionType` varchar(32) NOT NULL COMMENT '岗位类型', 
	`Revision` int NOT NULL COMMENT '乐观锁', 
	`CreatedBy` varchar(32) NOT NULL COMMENT '创建人', 
	`CreatedTime` datetime NOT NULL COMMENT '创建时间', 
	`UpdatedBy` varchar(32) NOT NULL COMMENT '更新人', 
	`UpdatedTime` datetime NOT NULL COMMENT '更新时间'
) DEFAULT CHARSET=utf8 COMMENT='用户角色';

