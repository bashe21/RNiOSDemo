//
//  PhotoManager.m
//  RNiOSDemo
//
//  Created by zyx on 2020/7/27.
//  Copyright © 2020 zyx. All rights reserved.
//

#import "PhotoManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UtilTool.h"

@interface PhotoManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIViewController *currentController;
@property (strong, nonatomic) ImageCallBack imageCallBack;
@end

@implementation PhotoManager
#pragma mark - life cycle
- (instancetype)initWithController:(ImageCallBack)imageCallBack {
    if (self = [super init]) {
        NSLog(@"%@",[NSThread currentThread]);
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
        self.currentController = [UtilTool findCurrentViewController];
        self.imageCallBack = imageCallBack;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *imagedata = UIImagePNGRepresentation(image);
    NSString *base64Encode = [imagedata base64EncodedStringWithOptions:0];
    base64Encode = [NSString stringWithFormat:@"data:image/png;base64,%@",base64Encode];
    if (self.imageCallBack) {
        self.imageCallBack(@[base64Encode]);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Camera(检查相机权限方法)
- (void)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self takePhoto];
            }
        }];
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {

        [self alertAlbum];//如果没有权限给出提示
    } else {
        [self takePhoto];//有权限进入调起相机方法
    }
}

#pragma mark - 判断相机是否可用，如果可用调起
- (void)takePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.currentController presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    } else {//不可用只能GG了
        NSLog(@"木有相机");
    }
}

#pragma mark - Album(相册流程与相机流程相同,相册是不存在硬件问题的,只要有权限就可以直接调用)
- (void)checkAlbumPermission {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            NSLog(@"%@",[NSThread currentThread]);
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//            });
            if (status == PHAuthorizationStatusAuthorized) {
                [self selectAlbum];
            }
        }];
    } else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self selectAlbum];
    }
}

- (void)selectAlbum {
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
        NSLog(@"%@",[NSThread currentThread]);
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.currentController presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    }
}

- (void)alertAlbum {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.currentController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self.currentController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 本地图片保存
- (NSString *)getImageAddress {
    NSString *file = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [file stringByAppendingPathComponent:@"photoLibraryImage"];
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *imageName = [NSString stringWithFormat:@"%ld",(long)timeStamp];
    return [NSString stringWithFormat:@"%@/%@.png",filePath,imageName];
}

#pragma mark - getter
- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self; //delegate遵循了两个代理
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}



@end
