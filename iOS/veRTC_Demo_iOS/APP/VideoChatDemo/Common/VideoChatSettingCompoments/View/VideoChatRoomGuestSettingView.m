//
//  VideoChatRoomSettingView.m
//  veRTC_Demo
//
//  Created by bytedance on 2021/10/24.
//  Copyright © 2021 . All rights reserved.
//

#import "VideoChatRoomGuestSettingView.h"
#import "VideoChatRoomSettingResolutionView.h"
#import "VideoChatSettingItemButton.h"

@interface VideoChatRoomGuestSettingView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) VideoChatRoomSettingResolutionView *resolutionView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation VideoChatRoomGuestSettingView

- (void)dealloc {
    NSLog(@"%@,%s", [NSThread currentThread], __func__);
}

- (instancetype)initWithHost:(BOOL)isHost {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorFromRGBHexString:@"#0E0825" andAlpha:0.95 * 255];

        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(0);
        }];

        NSArray *items = @[
                            @[ @"镜头翻转",
                               @"videoChat_setting_switch_camera",
                               @"" ],
                            @[ @"麦克风",
                               @"videoChat_setting_audio_enable",
                               @"videoChat_setting_audio_disable" ],
                            @[ @"摄像头",
                               @"videoChat_setting_video_enable",
                               @"videoChat_setting_video_disable" ] ];
        
        if (isHost) {
            items = @[
                    @[@"音乐",
                      @"videochat_setting_music",
                      @""],
                    @[ @"镜头翻转",
                       @"videoChat_setting_switch_camera",
                       @"" ],
                    @[ @"麦克风",
                       @"videoChat_setting_audio_enable",
                       @"videoChat_setting_audio_disable" ],
                    @[ @"摄像头",
                       @"videoChat_setting_video_enable",
                       @"videoChat_setting_video_disable" ]
            ];
        }

        for (int i = 0; i < items.count; i++) {
            NSString *title = items[i][0];
            NSString *imageNameNormal = items[i][1];
            NSString *imageNameSelected = items[i][2];

            VideoChatSettingItemButton *button = [[VideoChatSettingItemButton alloc] init];
            button.title = title;
            button.imageName = imageNameNormal;
            button.imageNameSelected = imageNameSelected;
            button.tag = i;

            [button addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:button];
            [self.buttons addObject:button];
        }
        CGFloat itemWidth = SCREEN_WIDTH / items.count;
        [self.buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:itemWidth leadSpacing:0 tailSpacing:0];
        [self.buttons mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.height.mas_equalTo(68);
        }];

        [self addSubview:self.resolutionView];
        [self.resolutionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(1);
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
    }
    return self;
}

- (void)itemButtonClicked:(VideoChatSettingItemButton *)sender {
    sender.selected = !sender.selected;

    if ([sender.title isEqualToString:@"音乐"]) {
        if ([self.delegate respondsToSelector:@selector(videoChatRoomGuestSettingViewDidClickMusic:)]) {
            [self.delegate videoChatRoomGuestSettingViewDidClickMusic:self];
        }
    }
    else if ([sender.title isEqualToString:@"镜头翻转"]) {
        if ([self.delegate respondsToSelector:@selector(videoChatRoomGuestSettingView:didSwitchCamera:)]) {
            [self.delegate videoChatRoomGuestSettingView:self didSwitchCamera:!sender.selected];
        }
    } else if ([sender.title isEqualToString:@"麦克风"]) {
        if ([self.delegate respondsToSelector:@selector(videoChatRoomGuestSettingView:didChangeMicState:)]) {
            [self.delegate videoChatRoomGuestSettingView:self didChangeMicState:sender.selected];
        }
    } else if ([sender.title isEqualToString:@"摄像头"]) {
        if ([self.delegate respondsToSelector:@selector(videoChatRoomGuestSettingView:didChangeCameraState:)]) {
            [self.delegate videoChatRoomGuestSettingView:self didChangeCameraState:sender.selected];
        }
    } else {
        // error
    }
}

- (void)setIsMicOn:(BOOL)isMicOn {
    _isMicOn = isMicOn;
    for (VideoChatSettingItemButton *button in self.buttons) {
        if ([button.title isEqualToString:@"麦克风"]) {
            button.selected = !isMicOn;
            break;
        }
    }
}

- (void)setIsCameraOn:(BOOL)isCameraOn {
    _isCameraOn = isCameraOn;
    for (VideoChatSettingItemButton *button in self.buttons) {
        if ([button.title isEqualToString:@"摄像头"]) {
            button.selected = !isCameraOn;
            break;
        }
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"设置";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorFromHexString:@"#E5E6EB"];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
    }
    return _backButton;
}

- (VideoChatRoomSettingResolutionView *)resolutionView {
    if (!_resolutionView) {
        _resolutionView = [[VideoChatRoomSettingResolutionView alloc] init];
        _resolutionView.hidden = YES;
    }
    return _resolutionView;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorFromRGBHexString:@"#2A2441"];
    }
    return _lineView;
}

@end
