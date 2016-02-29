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
    self.rightLabel.font = [UIFont systemFontOfSize:16.0];
    self.leftLabel.font = [UIFont systemFontOfSize:16.0];
    
    self.rightLabel.textColor = [UIColor blackColor];
    self.leftLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
