db.getCollection('JobAdminLog').find({ "detail" : "系统异常:上传平台失败！",
    "created" : { $gt: ISODate("2017-10-01T02:59:17.718Z") } }).forEach(function(o){
    print(o.describe.split('：')[1])
});
