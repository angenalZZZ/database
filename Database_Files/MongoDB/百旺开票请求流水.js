//db.getCollection('JobAdminLog').find({  })
var sid = "FEI20170919100060752";
db.getCollection('JobAdminLog').find({ "describe" : "������Ʊ����,������ˮ�ţ�" + sid })
db.getCollection('JobAdminLog').find({ "describe" : "������Ʊ��Ӧ,������ˮ�ţ�" + sid })
db.getCollection('JobAdminLog').find({ "describe" : "�������߷�Ʊʧ��,������ˮ�ţ�" + sid })
