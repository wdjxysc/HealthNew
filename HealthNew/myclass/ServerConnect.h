//
//  ServerConnect.h
//  HealthABC
//
//  Created by 夏 伟 on 13-12-4.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ServerConnect : NSObject

+(NSData *)doSyncRequest:(NSString *)urlString;
+(NSDictionary *)getDictionaryByUrl:(NSString *)url;

+(NSString *)Login:(NSString *)url;

+(NSDictionary *)getUserInfo:(NSString *)url;
+(NSDictionary *)requestCheckCode:(NSString *)url;
+(NSDictionary *)feedBackCheckCode:(NSString *)url;

+(NSDictionary *)uploadBloodPressureData:(NSDictionary *)datadic authkey:(NSString *)authkey;
+(void)getBloodPressureDataFromCloud:(NSDate *)starttime;

+(NSDictionary *)uploadGlucoseData:(NSDictionary *)datadic authkey:(NSString *)authkey;
+(void)getGlucoseDataFromCloud:(NSDate *)starttime;

+(BOOL)uploadUserInfo:(NSString *)url;

+(BOOL)isConnectionAvailable;
+(BOOL)backCheckCode:(NSString *)url;

+(BOOL)resetPassword:(NSString *)url;



//邮箱注册
+(NSString *)registByEmail:(NSString *)email password:(NSString *)password;
//邮箱找回密码时请求验证码
+(NSDictionary *)getCheckCodeByEmail:(NSString *)email;
//邮箱找回密码时发送获得的验证码
+(NSDictionary *)checkCheckCode:(NSString *)email checkcode:(NSString *)checkcode;
//邮箱找回密码时设置新密码
+(NSDictionary *)resetPasswordByEmail:(NSString *)email newpassword:(NSString *)newpassword;

/**
 *获取应用列表 toolType	工具类别：1-安卓， 3-ios
 *           offset		偏移量：从第几条开始查
 */
+(NSDictionary *)getAppList:(int) tooltype offset : (int) offset;


//【**********【根据商品名称和商家id查询商品信息】**********】
//[参数]：
//productVo.product_name（商品名称，选填）
//merchant_id(商家ID，1、淘宝商城 2、京东商城 3、爱康国宾 4、有机生活 5、巴马水，选填)
//[请求示例]：http://localhost/sys/productManage_queryProductListByApp?productVo.product_name=&merchant_id=5
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_queryProductListByApp?productVo.product_name=&merchant_id=5
+(NSArray *)getProductList:(NSString *)productName merchant_id:(NSString *)merchant_id;


//【**********【关注商品】**********】
//[参数]：
//productAttentionVo.product_id(商品id，必填)
//productAttentionVo.merchant_id(商家id,1、淘宝商城 2、京东商城 3、爱康国宾 4、有机生活 5、巴马水,必填)
//authkey(登录时获取的authkey，必填)
//[请求示例]：http://localhost/sys/productManage_addProductAttention?productAttentionVo.product_id=74&productAttentionVo.merchant_id=4&authkey=87
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_addProductAttention?productAttentionVo.product_id=74&productAttentionVo.merchant_id=4&authkey=87
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-操作成功；2-操作失败；3-传入的authkey无效；）
//RESULT_MSG（响应信息）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":1}]
+(NSArray *)addProductAttention:(int)product_id merchant_id:(int)merchant_id authkey:(NSString *)authkey;


//【**********【查看当前用户的关注商品信息】**********】
//[参数]：
//authkey(登录时获取的authkey，必填)
//[请求示例]：http://localhost/sys/productManage_queryProductAttention?authkey=87
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_queryProductAttention?authkey=87
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-您未曾关注过商品；2-操作成功；3-传入的authkey无效；）
//RESULT_MSG（响应信息）
//RESULT_INFO（查询结果）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":2,
//    "RESULT_INFO":
//    [{"ATTENTION_TIME":"2014-06-16 00:00","ATTENTION_ID":1,"PRODUCT_NAME":"护照","PRODUCT_IMAGEURL":"http://192.168.110.32/sys/productManage_showImg?imgName=8c730eb7feaf454281ab7f01fc054be0.jpg","MERCHANT_LINKURL":"http://www.bmsjb.com","PRODUCT_DESCRIPTION":"物美价廉"},
//     {"ATTENTION_TIME":"2014-06-16 00:00","ATTENTION_ID":4,"PRODUCT_NAME":"护照","PRODUCT_IMAGEURL":"http://192.168.110.32/sys/productManage_showImg?imgName=c1c557e1296f4a2dae2047e7c5a6f81e.jpg","MERCHANT_LINKURL":"http://www.bmsjb.com","PRODUCT_DESCRIPTION":"物美价廉"}]}]
+(NSArray *)queryProductAttention : (NSString *)authkey;


//【**********【根据用户选中的取消关注id，取消关注商品】**********】
//[参数]：
//productAttentionVo.attention_id(关注ID，必填)
//[请求示例]：http://localhost/sys/productManage_deleteProductAttention?productAttentionVo.attention_id=1
//[本地测试地址]：http://192.168.110.32:80/sys/productManage_deleteProductAttention?productAttentionVo.attention_id=1
//[响应码]：
//RESULT_CODE（响应码：0-参数获取失败；1-操作成功；2-操作失败；）
//RESULT_MSG（响应信息）
//[响应示例]：[{"RESULT_MSG":"操作成功","RESULT_CODE":1}]
+(NSArray *)deleteProductAttention :(NSString *)attention_id;


//【**********【自动生成随机账号的】**********】
//http://localhost:8080/service/ehealth_userRegister?autoregister=autoregister&dtype=18
//
//你的登录名 nickname 密码 pwd
//{"success":true,"authkey":"ZWM3MTBkYjIzZGIzNDc0NGFjMWUwZTdjOWEzZWViMmEjMjAxNC0wNi0xOCAxNzowNDozOSMxOCN6%0D%0AaF9DTg%3D%3D","username":"s1403082279464","nickname":"q25LMYw5","pwd":"666666"}
+(NSDictionary *)autoRegister;


//浏览记录接口协议
//1.上传数据
//数据字段说明:
//authkey(登录获取 必填,非空)
//time(当前本地时间 必填,非空)
//url(浏览的链接url 必填,非空)
//pro(链接描述 必填,非空)
//result_code 说明:
//10 服务器异常, 1: 参数错误 2:数据入库错误  0:成功 3:授权key不合法
//接口实例:
//http://localhost:8080/sys/service_uploadHistoryScan?authkey=MDU4ZGI3YmJjNDVlNGQyZGI0MDY5NjZkYmRhZmM4YjIjMjAxNC0wNi0xMCAxNzowNjoyOSMxOCN6%0D%0AaF9DTg%3D%3D&time=2014-01-20%2012:11:20&url=100&pro=1220
//正确返回:{"RESULT_MSG":"上传成功","RESULT_CODE":"0"}
+(NSDictionary *)uploadHistoryScan : (NSString *)authkey time:(NSDate *)time linkurl:(NSString *)linkurl pro:(NSString *)pro;


//2.查询
//数据字段说明:
//authkey(登录获取 必填,非空)
//number(几条为一页 必填.非空)
//date(日期,哪一天的记录, 可选)
//result_code 说明:
//10: 服务器错误  0:成功 1:参数错误 2:数据库操作异常 3:授权key不合法 4:不存在这个用户
//接口实例:
//http://localhost:8080/sys/service_getHistoryScan?authkey=MDU4ZGI3YmJjNDVlNGQyZGI0MDY5NjZkYmRhZmM4YjIjMjAxNC0wNi0xMCAxNzowNjoyOSMxOCN6%0D%0AaF9DTg%3D%3D&number=5
//正确返回:
//{"RESULT_MSG":"操作成功","RESULT_CODE":"0","RESULT_INFO":{"count":2,"historyInfo":[{"callbacks":[{}],"id":"058db7bbc45e4d2db406966dbdafc8b2","prospectus":"1220","status":"0","time":"2014-01-20 12:11:20","url":"100"},{"callbacks":[{}],"id":"058db7bbc45e4d2db406966dbdafc8b2","prospectus":"200202","status":"0","time":"2014-01-20 12:11:20","url":"020"}]}}
+(NSDictionary *)getHistoryScan :(NSString *)authkey number : (int)number date:(NSDate *)date;


//呵护血压/呵护血糖
//
//number:		第几次    1，2,3,4appTypeId:
//App类型：       1-呵护血压App，2-呵护血糖App，
//
//http://test.ebelter.com/sys/appBlood_terminalGetContent?appTypeId=2&number=4&bloodvalue=10.0
//
//RESULT_MSG  返回信息
//RESULT_CODE 返回操作码
//RESULT_INFO 返回数据
//RESULT_FA	返回方案数据
//RESULT_YF	返回预防数据
//contentSummary	内容概要
//thumbnailUrl	图片URL
//conetentTitle	内容标题
//typeName	方案类型名称
//{
//    "RESULT_MSG": "操作成功",
//    "RESULT_CODE": 0,
//    "RESULT_INFO": {
//        "RESULT_FA": {
//            "typeName": "情志调理",
//            "contentSummary": "vvvvvvvvvvvvvvvv",
//            "thumbnailUrl": "http://192.168.110.36:8088/sys/appBlood_showImage?imageFileName=9312cfeea2bb4fc5aff00e035a1c5e66.png",
//            "conetentTitle": "vvvvvvvvvvvvvvvvvv"
//        },
//        "RESULT_YF": {
//            "contentSummary": "zzzzzzzzzzzz",
//            "thumbnailUrl": "http://192.168.110.36:8088/sys/appBlood_showImage?imageFileName=9312cfeea2bb4fc5aff00e035a1c5e66.png",
//            "conetentTitle": "zzzzzzzzzzzzzzzz"
//        }
//    }
//}
+(NSDictionary *)terminalGetContent :(int)apptypeid number:(int)number bloodvalue:(float)bloodvalue;


//获取问题列表
//
//appTypeId:	App类型（1-呵护血压App，2-呵护血糖App)
//
//http://192.168.110.36:8088/sys/appBlood_terminalGetQuestion?appTypeId=2
//
//RESULT_MSG  返回信息
//RESULT_CODE 返回操作码
//RESULT_INFO 返回数据
//questionId		问题Id
//questionContent		问题内容
//
//{
//    "RESULT_MSG": "操作成功",
//    "RESULT_CODE": 0,
//    "RESULT_INFO": [
//                    {
//                        "questionId": "4",
//                        "questionContent": "ddddddddd"
//                    },
//                    {
//                        "questionId": "5",
//                        "questionContent": "eeeeee"
//                    }
//                    ]
//}
+(NSDictionary *)terminalGetQuestion :(int)apptypeid;


//获取答案列表
//
//questionId	问题Id
//
//http://192.168.110.36:8088/sys/appBlood_terminalGetAnswer?questionId=2
//
//RESULT_MSG  返回信息
//RESULT_CODE 返回操作码
//RESULT_INFO 返回数据
//answerContent		答案内容
//answerTitle		答案标题
//thumbnailUrl		图片URL
//
//{
//    "RESULT_MSG": "操作成功",
//    "RESULT_CODE": 0,
//    "RESULT_INFO": [
//                    {
//                        "answerContent": "bbbbbbbbbbbb",
//                        "answerTitle": "bbbbbbbbbb",
//                        "thumbnailUrl": "bbb"
//                    },
//                    {
//                        "answerContent": "wwwwwwwwwwwwwwwwwwwwwww",
//                        "answerTitle": "wwwwwwwwwwww",
//                        "thumbnailUrl": "wwwwwwwwwwwwwww"
//                    }
//                    ]
//}
+(NSDictionary *)terminalGetAnswer : (int)questionid;


//用户中心获取资料接口：
//http://localhost:8080/service/ehealth_getUserInfo?authkey=ZWQyMTY3MjY2OGU4NDljOWI5MmU0OGFkNTcyNDBiNTcjMjAxNC0wNy0xOCAxMDowNTo1NCMxOCN6%0D%0AaF9DTg%3D%3D&time=2013-11-26
//
//[
// {
//     "like_name": "BET00000006",
//     "userid": "0689d18aa33c4f5fa15af38f5bbedc48",
//     "age": "34",
//     "profesion": "1",
//     "sex": "0",
//     "birthday": "1980-01-01",
//     "height": "181.0",
//     "weight": "66.1",
//     "stepSize": "null",
//     "mobile": "null",
//     "address": "null",
//     "email": "null"
// }
// ]
+(NSDictionary *)ehealth_getUserInfo : (NSString *)authkey;
@end
