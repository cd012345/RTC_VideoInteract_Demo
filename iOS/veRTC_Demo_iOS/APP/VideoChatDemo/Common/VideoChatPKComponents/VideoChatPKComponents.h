//
//  VideoChatPKComponents.h
//  veRTC_Demo
//
//  Created by bytedance on 2022/3/14.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoChatPKComponents : NSObject

@property (nonatomic, strong) VideoChatUserModel *hostModel;
@property (nonatomic, strong) VideoChatUserModel *_Nullable anchorModel;
@property (nonatomic, assign) BOOL activeEndPK;

- (instancetype)initWithSuperView:(UIView *)superView roomModel:(VideoChatRoomModel *)roomModel;

- (void)changeChatRoomMode:(VideoChatRoomMode)mode;
- (void)updateRenderView:(NSString *)userID;
- (void)updateNetworkQuality:(VideoChatNetworkQualityStatus)status uid:(NSString *)uid;
- (void)updateUserModel:(VideoChatUserModel *)userModel;

- (void)muteOtherAnchorRoomID:(NSString *)roomID otherAnchorUserID:(NSString *)otherAnchorUserID type:(VideoChatOtherAnchorMicType)type;

- (void)reqeustStopForwardStream;
- (void)rtcStopForwardStream;


@end

NS_ASSUME_NONNULL_END
