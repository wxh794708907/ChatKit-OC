//
//  UITableViewCell+LCCKCellIdentifier.m
//  LCCKChatBarExample
//
//  Created by ElonChan ( https://github.com/leancloud/ChatKit-OC ) on 15/11/23.
//  v0.5.0 Copyright © 2015年 https://LeanCloud.cn . All rights reserved.
//

#import "LCCKCellIdentifierFactory.h"
#import "LCCKMessage.h"
#import "NSObject+LCCKExtension.h"
#import <AVOSCloudIM/AVIMConversation.h>
#import "AVIMTypedMessage+LCCKExtension.h"
#import "LCCKConstants.h"

@implementation LCCKCellIdentifierFactory

+ (NSString *)cellIdentifierForMessageConfiguration:(id)message conversationType:(LCCKConversationType)conversationType {
    NSString *groupKey;
    switch (conversationType) {
        case LCCKConversationTypeGroup:
            groupKey = LCCKCellIdentifierGroup;
            break;
        case LCCKConversationTypeSingle:
            groupKey = LCCKCellIdentifierSingle;
            break;
        default:
            groupKey = @"";
            break;
    }
    
    if ([message lcck_isCustomMessage]) {
        return [self cellIdentifierForCustomMessageConfiguration:(AVIMTypedMessage *)message groupKey:groupKey];
    }
    return [self cellIdentifierForDefaultMessageConfiguration:(LCCKMessage *)message groupKey:groupKey];
}

+ (NSString *)cellIdentifierForDefaultMessageConfiguration:(LCCKMessage *)message groupKey:(NSString *)groupKey {
    AVIMMessageMediaType messageType = message.mediaType;
    
    LCCKMessageOwnerType messageOwner = message.ownerType;
    
    NSNumber *key = [NSNumber numberWithInt:messageType];
    if ([message lcck_isCustomLCCKMessage]) {
        key = [NSNumber numberWithInt:kAVIMMessageMediaTypeText];
    }
    Class aClass = [LCCKChatMessageCellMediaTypeDict objectForKey:key];
    NSString *typeKey = NSStringFromClass(aClass);
    NSString *ownerKey;
    switch (messageOwner) {
        case LCCKMessageOwnerTypeSystem:
            ownerKey = LCCKCellIdentifierOwnerSystem;
            break;
        case LCCKMessageOwnerTypeOther:
            ownerKey = LCCKCellIdentifierOwnerOther;
            break;
        case LCCKMessageOwnerTypeSelf:
            ownerKey = LCCKCellIdentifierOwnerSelf;
            groupKey = LCCKCellIdentifierSingle;
            break;
        default:
            NSAssert(NO, @"Message Owner Unknow");
            break;
    }
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_%@_%@", typeKey, ownerKey, groupKey];
    return cellIdentifier;
}

+ (NSString *)cellIdentifierForCustomMessageConfiguration:(AVIMTypedMessage *)message groupKey:(NSString *)groupKey {
    AVIMMessageMediaType messageType;
    if ([message lcck_isSupportThisCustomMessage]) {
       messageType = message.mediaType;
    } else {
        messageType = kAVIMMessageMediaTypeText;
    }
    AVIMMessageIOType messageOwner = message.ioType;
    NSString *typeKey = NSStringFromClass([LCCKChatMessageCellMediaTypeDict objectForKey:@(message.mediaType)]);
   
    NSString *ownerKey;
    switch (messageOwner) {
        case AVIMMessageIOTypeOut:
            ownerKey = LCCKCellIdentifierOwnerSelf;
            groupKey = LCCKCellIdentifierSingle;
            break;
        case AVIMMessageIOTypeIn:
            ownerKey = LCCKCellIdentifierOwnerOther;
            break;
        default:
            NSAssert(NO, @"Message Owner Unknow");
            break;
    }
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_%@_%@", typeKey, ownerKey, groupKey];
    return cellIdentifier;
}

@end
