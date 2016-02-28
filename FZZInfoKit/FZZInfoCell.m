//
//  InfoCell.m
//  CommonParts
//
//  Created by Administrator on 2014/10/12.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoCell.h"

@implementation FZZInfoCell

- (void)awakeFromNib {
    //[[self.iconImageView layer] setCornerRadius:self.iconImageView.frame.size.width*225/1024.0f];
    //self.iconImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
