//
//  LCCKVCardView.h
//  ChatKit-OC
//
//  Created by 陈宜龙 on 16/8/15.
//  v0.5.0 Copyright © 2016年 ElonChan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LCCKVCardDidClickedHandler)(NSString *clientId);
@interface LCCKVCardView : UIView

+ (id)vCardView;
- (void)configureWithAvatarURL:(NSURL *)avatarURL title:(NSString *)title clientId:(NSString *)clientId;
@property (nonatomic, copy) LCCKVCardDidClickedHandler vCardDidClickedHandler;
- (void)setVCardDidClickedHandler:(LCCKVCardDidClickedHandler)vCardDidClickedHandler;

@end
