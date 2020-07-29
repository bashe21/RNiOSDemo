//
//  PhotoMudule.m
//  RNiOSDemo
//
//  Created by zyx on 2020/7/27.
//  Copyright © 2020 zyx. All rights reserved.
//

#import "PhotoMudule.h"
#import "PhotoManager.h"

@interface PhotoMudule ()
@property (strong, nonatomic) PhotoManager *manager;
@end

@implementation PhotoMudule
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(openPhotoLibrary:(RCTResponseSenderBlock)imageCallBack) {
    dispatch_async(dispatch_get_main_queue(), ^{
        PhotoManager *manager = [[PhotoManager alloc] initWithController:^(NSArray * _Nonnull images) {
            imageCallBack(@[[NSNull null], images]);
        }];
        [manager checkAlbumPermission];
        self->_manager = manager;
    });
    
}

@end
