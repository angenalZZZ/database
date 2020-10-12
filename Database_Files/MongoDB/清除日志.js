/*清除日志[上个月以前]*/
var month0=ISODate(new Date().getFullYear()+'-'+(new Date().getMonth()<9?"0":"")+(new Date().getMonth())+"-01T00:00:00.000Z");
db.getCollection('APIAdminLog').remove({"created" : { $lt: month0}});
db.getCollection('JobAdminLog').remove({"created" : { $lt: month0}});
db.getCollection('Log').remove({"created" : { $lt: month0}});
db.getCollection('MAllAdminLog').remove({"created" : { $lt: month0}});
