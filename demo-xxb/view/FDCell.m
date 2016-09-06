//
//  FDCell.m
//  demo-xxb
//
//  Created by xxb on 16/9/5.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "FDCell.h"
#import "Masonry.h"

@implementation FDCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setViews{
    _label1 = [[UILabel alloc] init];
    _label1.numberOfLines = 0;
    _label2 = [[UILabel alloc] init];
    _label2.numberOfLines = 0;
    _label2.lineBreakMode = NSLineBreakByWordWrapping;
    _label3 = [[UILabel alloc] init];
    _image = [[UIImageView alloc] init];
    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:_label1];
    [self.contentView addSubview:_label2];
    [self.contentView addSubview:_label3];
    [self.contentView addSubview:_image];
    [self.contentView addSubview:_view];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_label1.mas_bottom).offset(0);
        make.right.equalTo(self.contentView);
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_label2.mas_bottom).offset(0);
        make.right.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView).offset(0);
    }];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_label3.mas_bottom).offset(0);
        make.width.equalTo(@32);
        make.height.equalTo(_image.mas_width);
//        make.bottom.equalTo(self.contentView).offset(0);
    }];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_image.mas_bottom).offset(0);
//        make.width.equalTo(@32);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

- (CGSize)sizeThatFits:(CGSize)size {
//    size = CGSizeMake(20, 70);
    CGFloat totalHeight = 0;
    totalHeight += [self.label1 sizeThatFits:size].height;
    totalHeight += [self.label2 sizeThatFits:size].height;
    totalHeight += [self.label3 sizeThatFits:size].height;
    totalHeight += [self.image sizeThatFits:size].height;
    totalHeight += [self.view sizeThatFits:size].height;
//    totalHeight += 40; // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
