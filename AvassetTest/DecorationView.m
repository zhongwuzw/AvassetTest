//
//  DecorationView.m
//  AvassetTest
//
//  Created by zhongwu on 14-9-24.
//  Copyright (c) 2014年 boloomo. All rights reserved.
//

#import "DecorationView.h"

@implementation DecorationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
