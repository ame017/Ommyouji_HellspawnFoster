//
//  AMERightArrowCell.h
//  AMEelemeDEMO
//
//  Created by Apple on 16/7/3.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMETools.h"

@interface AMERightArrowCell : UITableViewCell

@property (nonatomic,retain)NSIndexPath * indexPath;

@property (nonatomic,retain) AMELabel * titleLabel;
@property (nonatomic,retain) UIImageView * titleImage;
@property (nonatomic,retain) AMELabel * descLabel;
@property (nonatomic,retain) UIImageView * rightArrow;
@property (nonatomic,retain) UIView * topLine;

//- (void)updateFrame;
@end
