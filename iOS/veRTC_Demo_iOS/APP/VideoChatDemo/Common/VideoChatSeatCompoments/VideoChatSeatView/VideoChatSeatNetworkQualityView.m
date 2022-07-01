//
//  VideoChatSeatNetworkQualityView.m
//  veRTC_Demo
//
//  Created by bytedance on 2021/12/24.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "VideoChatSeatNetworkQualityView.h"

@interface VideoChatSeatNetworkQualityView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation VideoChatSeatNetworkQualityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.mas_equalTo(0);
            make.centerY.equalTo(self);
        }];

        [self addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(4);
            make.centerY.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [self updateNetworkQualityStstus:VideoChatNetworkQualityStatusGood];
    }
    return self;
}

- (void)updateNetworkQualityStstus:(VideoChatNetworkQualityStatus)status {
    switch (status) {
        case VideoChatNetworkQualityStatusGood:
        case VideoChatNetworkQualityStatusNone:
            self.messageLabel.text = @"网络良好";
            self.iconImageView.image = [UIImage imageNamed:@"videochat_net_good" bundleName:HomeBundleName];
            break;
        case VideoChatNetworkQualityStatusBad:
            self.messageLabel.text = @"网络卡顿";
            self.iconImageView.image = [UIImage imageNamed:@"videochat_net_bad" bundleName:HomeBundleName];
            break;
            
        default:
            break;
    }
}

#pragma mark - getter

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
    ;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    }
    return _messageLabel;
}

@end
