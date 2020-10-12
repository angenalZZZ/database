//db.getCollection('JobAdminLog').find({  })
var sid = "FEI20170919100060752";
db.getCollection('JobAdminLog').find({ "describe" : "百旺开票请求,请求流水号：" + sid })
db.getCollection('JobAdminLog').find({ "describe" : "百旺开票响应,请求流水号：" + sid })
db.getCollection('JobAdminLog').find({ "describe" : "百旺开具发票失败,请求流水号：" + sid })
