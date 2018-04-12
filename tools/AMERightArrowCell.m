//
//  AMERightArrowCell.m
//  AMEelemeDEMO
//
//  Created by Apple on 16/7/3.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMERightArrowCell.h"


@implementation AMERightArrowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:0 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = VIEW_GRAY;
        [self.contentView addSubview:_topLine];
        
        _titleImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_titleImage];
        
        _titleLabel = [[AMELabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"ArialMT" size:18];
        [self.contentView addSubview:_titleLabel];
        
        _rightArrow = [[UIImageView alloc]init];
        _rightArrow.image = [UIImage imageNamed:@"table_more_12x21_"];
        [self.contentView addSubview:_rightArrow];
        
        _descLabel = [[AMELabel alloc]init];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.fillColor = [UIColor grayColor];
        _descLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_descLabel];
        
        //layOut
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(0);
        }];
        [_titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleImage.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(20);
        }];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_rightArrow.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

//- (void)setRightArrowHidden:(BOOL)rightArrowHidden{
//    _rightArrowHidden = rightArrowHidden;
//    if (rightArrowHidden == YES) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        _rightArrow.hidden = YES;
//    }else{
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
//        _rightArrow.hidden = NO;
//    }
//}
//
//- (void)updateFrame{
//    _titleLabel.frame = CGRectMake(0, 0, 200, 20);
//    [_titleLabel sizeAuto];
//    if (_titleImage.image) {
//        _titleLabel.frame = CGRectMake(40, 10, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
//        _topLine.frame = CGRectMake(40, 0, WIDTH-30, 1);
//    }else{
//        _titleLabel.frame = CGRectMake(15, 10, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
//        _topLine.frame = CGRectMake(15, 0, WIDTH-30, 1);
//    }
//    if (_descLabel.text&&![_descLabel.text isEqualToString:@""]) {
//        if (_rightArrow.hidden == YES) {
//            _descLabel.frame = CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+10, 12, WIDTH-15-40-_titleLabel.frame.size.width-20, 15);
//        }else if (_titleImage.image==nil){
//            _descLabel.frame = CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+10, 12, WIDTH-15-25-10-_titleLabel.frame.size.width, 15);
//        }else{
//            _descLabel.frame = CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+10, 12, WIDTH-15-25-40-_titleLabel.frame.size.width, 15);
//        }
//    }
//}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.row) {
        _topLine.hidden = NO;
    }else{
        _topLine.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.selected = NO;
//    });
}

@end
