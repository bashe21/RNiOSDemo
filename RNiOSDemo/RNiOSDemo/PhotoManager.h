//
//  PhotoManager.h
//  RNiOSDemo
//
//  Created by zyx on 2020/7/27.
//  Copyright © 2020 zyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImageCallBack)(NSArray *images);

@interface PhotoManager : NSObject

- (instancetype)initWithController:(ImageCallBack)imageCallBack;
- (void)checkAlbumPermission;
@end

NS_ASSUME_NONNULL_END
