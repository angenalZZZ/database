-- password:"c053a643dc36af9acdf2fb8b9f024b7b"
-- userName:"06692787"
select count(*) as Value from OrganizationStatistics o left join PartyMemberCreditStatisticsOrganization d on o.Id=d.Id and d.Year=2019 
where 1=1  and o.ParentId='5d507a26-4275-48c4-b3d6-8ca7388feb21' 

select OrganId from abptenants

select a.Id,a.Name,a.UserName,b.PartyMemeberType,b.PartyMemeberAssess,d.TotalCreditS1 
from abpusers a inner join PartyMemberInfo b on a.Id=b.Id and a.IsDeleted=0 and b.IsDeleted=0 
inner join AbpUserPath c on b.Id=c.Id and c.IsDeleted=0 and c.AuditStatus=1 and c.OrganId='7ba9fcb7-bf73-4f30-851d-fb5f553fb73a' -- and b.PartyMemeberType=''
left join PartyMemberCreditStatistics d on a.Id=d.UserId and d.Year=2019
where d.TotalCreditS1>=60 and d.ll>30

select * from resourcestudyrecord where IsDeleted=0
select count(distinct a.Id) as Num from resourcelibary a 
inner join resourcestudyrecord b on a.Id=b.ResourceId and a.AuditStatus=1 and a.IsDeleted=0 
where b.UserId='08d6dd9f-df2c-9c30-e945-07cad3b1f0ea'

select count(c.UserId) as Value from PartyOrganization a inner join Unit b on a.UnitId=b.Id and a.IsDeleted=0 and b.IsDeleted=0 
                and b.CreatedOrganId=@id and b.UnitVerify=1 
                inner join OrganTemaMember c on a.Id=c.OrganId and c.IsDeleted=0
                
select a.IsBranch,count(c.UserId) as Value from PartyOrganization a inner join Unit b on a.UnitId=b.Id and a.IsDeleted=0 and b.IsDeleted=0 
--                 and b.CreatedOrganId=@id and b.UnitVerify=1 
                inner join OrganTemaMember c on a.Id=c.OrganId and c.IsDeleted=0
                group by a.IsBranch
select * from organization where id='82b41722-1187-4aae-8472-c47845dee19a'

-- select * from PartyCreditRuleSettings
-- delete from PartyCreditRuleLog;
-- delete from PartyMemberCreditDailyStatistics where Day=30;

select * from PartyCreditAssessmentSettings
select * from PartyCreditRuleLog 
select * from PartyCreditLogOfMember where DateLine>'2019-08-30 02:36:01'
select * from PartyMemberCreditDailyStatistics where Day=30;

-- delete from PartyMemberCreditStatistics;
-- delete from PartyMemberCreditUpToScratch;
-- delete from PartyMemberOrgCreditWeeklyStatistics;
-- delete from PartyMemberPerCreditWeeklyStatistics;
-- delete from PartyMemberCreditStatisticsOrganization;
select * from PartyMemberCreditStatistics where UserId='8c8e3404-73a2-4416-8392-531d41d8800f'
select * from PartyMemberCreditUpToScratch
select * from PartyMemberPerCreditWeeklyStatistics
select * from PartyMemberOrgCreditWeeklyStatistics
select * from PartyMemberCreditStatisticsOrganization

select a.Id as UserId,a.Name,a.UserName,b.PartyMemeberType,b.PartyMemeberAssess,s.Study,s.MustStudy,s.UpToScratch,o.OrganName,d.TotalCreditS1,d.StudyCreditS1 
from abpusers a inner join PartyMemberInfo b on a.Id=b.Id and a.IsDeleted=0 and b.IsDeleted=0   
inner join AbpUserPath c on b.Id=c.Id and c.IsDeleted=0 and c.AuditStatus=1 
inner join Organization o on c.OrganId=o.Id and o.OrganPath like '100000,116725,122229,115826%'  left join PartyMemberCreditUpToScratch s on a.Id=s.UserId and s.Year=2019  
left join PartyMemberCreditStatistics d on a.Id=d.UserId and d.Year=2019  
order by d.TotalCreditS1 desc limit 0,10


select o.Id,o.OrganName,o.OrganType,o.OrganPath,
d.TotalCreditS1,d.StudyCreditS1,ifnull(o.UserCount,0) UserCount,ifnull(o.CreditAssessUserCount,0) CreditAssessUserCount,
ifnull(o.CreditZSDYCount,0) CreditZSDYCount,ifnull(o.CreditYBDYCount,0) CreditYBDYCount,ifnull(o.CreditBZCount,0) CreditBZCount 
from OrganizationStatistics o left join PartyMemberCreditStatisticsOrganization d on o.Id=d.Id and d.Year=2019  
and o.OrganPath like '100000,116725%' 
-- where o.CreditAssessUserCount>0
order by d.TotalCreditS1 desc limit 0,10





