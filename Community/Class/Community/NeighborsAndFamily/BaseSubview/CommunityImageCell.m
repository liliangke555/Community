//
//  CommunityImageCell.m
//  Community
//
//  Created by MAC on 2020/6/4.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunityImageCell.h"
#import <Photos/Photos.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YBImageBrowser/YBIBIconManager.h>

@interface CommunityImageCell ()

@property (strong, nonatomic) UIImageView * coverImgView;
@property (strong, nonatomic) UILabel * typeLabel;

@end

@implementation CommunityImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.layer setCornerRadius:5.0f];
    self.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (@available(iOS 13.0, *)) {
        [imageView setBackgroundColor:[UIColor systemGray4Color]];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:imageView];
    self.backImageView = imageView;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    UIImageView *coverImgView = [[UIImageView alloc] init];
    [self addSubview:coverImgView];
    self.coverImgView = coverImgView;
    if (@available(iOS 13.0, *)) {
        [coverImgView setImage:[UIImage systemImageNamed:@"play.circle"]];
        [coverImgView setTintColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
    }
    
    UILabel *typeLabel = [[UILabel alloc] init];
    [self addSubview:typeLabel];
    self.typeLabel = typeLabel;
    [typeLabel setFont:[UIFont systemFontOfSize:10]];
    [typeLabel setText:@"GIF"];
    [typeLabel.layer setCornerRadius:5];
    typeLabel.clipsToBounds = YES;
    [typeLabel setTextAlignment:NSTextAlignmentCenter];
    if (@available(iOS 13.0, *)) {
        [typeLabel setBackgroundColor:[UIColor systemGray3Color]];
        [typeLabel setTextColor:[UIColor labelColor]];
        
    } else {
        // Fallback on earlier versions
        [typeLabel setBackgroundColor:[UIColor grayColor]];
        [typeLabel setTextColor:[UIColor whiteColor]];
    }
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.coverImgView.frame = CGRectMake(CGRectGetMidX(self.bounds) - 20, CGRectGetMidY(self.bounds) - 20, 40, 40);
    self.typeLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 45, CGRectGetHeight(self.frame) - 20, 40, 20);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.backImageView.image = image;
}

- (void)setData:(id)data {
    _data = data;
    
    CGFloat padding = 4, imageViewLength = ([UIScreen mainScreen].bounds.size.width - padding * 2 - 32) / 3.0f, scale = [UIScreen mainScreen].scale;
    CGSize imageViewSize = CGSizeMake(imageViewLength * scale, imageViewLength * scale);
    
    if ([data isKindOfClass:PHAsset.class]) {
        
        PHAsset *phAsset = (PHAsset *)data;
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.synchronous = NO;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(250, 250) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info){
            BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (downloadFinined && result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.data == data) self.backImageView.image = result;
                });
            }
        }];
        
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            self.coverImgView.hidden = NO;
            self.typeLabel.hidden = YES;
            self.backImageView.image = [YBIBIconManager sharedManager].videoBigPlayImage();
        } else {
            self.coverImgView.hidden = YES;
            self.typeLabel.hidden = YES;
        }
        
    } else if ([data isKindOfClass:NSString.class]) {
        
        NSString *imageStr = (NSString *)data;
        __block BOOL isBigImage = NO, isLongImage = NO;
        
        if ([imageStr hasSuffix:@".mp4"]) {
            
            AVURLAsset *avAsset = nil;
            if ([imageStr hasPrefix:@"http"]) {
                avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:imageStr]];
            } else {
                NSString *path = [[NSBundle mainBundle] pathForResource:imageStr.stringByDeletingPathExtension ofType:imageStr.pathExtension];
                avAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
            }
            
            if (avAsset) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:avAsset];
                    generator.appliesPreferredTrackTransform = YES;
                    generator.maximumSize = imageViewSize;
                    NSError *error = nil;
                    CGImageRef cgImage = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
                    UIImage *resultImg = [UIImage imageWithCGImage:cgImage];
                    if (cgImage) CGImageRelease(cgImage);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.data == data) self.backImageView.image = resultImg;
                    });
                });
            }
            
        } else if ([imageStr hasPrefix:@"http"]) {
            UIImage *image = nil;
            if (@available(iOS 13.0, *)) {
                image = [UIImage systemImageNamed:@"wifi.exclamationmark"];
            } else {
                // Fallback on earlier versions
            }
            [self.backImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:image options:SDWebImageDecodeFirstFrameOnly];
            
        } else if (imageStr.pathExtension.length > 0) {
            
            NSString *type = imageStr.pathExtension;
            NSString *resource = imageStr.stringByDeletingPathExtension;
            NSString *filePath = [[NSBundle mainBundle] pathForResource:resource ofType:type];
            NSData *nsData = [NSData dataWithContentsOfFile:filePath];
            UIImage *image = [UIImage imageWithData:nsData];
            
            static CGFloat kMaxPixel = 4096.0;
            if (image.size.width * image.scale * image.size.height * image.scale > kMaxPixel * kMaxPixel) {
                isBigImage = YES;
            } else if (image.size.width * image.scale > kMaxPixel || image.size.height * image.scale > kMaxPixel) {
                isLongImage = YES;
            }
            
            if (isBigImage) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    CGSize size = CGSizeMake(imageViewSize.width, image.size.height / image.size.width * imageViewSize.width);
                    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
                    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
                    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.data == data) self.backImageView.image = scaledImage;
                    });
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.data == data) self.backImageView.image = image;
                });
            }
        } else {
//            self.textLabel.text = imageStr;
        }
        
        if ([imageStr hasSuffix:@".mp4"]) {
            self.coverImgView.hidden = NO;
            self.typeLabel.hidden = YES;
            self.backImageView.image = [YBIBIconManager sharedManager].videoBigPlayImage();
        } else if ([imageStr hasSuffix:@".gif"]) {
            self.coverImgView.hidden = YES;
            self.typeLabel.hidden = NO;
            self.typeLabel.text = @" GIF ";
        } else if (isBigImage) {
            self.coverImgView.hidden = YES;
            self.typeLabel.hidden = NO;
            self.typeLabel.text = @" 高清图 ";
        } else if (isLongImage) {
            self.coverImgView.hidden = YES;
            self.typeLabel.hidden = NO;
            self.typeLabel.text = @" 长图 ";
        } else {
            self.coverImgView.hidden = YES;
            self.typeLabel.hidden = YES;
        }
    }
}
@end
