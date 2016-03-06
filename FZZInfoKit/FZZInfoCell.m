//
//  InfoCell.m
//  CommonParts
//
//  Created by Administrator on 2014/10/12.
//  Copyright (c) 2014年 Shota Nakagami. All rights reserved.
//

#import "FZZInfoCell.h"
#import "Chameleon.h"

@implementation FZZInfoCell

- (void)awakeFromNib {    
    self.rightLabel.font = [UIFont systemFontOfSize:15.0];
    self.leftLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.rightLabel.textColor = FlatWhite;
    self.leftLabel.textColor = FlatWhite;
    self.backgroundColor = FlatBlack;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted){
        self.backgroundColor = FlatBlackDark;
    }else{
        self.backgroundColor = FlatBlack;
    }
}

@end
