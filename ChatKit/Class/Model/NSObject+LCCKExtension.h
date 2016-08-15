//
//  NSObject+LCCKExtension.h
//  Pods
//
//  Created by 陈宜龙 on 16/8/10.
//
//

#import <Foundation/Foundation.h>

typedef void (^LCCKShouldDisplayTimestampCallBack)(BOOL shouldDisplayTimestamp, NSTimeInterval messageTimestamp);

@interface NSObject (LCCKExtension)

/*!
 * 判断是否为自定义消息
 */
- (BOOL)lcck_isCustomMessage;
- (BOOL)lcck_isCustomLCCKMessage;

/*!
 * 当前消息的时间戳，以sendTime为准，可以区分自定义消息，和默认消息类型。
 */
- (NSTimeInterval)lcck_messageTimestamp;

/*!
 * 是否显示时间轴Label
 */
- (void)lcck_shouldDisplayTimestampForMessages:(NSArray *)messages callback:(LCCKShouldDisplayTimestampCallBack)callback;

@end
