db.getCollection('JobAdminLog').find({ "detail" : "ϵͳ�쳣:�ϴ�ƽ̨ʧ�ܣ�",
    "created" : { $gt: ISODate("2017-10-01T02:59:17.718Z") } }).forEach(function(o){
    print(o.describe.split('��')[1])
});
