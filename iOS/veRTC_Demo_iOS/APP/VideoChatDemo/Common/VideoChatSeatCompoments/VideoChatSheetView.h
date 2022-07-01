//
//  VideoChatSheetView.h
//  veRTC_Demo
//
//  Created by bytedance on 2021/12/1.
//  Copyright © 2021 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoChatSeatItemButton.h"
@class VideoChatSheetView;

NS_ASSUME_NONNULL_BEGIN

@protocol VideoChatSheetViewDelegate <NSObject>

- (void)VideoChatSheetView:(VideoChatSheetView *)VideoChatSheetView
               clickButton:(VideoChatSheetStatus)sheetState;

@end

@interface VideoChatSheetView : UIView

@property (nonatomic, weak) id <VideoChatSheetViewDelegate> delegate;

- (void)showWithSeatModel:(VideoChatSeatModel *)seatModel
           loginUserModel:(VideoChatUserModel *)loginUserModel;

- (void)dismiss;

@property (nonatomic, strong, readonly) VideoChatSeatModel *seatModel;

@property (nonatomic, strong, readonly) VideoChatUserModel *loginUserModel;

@end

NS_ASSUME_NONNULL_END
