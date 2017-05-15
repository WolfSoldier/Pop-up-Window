//
//  KMPopView.h
//  MakerMap
//
//  Created by kevin on 16/3/26.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PopViewBlock)(NSInteger index);
@interface KMPopView : UIView



- (instancetype)initSuperWithBlock:(PopViewBlock)block;

- (void)resetTitle:(NSString *)title text:(NSString *)text sureBtn:(NSString *)suerStr cancel:(NSString *)cancelStr canTapCancel:(BOOL)canTap;

+ (KMPopView *)popWithTitle:(NSString *)title text:(NSString *)text sureBtn:(NSString *)suerStr cancel:(NSString *)cancelStr block:(void(^)(NSInteger index))block canTapCancel:(BOOL)canTap;

- (void)show;
@end
