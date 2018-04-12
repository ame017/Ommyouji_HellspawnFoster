//
//  AMECellInfo.m
//  comicDEMO
//
//  Created by syetc053 on 16/7/14.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMECellInfo.h"

@implementation AMECellInfo
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.subTitle = subTitle;
    }
    return self;
}
@end
