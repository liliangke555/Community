//
//  PrivacyViewModel.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "PrivacyViewModel.h"
#import "PrivacyModel.h"

#import  <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>

@implementation PrivacyViewModel

- (void)requestWithCallback:(callback)callBack
{
    NSMutableArray *arr = [NSMutableArray array];
    PrivacyModel *m1 = [[PrivacyModel alloc] initWithTitle:@"电话" details:@"提供音视频通话服务" imae:@""];
    [arr addObject:m1];
//    if (IOS9) {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authStatus == CNAuthorizationStatusNotDetermined) {
            PrivacyModel *m2 = [[PrivacyModel alloc] initWithTitle:@"通讯录" details:@"提供访客邀请、电话白名单、门禁离线等服务" imae:@""];
            [arr addObject:m2];
        }
//    }
    PrivacyModel *m3 = [[PrivacyModel alloc] initWithTitle:@"短信" details:@"提供访客邀请、门禁离线密码分享服务" imae:@""];
    [arr addObject:m3];
    
    if([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus locationStatus =  [CLLocationManager authorizationStatus];
        if (locationStatus == kCLAuthorizationStatusNotDetermined) {
            PrivacyModel *m4 = [[PrivacyModel alloc] initWithTitle:@"地理位置" details:@"提供访客邀请、门禁离线密码分享服务" imae:@""];
            [arr addObject:m4];
        }
    }
    PHAuthorizationStatus photoStatus =  [PHPhotoLibrary authorizationStatus];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (photoStatus == PHAuthorizationStatusNotDetermined || status == AVAuthorizationStatusNotDetermined) {
        PrivacyModel *m5 = [[PrivacyModel alloc] initWithTitle:@"相机和相册" details:@"提供音视频通话、邻里圈拍照、家庭等服务" imae:@""];
        [arr addObject:m5];
    }
    {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (status == AVAuthorizationStatusNotDetermined) {
            PrivacyModel *m6 = [[PrivacyModel alloc] initWithTitle:@"麦克风" details:@"提供音视频通话服务" imae:@""];
            [arr addObject:m6];
        }
    }
    PrivacyModel *m7 = [[PrivacyModel alloc] initWithTitle:@"存储空间" details:@"提供邻里圈发布消息、评论等服务" imae:@""];
    [arr addObject:m7];
    
    if (callBack) {
        callBack(arr);
    }
}

@end
