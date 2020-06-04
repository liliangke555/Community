//
//  UrlUtils.h
//  IR_HowJoy_iphone
//
//  Created by gzdlw on 14-12-24.
//  Copyright (c) 2014年 gzdlw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlUtils.h"
#import "StringUtils.h"
#import "ResidentLoginVo.h"
#import "JsonUitls.h"

//18.9.5更换测试环境地址,因为使用4g无法访问test.lookdoor.cn的域名
#define URL_SERVER_ADDRESS_TEST                         @"tc.lookdoor.cn"
#define URL_SERVER_PORT_TEST                            @"6443"
//#define URL_SERVER_ADDRESS_TEST                         @"192.168.41.7"
//#define URL_SERVER_PORT_TEST                            @"8080"
//#define URL_SERVER_PORT_TEST                            @"9001"

#define URL_SERVER_ADDRESS_PRODUCT                      @"api.lookdoor.cn"
#define URL_SERVER_PORT_PRODUCT                         @"443"

//#define URL_SERVER_ADDRESS_PRODUCT                      @"yanshi.lookdoor.cn"
//#define URL_SERVER_PORT_PRODUCT                         @"443"

#define URL_SERVLETPATTERN_LOGIN                        @"/func/hjapp/user/v1/login.json"                           // app登陆
#define URL_SERVLETPATTERN_SINGLE_LOGIN                 @"/func/hjapp/user/v1/loginReturnValues.json"               // 获取登录vo信息的接口 (供更新数据用)

#define URL_SERVLETPATTERN_REGIST                       @"/func/hjapp/user/v1/register.json"                        //注册
#define URL_SERVLETPATTERN_UPDATE_RESIDENTCODE          @"/func/hjapp/user/v1/updateResidentLogin.json"             //重新获取验证码  根据手机号获取验证码
#define URL_SERVLETPATTERN_CHECKRESIDENTLOGINCODE       @"/func/hjapp/user/v1/checkResidentLogin.json"              //上传验证码到服务器验证
#define URL_SEND_LOGIN_CODE                             @"/func/hjapp/user/v1/sendLoginCheckCode.json"              //发送登录验证验证码 loginNum=
#define URL_CHECK_LOGIN_CODE                            @"/func/hjapp/user/v1/validLoginCheckCode.json"             //验证登录验证验证码 loginNum= & checkCode=
#define URL_SERVLETPATTERN_FORGETLOGINPWD               @"/func/hjapp/user/v1/forgetResidentLoginPassword.json"     //忘记密码 重置新密码 上传电话号与新密码
#define URL_HJ_APP_UPDATE_RESIDENT_BASE_INFO            @"/func/hjapp/user/v1/updateResidentBaseInfo.json"          //修改居民信息
#define URL_HJ_APP_ADD_MOMENTINFO                       @"/func/hjapp/live/v1/addMommentInfo.json"                  //提交分享信息  （发状态）
#define URL_HJ_APP_ADD_MOMENTINFO_GROUP                 @"/func/hjapp/groupPurchase/v1/addGroupPurchaseInfo.json"   //提交分享拼团信息
#define URL_HJ_APP_UPLOAD_VIDEO_FILE                    @"/func/hjapp/live/v1/uploadMomentVideo.json"               //上传视频接口 mId=<信息ID>&视频流
#define URL_HJ_APP_MOMENTINTO_LIST                      @"/func/hjapp/live/v1/momentInfoList.json"                  //查看分享消息?pageSize=<每页数量>&cDt=<创建日期>&type<操作类型>&loginId=<用户id>(查询单个用户信息时必填)&idList=<加载更多时传的id，参数类型为List<String>>
#define URL_HJ_APP_COUNT_MOMENT_REMIND                  @"/func/hjapp/live/v1/countMomentRemind.json"               //获取邻里圈消息提醒条数
#define URL_HJ_APP_FIND_MOMENT_REMIND_INFO              @"/func/hjapp/live/v1/findMomentRemindInfo.json"            //获取邻里圈消息提醒信息
#define URL_HJ_APP_DELETE_MOMENT_REMIND_INFO            @"/func/hjapp/live/v1/deleteMomentRemindInfo.json"          //删除邻里圈消息提醒信息?idList=<id>
#define URL_HJ_APP_FIND_MOMENT_INFO_BY_IDS              @"/func/hjapp/live/v1/findMomentInfoByIds.json"             //批量查询邻里圈消息?idList=<id>

#define URL_HJ_APP_SELECT_LIKE_PERSON                   @"/func/hjapp/live/v1/selectLikePerson.json"                //查看点赞人以及评论信息?mId=<分享信息ID>
#define URL_HJ_APP_OPERATELIKE                          @"/func/hjapp/live/v1/operateLike.json"                     //点赞或者取消点赞?mId=<分享信息ID>&rLi=<用户id>&vFg=<点赞或者取消点赞>
#define URL_HJ_APP_ADD_COMMENT                          @"/func/hjapp/live/v1/addComment.json"                      //添加评论?MomentCommentVo
#define URL_HJ_APP_DELETE_COMMENT                       @"/func/hjapp/live/v1/deleteCommentById.json"               //删除我的评论
#define URL_HJ_APP_UPDATE_MOMENT_BY_ID                  @"/func/hjapp/live/v1/updateMomentByid.json"                //删除分享?mId=<分享信息ID>
#define URL_HJ_APP_REPORT_MOMENTINFO                    @"/func/hjapp/live/v1/reportMomentInfo.json"                //举报分享信息?ReportMomentInfoVo
#define URL_SERVLETPATTERN_PHONE_CHECK_DOOR             @"/func/hjapp/house/v1/phoneOpenDoor.json"                  //开门
#define URL_HJ_APP_GET_EQUIPMENT_ACCESS_LIST            @"/func/hjapp/house/v1/getEquipAccessListNew.json"          //获取开门门禁?bCd=<小区名称（非必填）>
#define URL_HJ_APP_GET_EQUIPMENT_TYPE                   @"/func/hjapp/house/v1/queryDoorType.json"                  //轮询门禁状态?equipmentId=<门禁id>
#define URL_SERVLETPATTERN_DOOR_TYPE                    @"/func/hjapp/house/v1/doorType.json"                       //获取门状态
#define URL_SERVLETPATTERN_PUSH_OPENDOOR_SN             @"/func/hjapp/house/v1/pushOpenDoorBySn.json"               //通过sn推送开门
#define URL_HJ_APP_FEED_BACK                            @"/func/hjapp/user/v1/adviceFeedback.json"                  //上传意见反馈
#define URL_SERVLETPATTERN_EXPECTINDEXDETAIL            @"/func/hjapp/index/v1/itemDetail.json"                     //守望指数详细    月记录
#define URL_SERVLETPATTERN_EXPECTINDEXDETAIL_WEEK       @"/func/hjapp/index/v1/itemWeekDetail.json"                 //守望指数详细    周记录
#define URL_SERVLETPATTERN_EXPECTINDEXMONTH             @"/func/hjapp/index/v1/monthData.json"                      //守望指数       月记录
#define URL_SERVLETPATTERN_EXPECT_INDEX_WEEK            @"/func/hjapp/index/v1/weekData.json"                       //守望指数       周记录
#define URL_SERVLETPATTERN_VALIDATE_QRCODE              @"/func/hjapp/live/v1/validateQrcode.json"                  //验证二维码是否有效 参数:qrcodeInfo = <>
#define URL_SERVLETPATTERN_SCAN_CODE_LIVE               @"/func/hjapp/live/v1/scanCodeLive.json"                    //扫码入住? hCd=<housecode>
#define URL_SERVLETPATTERN_QUERY_MYHOUSE_INFO           @"/func/hjapp/confirm/v1/queryLiveHouse.json"               //根据houseCode查询房屋信息
#define URL_SERVLETPATTERN_QUERY_HOUSE_OWNER            @"/func/hjapp/confirm/v1/queryHouseExitOwner.json"          //根据houseCode查询房屋是否有房主 hCd = <houseCode>  code=200 有房主
#define URL_SERVLETPATTERN_QUERY_HOUSE_LIVE_INFO        @"/func/hjapp/confirm/v1/queryHouseLiveInfo.json"           //房屋居住信息查询?hCd=<房屋编码>
#define URL_SERVLETPATTERN_MOVE_OUT_OF_ROOM             @"/func/hjapp/confirm/v1/moveOutOfRoom.json"                //移出房间?residentid=<居民信息ID>&hCd=<房屋编码>&reason=<移出原因>
#define URL_SERVLETPATTERN_FIND_SET_PHONE_OPEN_DOOR     @"/func/hjapp/house/v1/findSetPhoneOpenDoor.json"           //查询房号开门电话信息？houseCode=<>返回SetPhoneOpenDoorLdVo对象
#define URL_SERVLETPATTERN_SAVE_SET_PHONE_OPEN_DOOR     @"/func/hjapp/house/v1/saveSetPhoneOpenDoor.json"           //保存房号开门电话信息？SetPhoneOpenDoorLdVo=<?>返回200

#define URL_SERVLETPATTERN_MsgGetList                   @"/func/hjapp/msg/v1/getList.json"                          //获取消息
#define URL_SERVLETPATTERN_TELLSERVER_RECIEVEMESSAGE    @"/func/hjapp/msg/v1/delMsgs.json"                          //告诉服务器收到消息了
#define URL_SERVLETPATTERN_UPDATE_LOGIN_PWD             @"/func/hjapp/user/v1/updateResidentLoginPassword.json"     //更改登录密码?uNm=登录名&pWd=新密码&pWo=旧密码
#define URL_SERVLETPATTERN_UPLOAD_USERINFO              @"/func/hjapp/confirm/v1/addResidentInfoCheck.json"         //身份验证
#define URL_SERVLETPATTERN_HOUSE_OWNER                  @"/func/hjapp/confirm/v1/queryHouseOwnerCheckInfo.json"     //房主验证  查看
#define URL_SERVLETPATTERN_ADD_HOUSE_OWNER              @"/func/hjapp/confirm/v1/addHouseOwnerCheckInfo.json"       //房主验证 添加
#define URL_SERVLETPATTERN_ZHIMACERTIFY                 @"/func/hjapp/user/v1/zhima_certify.json"                   //芝麻认证
#define URL_SERVLETPATTERN_ZHIMAQUERY                   @"/func/hjapp/user/v1/zhima_query.json"                     //芝麻认证结果查询

#define URL_HJ_APP_SAVE_HEADINGIMG                      @"/func/hjapp/user/v1/saveHeadImg.json"                     //上传头像到服务器
#define URL_HJ_APP_FIND_RESIDENT_BASE_INFO              @"/func/hjapp/user/v2/findResidentBaseInfo.json"            //查询居民信息
#define URL_HJ_APP_UPDATE_RESIDENT_BASE_INFO            @"/func/hjapp/user/v1/updateResidentBaseInfo.json"          //修改居民信息
#define URL_HJ_APP_SENT_CODE                            @"/func/hjapp/user/v1/sendCodeToPhone.json"                 //绑定手机号-发送验证码
#define URL_HJ_APP_UPDATEPHONE                          @"/func/hjapp/user/v1/updatePhoneNumber.json"               //绑定手机号-修改手机号
#define URL_HJ_APP_UPLOAD_CRASH_LOG                     @"/func/hjapp/terminalLog/v1/uploadErrorLog.json?"          //上传本地崩溃日志
#define URL_HJ_APP_UPDATE_SWITCH                        @"/func/hjapp/softapk/v1/iosUpdateKey.json"                 //查看app更新 后台设置是否打开
#define URL_HJ_APP_FIND_NEIGHBOUR                       @"/func/hjapp/live/v1/findNeighbor.json"                    //查看当前小区的tableview居民数据 <bCd=小区code>
#define URL_HJ_APP_FIND_NEIGHBOUR_INFO                  @"/func/hjapp/live/v1/findNeighborInfo.json"                //查看当前小区的collectionview居民数据 <bCd=小区code>
#define URL_HJ_APP_LOGINOUT                             @"/func/hjapp/user/v1/logout.json"                          //登出操作

#define URL_HJ_APP_CHECKUSERINFOWITHUSERID              @"/func/hjapp/im/v1/get_im_user.json"                       //通过电话查询用户
#define URL_HJ_APP_FINDLASTNOTICE                       @"/func/hjapp/notice/find_plateform_last_notice.json"       //查询各平台最新公告
#define URL_HJ_APP_FINDSOMENOTICE                       @"/func/hjapp/notice/find_plateform_notice.json"            //查询当前平台更早的数据
#define URL_HJ_APP_FINDSOMESYSTEM                       @"/func/hjapp/msg/v1/getHistoryList.json"                   //查询系统消息更早数据  type=<消息类型>&pageSize=<拉取条数>&updateTime=<更新时间>
#define URL_HJ_APP_ADD_READ_OPERATION                   @"/func/hjapp/notice/v1/addReadOperation.json"              //上传当前平台消息阅读标志 noticeId = ?
#define URL_HJ_APP_GETSERVICE                           @"/func/hjapp/im/v1/get_service.json"                       //POI 类目获取分类
#define URL_HJ_APP_POICTG                               @"/func/hjapp/poi/v1/poictg.json"
#define URL_HJ_APP_COLLECTION                           @"/func/hjapp/poi/v1/favorite.json"                         //  收藏 店铺
#define URL_HJ_APP_FAVORITE_LIST                        @"/func/hjapp/poi/v1/favorite_list.json"                    //  获取收藏列表
#define  URL_HJ_APP_ISFAVORITE                          @"/func/hjapp/poi/v1/isfavorite.json"                       //  是否被搜藏过
#define URL_UPDATE_POICALLCOUNT                         @"/func/hjapp/poi/v1/update_poi_callcount.json"             //  拨打商家电话时更新拨打次数
#define URL_POICALLCOUNT                                @"/func/hjapp/poi/v1/poi_callcount.json"                    //  获取商家电话拨打次数

#define URL_HJ_APP_ADDMERCHANT_INFO                     @"/func/hjapp/merchant/v1/addMerchantInfo.json"             //  添加商户信息审核信息
#define URL_HJ_APP_QUERY_CHECK_INFO                     @"/func/hjapp/merchant/v1/queryCheckInfo.json"              //  查询商家信息审核

#define URL_HJ_APP_GET_INDEX_INFO_VO                    @"/func/hjapp/index/v1/getSlideShow.json"                   //  查询当前小区的首页数据 bCd = <小区code>
#define URL_HJ_APP_GET_SLIDE_CONTENT_BY_ID              @"/func/hjapp/index/v1/getSlideContentById.json"            //  查询轮播图图文信息数据 id = <内容id>
#define URL_HJ_APP_GET_BLOCK_INFO_IN_2KM                @"/func/hjapp/checkIn/v1/queryBlockInfo.json"               // lng=<经度>&lat=<纬度>查询2KM范围内的小区信息
#define URL_HJ_APP_ADD_CHECK_IN_BLOCK_INFO              @"/func/hjapp/checkIn/v1/addBlockInfo.json"                 // 添加小区申请信息 参数为BlockApplyVo
#define URL_HJ_APP_QUERY_CHECK_IN_BUILDING_INFO         @"/func/hjapp/checkIn/v1/queryBuildingInfo.json"            // 居民认证入住审核-查询楼栋信息?bCd=<小区code>
#define URL_HJ_APP_QUERY_CHECK_IN_HOUSE_INFO            @"/func/hjapp/checkIn/v1/queryHouseInfo.json"               // 居民认证入住审核-查询房屋信息?buildingCode=<房屋code>&uNt=<单元号>
#define URL_HJ_APP_ADD_CHECK_IN_EVIDENCE                @"/func/hjapp/residentSelfRegistration/add.json"            // 添加认证信息 参数为ResidentSelfRegistrationVo
#define URL_HJ_APP_QUERY_CHECK_IN_INFO_NEW              @"/func/hjapp/residentSelfRegistration/v1/queryNew.json"    // 查询认证入住审核信息
#define URL_HJ_APP_QUERY_CHECK_IN_INFO                  @"/func/hjapp/residentSelfRegistration/query.json"          // 查询认证入住审核信息

#define URL_HJ_APP_EDU_REPORT                           @"/func/hjapp/student/v1/initInfo.json"                     // 校园学生 开启学生生活
#define URL_HJ_APP_EDU_REGISTER                         @"/func/hjapp/student/v1/register.json"                     // 校园学生注册 name=周坤&identification=522127198802112549&blockCode=5201110001

#define URL_HJ_APP_EDU_QUERY_DORMITORY_INFO             @"/func/hjapp/confirm/v1/queryHouseLiveInfoByBlockCode.json"    //  查询学生寝室信息 bCd = 小区code
#define URL_HJ_APP_EDU_CLASSCONTACTS                    @"/func/hjapp/student/v1/class_contacts.json"                   // 校园版：班级通讯录
#define URL_HJ_APP_EDU_SCHOOLCONTACTS                   @"/func/hjapp/student/v1/school_contacts.json"                  // 校园版：校园通讯录
#define URL_HJ_APP_EDU_GETEMERGENCY                     @"/func/hjapp/student/v1/get_emergency.json"                    // 校园版：获取紧急联系人信息
#define URL_HJ_APP_EDU_SAVEEMERGENCY                    @"/func/hjapp/student/v1/save_emergency.json"                   // 校园版：保存紧急联系人信息
#define URL_HJ_APP_CHECK_TRIBE_TYPE_FROM_SERVER         @"/func/hjapp/student/v1/tribeExist.json"                       // 校园版: 查看当前群是否是校园群 tribeId= ?


#define URL_HJ_APP_SAVRORUPDATERELATION                 @"/func/hjapp/famliy/v1/saveOrUpdateRelation.json"              //我的家人：新增或者修改家人关系标签
#define URL_HJ_APP_FINDMYFAMLIYINFO                     @"/func/hjapp/famliy/v1/findMyFamliyInfo.json"                  //我的家人：查询我的家人信息
#define URL_HJ_APP_ADDFAMLIYINFO                        @"/func/hjapp/famliy/v1/addFamliyInfo.json"                     //我的家人：新增家人
#define URL_HJ_APP_FIND_MYRELATIONFAMILY                @"/func/hjapp/famliy/v1/findMyRelationFamliyInfo.json"          //我的家人信息查询 参数为type（1:帮扶 2：儿童走失）
#define URL_HJ_APP_FIND_SUPPORT_CONTENT                 @"/func/hjapp/famliy/v1/findSupportContent.json"                //查询小区帮扶内容 &blockCode=<小区code>
#define URL_HJ_APP_FIND_EMERGENCY_CONTACT               @"/func/hjapp/famliy/v1/findEmergencyContactInfo.json"          //查询小区的紧急联系电话 blockCode = ？
#define URL_HJ_APP_EMERGENCYLIST                        @"/func/hjapp/emergency/phone/v1/list.json"                     //新改动：查询小区的紧急联系电话 bCd = ？
#define URL_HJ_APP_ADDPETINFO                           @"/func/hjapp/famliy/v1/addPetInfo.json"                        //我的家人：添加我的宠物信息
#define URL_HJ_APP_FINDPETINFO                          @"/func/hjapp/famliy/v1/findPetInfo.json"                       //我的家人：查询我的宠物信息
#define URL_HJ_APP_FINDPETINFOBYPETID                   @"/func/hjapp/famliy/v1/findPetInfoByPetId.json"                //我的家人：编辑宠物查询宠物信息
#define URL_HJ_APP_FIND_RELATIONS_FAMILY                @"/func/hjapp/famliy/v1/findMyRelationFamliyInfo.json"          //我的家人: 查询有关联关系的家人信息
#define URL_HJ_APP_FINDLIVEINADDRESS                    @"/func/hjapp/famliy/v1/findLiveInAddress.json"                 //我的家人: 查询居住详细地址
#define URL_HJ_APP_ADD_LOST_INFORMATION                 @"/func/hjapp/famliy/v1/addLostInfo.json"                       //走失发布
#define URL_HJ_APP_FIND_LOST_INFORMATION                @"/func/hjapp/famliy/v1/findLostInfo.json"                      //走失发布 查询走失人员信息 管理
#define URL_HJ_APP_UPDATE_LOST_INFORMATION              @"/func/hjapp/famliy/v1/updateLostInfo.json"                    //走失发布 更新走失人员信息 lostId=<走失信息id>
#define URL_HJ_APP_FINDREFUNDINFO                       @"/func/hjapp/famliy/v1/findRefundInfo.json"                    //我的钱包 查询是否有正在退款的记录
#define URL_HJ_APP_ADDREFUNDINFO                        @"/func/hjapp/famliy/v1/addRefundInfo.json"                     //我的钱包 申请退款
//支付相关
#define URL_HJ_APP_QUERYAMOUNT                          @"/func/hjapp/pay/queryAmount.json"                             //我的钱包 查询保证金余额
#define URL_HJ_APP_REQPINGPPPAY                         @"/func/hjapp/pay/pingpp/reqPayInfo.json"                       //我的钱包 发起ping++支付请求
//协议相关
#define URL_HJ_APP_PAYPROTOCOL                          @"/static/html5/protocol/pay_protocol.html"                    //支付协议
#define URL_HJ_APP_PRIVACYPROTOCOL                      @"/static/html5/protocol/privacy_protocol.html"                //隐私协议
#define URL_HJ_APP_SERVICEPROTOCOL                      @"/static/html5/protocol/service_protocol.html"                //服务协议

//人像开门
#define URL_HJ_APP_GET_USER_FACE_IMAGE                  @"/func/hjapp/confirm/v1/getResidentOpenDoorImage.json"         //获取人像开门照片
#define URL_HJ_APP_UPDATE_USER_FACE_IMAGE               @"/func/hjapp/confirm/v1/updateResidentOpenDoorImage.json"      //修改人像开门照片  参数:imageUrlPath

//举报投诉建议相关
#define URL_HJ_APP_ADDFEEDBACKINFO                      @"/func/hjapp/feedback/v1/addFeedbackInfo.json"                //添加投诉建议、举报处置信息 参数为FeedbackInfoVo
#define URL_HJ_APP_GRADEFEEDBACKINFO                    @"/func/hjapp/feedback/v1/gradeFeedbackInfo.json"              //评分？feedbackInfoId=<信息ID>&grade=<分数>
#define URL_HJ_APP_FINDFEEDBACKINFO                     @"/func/hjapp/feedback/v1/findFeedbackInfo.json"                //查询居民提交的举报投诉信息
#define URL_HJ_APP_SIGNAL_OPERATION                     @"/func/hjapp/im/v1/switchToAc.json"                            //信令操作 bizId=2&bizCode=200
#define URL_HJ_APP_GET_3TH_QRCODE_INFO                  @"/func/hjapp/qrcode/v1/generateQRCode.json"                    //查询第三方二维码数据接口 bCd = ?
#define URL_HJ_APP_PUSH_FEEDBACK                        @"/func/hjapp/push/v1/feedback.json"                            //守望领域 推送反馈接口 包含消息id及接收时间

#define URL_HJ_APP_UPLORD_FILE_BASE64                   @"/func/hjapp/comUpFileBase64.json"                             //fileBase64=   &uploadItem=
//uploadItem=residentLive 租客身份照片   uploadItem=contractRemark 合同备注照片
#define URL_HJ_APP_GET_LANDLORD_INFOR                   @"/func/hjapp/contract/v1/getLandlordInfo.json"                 //拉取当前房主身份信息
#define URL_HJ_APP_CHECK_HAS_CONTRACT                   @"/func/hjapp/contract/v1/checkHasContract.json"                //查询房屋是否签署过信息
#define URL_HJ_APP_SAVE_CONTRACT                        @"/func/hjapp/contract/v1/save.json"                            //保存合同信息
#define URL_HJ_APP_GET_CONTRACT_LIST                    @"/func/hjapp/contract/v1/list.json"                            //拉取合同列表

//公共接口 拉取省市区 信息接口
#define URL_HJ_APP_GET_PROVINCE                         @"/func/hjapp/region/v1/getProvince.json"                       //拉取省 列表 不需要参数
#define URL_HJ_APP_GET_CITY                             @"/func/hjapp/region/v1/getCity.json"                           //拉取市 列表 provinceCode=省编码
#define URL_HJ_APP_GET_AREA                             @"/func/hjapp/region/v1/getArea.json"                           //拉取区 列表 cityCode=市编码

//备案信息 接口
#define URL_HJ_APP_MERCHANT_BLOCK_LIST                  @"/func/hjapp/merchant/v1/getBlockList.json"                    //拉取当前范围内小区列表 region=
#define URL_HJ_APP_SAVE_FILLING_INFO                    @"/func/hjapp/merchant/v1/saveBackupInfo.json"                  //保存备案信息
#define URL_HJ_APP_GET_FILLING_LIST                     @"/func/hjapp/merchant/v1/getBackupInfoList.json"               //拉取备案信息列表

//居住信息 接口
#define URL_HJ_APP_GET_BUILDING_LIST                    @"/func/hjapp/model/v1/getBuildingList.json"
#define URL_HJ_APP_GET_UNIT_LIST                        @"/func/hjapp/model/v1/getUnitList.json"
#define URL_HJ_APP_GET_HOUSE_LIST                       @"/func/hjapp/model/v1/getHouseList.json"

//办事指南相关
#define URL_HJ_APP_GUIDEINDEX                           @"/static/html5/guide/index.html"                                 //政务办事指南

//隐私协议
#define URL_HJ_APP_SAVE_PRIVACE_VERSION                 @"/func/hjapp/user/v1/savePrivacyVersion.json"                     //保存隐私协议

//人机验证--投篮验证
#define URL_HJ_APP_SENDCODETOPHONE_BYVALID               @"/func/hjapp/user/v1/sendCodeToPhoneByValid.json"                     //投篮验证上传sessionId

//忘记密码流程新接口
#define URL_HJ_APP_SENDSMS_BYFORGETPASSWORD              @"/func/hjapp/nologin/user/v1/sendSmsByForgetPassword.json"                     //发送验证码phoneNum=
#define URL_HJ_APP_SAVE_BYFORGETPASSWORD                 @"/func/hjapp/nologin/user/v1/saveByForgetPassword.json"                        //检查验证码并且更新密码phoneNum=password=verificationCode=

//字典更换请求接口
#define URL_HJ_APP_GETDICTDATA                           @"/func/hjapp/dict/getDictData.json"   //请求字典接口

//获取最新的一条通话邀请指令
#define URL_HJ_APP_GETLASTCOMMAND                        @"/func/hjapp/im/v1/getLastCommand.json"
//判断门禁是否在线
#define URL_HJ_APP_ISACONLICE                            @"/func/hjapp/im/v1/isAcOnlice.json" //bizId=155089760338059264
//2019年10月14日添加，查询状态
#define URL_HJ_APP_GETRECORDSTATUS                       @"/func/hjapp/im/v1/getRecordStatus.json" //bizId=155089760338059264

//获取访客登记码
#define URL_HJ_APP_GENERATE_INVITECODE                   @"/func/hjapp/inviteCode/generate.json" //phoneNun=&blockCode=&houseCode=


//2019年11月05全平台安全功能相关接口
#define URL_HJAPP_NEW_LOGIN                              @"/func/hjapp/user/v2/login.json"  //登录接口
#define URL_HJAPP_NEW_FORGETPASSWORD                     @"/func/hjapp/user/v2/forgetPassword/resetPassword.json" //忘记密码接口
#define URL_HJAPP_NEW_UPDATEPASSWORD                     @"/func/hjapp/user/v2/updatePassword.json"  //修改密码接口
#define URL_HJAPP_NEW_REGISTER                           @"/func/hjapp/user/v2/register.json"  //注册接口
#define URL_HJAPP_NEW_GETPASSWORDAESKEY                  @"/func/hjapp/user/v2/getPasswordAesKey.json"  //获取对称加密的key接口
#define URL_HJAPP_NEW_GETVERIFYCODE                      @"/func/hjapp/user/v2/getVerifyCode.json"  //获取图片验证码接口
#define URL_HJAPP_NEW_CHECKVERIFYCODE                    @"/func/hjapp/user/v2/checkVerifyCode.json"  //校验验证码接口
#define URL_HJAPP_NEW_GETSESSIONID                       @"/func/hjapp/user/v2/getSessionId.json"  //获取当前会话的SessionId接口

//2020-01-08获取app协议url版本
#define URL_HJAPP_GET_AGREEMENT                          @"/func/hjapp/user/v1/getHjAppAgreement.json"
//2020-01-09获取h5token
#define URL_HJAPP_GET_HTMLToken                          @"/func/hjapp/h5/getH5Token.json"
#define URL_HJAPP_INSURANCEHTML                          @"/static/html5/insurance/index.html" //保险h5


#define URL_TIMEOUTINTERVAL                     10.0f             // 超时时间
#define URL_UPLOAD_TIMEOUT_INTERVAL             30.0f            // 上传大数据包 上传超时时间
#define URL_SERVLETURLPATTERNCLIENTRESPONSE     @"/hJ.svc"       // 服务器Servlet url pattern
#define URL_HANDLE                              @"h"             // 操作标志头
#define URL_PARAM_USERNAME                      @"pNn"           // 参数：用户名
#define URl_PARAM_LOGINID                       @"loginId"       // 参数: 单个用户信息
#define URL_PARAM_PASSWORD                      @"pWd"           // 参数：密码
#define URL_PARAM_PASSWORD_OLD                  @"pWo"           // 参数: 旧密码
#define URL_PARAM_PHONENUMBER                   @"pNn"           // 参数：电话号码
#define URL_PARAM_SECURITY_CODE                 @"pCc"           // 参数: 用户验证码
#define URL_PARAM_INFO_PAGE                     @"page"          // 参数: 页数（第几页）
#define URL_PARAM_INFO_PERPAGE                  @"pageSize"      // 参数: 每页数量
#define URL_PARAM_INFO_DATE                     @"cDt"           // 参数: 创建时间
#define URL_PARAM_FEED_BACK                     @"aFb"           // 参数: 意见反馈 参数
#define URL_PARAM_NEW_PHONENUM                  @"nPn"           // 参数: 新手机号
#define URL_PARAM_ID                            @"id"            // 参数: 商家申请id
#define URL_EQUIPMENT_FLAG                      @"equipmentFlag" // 参数: APP设备类型 1:IOS端 2:Andriod端
#define URL_PARAM_LoginNumber                   @"loginNum"      // 参数: 用户登录手机号
#define URL_PARAM_SecurityCode                  @"checkCode"     // 参数: 用户验证码

#define URL_PARAM_UPLOADOBJECT_ID                   @"uOi"              // 参数：上传大数据对象标识
#define URL_PARAM_UPLOADOBJECT_VALUE                @"uploadObject"     // 参数：上传大数据对象标识值
#define URL_PARAM_UPLOADFILE_ID                     @"uFi"              // 参数：上传文件标识
#define URL_PARAM_UPLOADFILE_VALUE                  @"uploadFile"       // 参数：上传文件标识值
#define URL_PARAM_NOTICE_ID                         @"noticeId"         // 参数: 平台消息id
#define URL_PARAM_UPDATETIME                        @"updateTime"       // 参数: 投票更新时间
#define URL_PARAM_QRCODE_INFO                       @"qrcodeInfo"       // 参数: 二维码(加密过得字符串)

#define SERVER_RESULT_NEED_LOGIN                    @"\"needLogin\""    // 参数：上传文件标识值

#define HTTP_STATUS_CODE_SCUESS                     200                 // http状态码：成功
#define RESPONSE_CODE_SESSION_OVER_CODE             2                   // 服务器返回code=2时，需要重新登录
#define Login_PWD_ERROR_CODE                        1006                // 用户名或密码错误
#define Door_Off_Line_CODE                          1049                // 门禁离线
#define Login_OUT_CODE                              1069                // 重复登录  需提醒强制下线
#define NEED_AUTONYM_CODE                           1074                // 未身份认证 需要身份认证后才能够扫码入住
#define QRCODE_INVALID_CODE                         1062                // 二维码过期 请重新生成
#define CIRCLE_NEED_AUTONYM_CODE                    1096                // 邻里圈点赞 评论 必须实名认证
#define UNSUPPORT_LONG_LIVE_CODE                    1099                // 不支持快速入住 也不支持自助入住
#define Emigration_CODE                             1117                // 用户居住的所有小区 都不覆盖有门禁 需要清空本地门禁缓存
#define WITHOUT_ACCESS_CODE                         1119                // 入住成功，请持有效证件至物业或社区代办点开通门禁开门权限
#define Equipment_Verify_CODE                       1164                // 用户更换设备登录 验证code 守望领域APP，更换设备，需要验证码
#define Phone_Has_Exist_CODE                        1027                // 用户已注册code
#define STRANGE_PHONE_CODE                          1169                // 陌生人需注册code
//2019年11月05全平台安全功能相关错误码
#define REDIRECT_UPDATEPASSWORD_CODE                302                 // 重定向至修改密码
#define USER_DONT_EXIST_CODE                        1005                 // 用户不存在
#define PASSWORD_CONTAIN_LETTER_CODE                1105                 // 强密码校验失败


#define URL_PARAM_BLOCKCODE                           @"bCd"                //参数 : 小区编码
#define URL_PARAM_CENTIFI                             @"rCf"                //参数 : 身份证号
#define URL_PARAM_HOMECODE                            @"hCd"                //参数 : 房屋编码
#define URL_PARAM_UNITCODE                            @"uNt"                //参数 : 单元号
#define URL_PARAM_PPERSON_PAGE                        @"page"               //参数 : 页数
#define URL_PARAM_PPERSON_PAGESIZE                    @"pageSize"           //参数 : 每页条数
#define URL_PARAM_PPERSON_UPDATETYPE                  @"type"               //参数 : 下拉刷新，初始化
#define URL_PARAM_PERSON_CIRCLE_INFO_ID               @"mId"                //参数 : 邻里圈信息id
#define URL_PARAM_MOMENT_INFO_ID_LIST                 @"idList"             //参数 : 邻里圈信息id 数组
#define URL_PARAM_PERSON_CIRCLE_PERSON_ID             @"rLi"                //参数 : 用户id
#define URL_PARAM_PERSON_CIRCLE_LIKE_DISLIKE          @"vFg"                //参数 : 点赞或取消赞  0: 赞 1: 取消赞
#define URL_PARAM_PERSON_RESIDENT_ID                  @"residentid"         //参数 : 居民信息id
#define URL_PARAM_USER_IM_ID                          @"residentId"         //参数 : 居民信息id
#define URL_PARAM_PERSON_OPERATORID                   @"operatorId"         //参数 : 操作人id
#define URL_PARAM_PERSON_OUT_REASON                   @"reason"             //参数 : 移出原因
#define URL_PARAM_RESIDENT_NAME                       @"residentName"       //参数 : 居民姓名
#define URL_PARAM_COMMENTID                           @"commentId"          //参数 : 评论ID
#define URL_PARAM_LATITUDE                            @"lat"                //参数 : 维度
#define URL_PARAM_LONGITUDE                           @"lng"                //参数 : 经度

#define URL_PARAM_BLOCK_CODE_NEW                      @"blockCode"          //参数 : 小区编码 （新  守望保障）
#define URL_PARAM_BUILDING_CODE                       @"buildingCode"       //参数 : 建筑楼栋code
#define URL_PARAM_HOUSE_CODE_NEW                      @"houseCode"          //参数 : 房间编码  (新  守望保障)
#define URL_PARAM_UNIT_CODE_NEW                       @"unitCode"           //参数 : 单元code
#define URL_PARAM_MESSAGE_MESSAGETYPE                 @"type"               //消息类型
#define URL_PARAM_MESSAGE_MESSAGEIDARRAY              @"msgIds"             //消息Id数组
#define URL_PARAM_CHAT_PHONENUM                       @"mobileNum"          //手机号
#define URL_PARAM_CHAT_USERID                         @"userId"             //USERID
#define URL_PARAM_EQUIPMENT_ID                        @"equipmentId"        //参数 : 门禁设备id
#define URL_PARAM_DEVICE_ID                           @"deviceId"           //参数 : 设备推送id
#define URL_PARAM_DEVICE_ID_NEW                       @"newDeviceId"        //参数 : 设备id 唯一标识符
#define URL_PARAM_NEIGHBOUR_INFO_TYPE                 @"category"           //参数 : 邻里圈信息类型标识符     老年人及儿童预警标识符  8失踪儿童 9老年人求助
#define URL_PARAM_PLATFORM_ID                           @"platformId"       //参数 : 平台id
#define URL_PARAM_MIN_DATE                              @"minDate"          //参数 : 手机端最小公告日期
#define URL_PARAM_CIRCLE_INFO_SOURCE                    @"source"           //参数 : 圈子信息来源 1:邻里圈 4:同学圈
#define URL_PARAM_POI                                   @"poi"              //参数 : poi
#define URL_POIUID                                      @"poiUid"           //参数 : 商家 uuid
#define URL_POIFIT                                      @"poiFt"            //参数 : 搜藏操作类型码 1收藏 2 取消收藏

#define URL_EDU_IDENTITY_NAME                           @"name"             //参数 : 校园版 身份证姓名
#define URL_EDU_IDENTITY_CODE                           @"identification"   //参数 : 校园版 身份证号码
#define URL_EDU_BLOCKCODE                               @"blockCode"        //参数 : 校园版 小区code
#define URL_EDU_TRIBE_ID                                @"tribeId"          //参数 : 校园版 群id


#define URL_PARAM_RELATIVERESIDENTID                    @"relativeResidentId" //参数 :我的家人 关联人id
#define URL_PARAM_RELATIONTYPE                          @"relationType"       //参数 :我的家人 关系type
#define URL_PARAM_RELATIONID                            @"relationId"         //参数 :我的家人 家人主键id
#define URL_PARAM_PETID                                 @"petId"              //参数 :我的家人 宠物id
#define URL_PARAM_LOST_ID                               @"lostId"             //参数 :提交发布 走失信息id
#define URL_PARAM_LOST_STATUS                           @"status"             //参数 :提交发布 走失状态 1已找到 0 未找到
#define URL_PARAM_AMOUNT                                @"amount"             //参数 :我的钱包 提现金额
#define URL_PARAM_TYPE                                  @"type"               //参数 :任务管理，走失管理 类型 1帮扶 2走失

#define URL_PARAM_RETURNURL                             @"returnUrl"            //参数 :芝麻认证，回调url
#define URL_PARAM_CERTNAME                              @"certName"             //参数 :芝麻认证，姓名
#define URL_PARAM_CERTNO                                @"certNo"               //参数 :芝麻认证，身份证
#define URL_PARAM_BIZNO                                 @"bizNo"                //参数 :芝麻认证查询，bizNo

//支付相关
#define URL_PARAM_CHANNEL                               @"channel"          //参数 :ping++支付，支付渠道alipay:支付宝 APP 支付、wx:微信 APP 支付
#define URL_PARAM_AMOUNT                                @"amount"           //参数 :ping++支付，金额
#define URL_PARAM_PINGTYPE                              @"type"             //参数 :充值类型：1：保证金，2：余额
#define URL_PARAM_SUBTITLE                              @"subTitle"         //参数 :充值业务描述

//举报投诉的评分
#define URL_PARAM_FEEDBACKINFOID                        @"feedbackInfoId"  //参数:信息id
#define URL_PARAM_GRADE                                 @"grade"           //参数:分数

//信令 参数
#define URL_PARAM_BIZ_ID                                @"bizId"            //参数 : 频道id  通话全局唯一
#define URL_PARAM_BIZ_CODE                              @"bizCode"          //参数 : 操作code

//合约 参数
#define URL_PARAM_BASE64                                @"fileBase64"       //参数: base64
#define URL_PARAM_UPLOAD_ITEM                           @"uploadItem"       //参数: 图片类型

//省市区 信息参数
#define URL_PARAM_PROVINCE_CODE                         @"provinceCode"     //参数 :省 编码
#define URL_PARAM_CITY_CODE                             @"cityCode"         //参数 :市 编码
#define URL_PARAM_REGION                                @"region"           //参数 :省市区 编码code

//人脸开门
#define URL_PARAM_IMAGE_URL_PATH                        @"imageUrlPath"     //参数 :图片路径

//隐私协议
#define URL_PARAM_PRIVICY_VERSION                       @"privacyVersion"   //参数 :隐私协议版本

//人机验证--投篮验证
#define URL_PARAM_SESSIONID                             @"sessionId"       //参数 :sessionId
#define URL_PARAM_PHONENUM                              @"phoneNum"        //参数 :手机号
#define URL_PARAM_EQUIPMENTFLAG                         @"equipmentFlag"   //参数 :iOS为1，Android为2

//忘记密码流程新参数
#define URL_PARAM_PASSWORD_BYFORGET                     @"password"         //参数 :密码
#define URL_PARAM_VERIFICATIONCODE_BYFORGET             @"verificationCode" //参数 :验证码

//字典更换请求参数
#define URL_PARAM_GETDICDATA_NAME                       @"name"         //参数：参数名字
//获取访客登记码
#define URL_PARAM_INVITECODE_PHONENUM                   @"phoneNun"     //参数：手机号
//启用token版本进行网络请求
#define URL_PARAM_VERSION                               @"version"     //参数：token版本为2 默认不传该字段为session版本

//2019年11月05全平台安全功能相关参数
#define URL_PARAM_NEW_LOGINNUMBER                       @"loginNumber" //参数：注册-登录手机号
#define URL_PARAM_NEW_PHONEVERIFYCODE                   @"phoneVerifyCode" //参数：注册-验证码
#define URL_PARAM_NEW_OLDPASSWORD                       @"oldPassword" //参数：修改密码-旧密码
#define URL_PARAM_NEW_NEWPASSWORD                       @"newPassword" //参数：修改密码-新密码
#define URL_PARAM_NEW_VERIFYCODE                        @"verifyCode" //参数：校验-图片验证码


typedef enum {
    DevelopmentEnrivonmentEnumTest      = 0,            //测试环境
    DevelopmentEnrivonmentEnumProduct   = 1             //生产环境
}DevelopmentEnrivonmentEnum;

@interface UrlUtils : NSObject<NSURLSessionDataDelegate>

/*
 * 服务器地址
 */
@property (nonatomic)NSString *address;

/**
 * 服务器端口
 */
@property (nonatomic)NSString *port;

/**
 * 服务器Servlet url pattern
 */
@property (nonatomic)NSString *urlPattern;

/**
 * 与服务器交互的操作标识
 */
@property (nonatomic)NSString *handle;

/**
 * 与服务器交互的参数集合
 */
@property (nonatomic)NSMutableDictionary *paramDict;

/**
 *  设置服务器地址，端口
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 */
+ (void)setServerAddress:(NSString *)address andPort:(NSString *)port;

/**
 * 获得对象实例
 *
 *  @param pattern 服务器Servlet url pattern
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithUrlPattern:(NSString *)pattern;

/**
 * 获得对象实例
 *
 *  @param handle 与服务器交互的操作标识
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithHandle:(NSString *)handle;

/**
 *  初始化对象
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 *  @param urlPattern 服务器Servlet url pattern
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithAddressAndUrlPattern:(NSString *)address port:(NSString *)port urlPattern:(NSString *)urlPattern;
/**
 *  初始化对象
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 *  @param urlPattern 服务器Servlet url pattern
 *  @param handle 与服务器交互的操作标识
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithAddressAndHandle:(NSString *)address port:(NSString *)port urlPattern:(NSString *)urlPattern handle:(NSString *)handle;

/**
 *  添加参数
 *
 *  @param param 参数名称
 *  @param value 参数值
 */
- (void)addParam:(NSString *)param value:(NSString *)value;

/**
 *  获得服务器地址
 *
 *  @result NSURL
 */
- (NSString *)getHost;

/**
 *  获得NSURL对象
 *
 *  @result NSURL
 */
- (NSURL *)getUrl;

/*
 * 重新构造登录url
 */
- (NSURL *)getNewLoginUrl:(NSMutableDictionary *)dic;

/**
 *  连接任务，并上传文件(带回调)
 *
 *  @param filePath 上传的文件路径
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadFileTaskByCompletionHandler:(NSString *)filePath completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  连接任务(自动登录)，并上传数据(带回调)
 *
 *  @param updateData 上传的字符串
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadDataTaskByCompletionHandlerAndLogin:(id)uploadObj completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  上传数据，连接任务(带回调)
 *
 *  @param uploadData 上传的字符串
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadDataTaskByCompletionHandler:(id)uploadObj completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  连接任务(带回调)
 *
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getDataTaskByCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 * 2019-11-25 修改注册忘记密码修改密码接口
 *  连接任务(带回调)
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getNewDataTaskByCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  会员登陆(带回调)
 *
 *  @block 回调
 *  @result NSURLSessionDataTask
 * 2019-11-21 添加NSData *data,
 */
- (NSURLSessionDataTask *)getUserLoginTask:(void (^)(bool okFLag, ResidentLoginVo *user, NSData *data, NSString *errorMsg, NSInteger code))loginHandler;


//+ (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;
///**
// *  会员注册(带回调)
// *
// *  @block 回调
// */
//- (NSURLSessionDataTask *)getResidentLoginTask:(void (^)(bool okFLag, ResidentLogin *user, NSString *errorMsg))loginHandler;

/**
 *  自动会员登录（带回调）但前提是必须已经执行过登录
 *
 *  @block 回调
 */
//- (void)autoUserLoginTask:(void (^)(bool okFLag, Userlogin *user, NSString *errorMsg))loginHandler;

/**
 *  执行自动会员登录（带回调）但前提是必须已经执行过登录
 *
 *  @block 回调
 */
-  (NSURLSessionDataTask *)autoUserLoginTask:(void (^)(bool okFLag, NSData *data, NSURLResponse *response, NSError *error))loginHandler;

/*
 * 获取Aeskey
 */
- (NSURLSessionDataTask *)getAesKey:(void (^)(bool okFLag, NSData *data, NSURLResponse *response, NSError *error))loginHandler;

/**
 * 获取当前服务器地址
 */
+ (NSString *)getCurrentServerAddress;

/**
 * 获取当前服务器端口
 */
+ (NSString *)getCurrentServerPort;

@end
