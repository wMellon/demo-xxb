//
//  SDCell.m
//  demo-xxb
//
//  Created by xxb on 16/9/20.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import "SDCell.h"
#import "SDAutoLayout.h"

@interface SDCell()

@end


@implementation SDCell

@synthesize imageView = _imageView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor orangeColor];
        _label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_label];
        
        _imageView = [[UIImageView alloc] init];
        
        
//        _label1 = [[UILabel alloc] init];
//        _label1.backgroundColor = [UIColor orangeColor];
//        [self.contentView addSubview:_label1];
        
//        _imageView.sd_layout
//        .leftSpaceToView(self.contentView, 15)
    
        _label.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10)
        .heightIs(_label.font.lineHeight);
        [_label setSingleLineAutoResizeWithMaxWidth:100];
//        [_label setMaxNumberOfLinesToShow:1];
//        [_label setSd_maxWidth:@(100)];
        
        
//        _label.text = @"搭嘎的发放围观玩儿啊喂饭";
        
        
//        _label1.sd_layout
//        .leftSpaceToView(self.contentView, 10)
//        .topSpaceToView(_label, 10)
//        .widthIs(300)
//        .heightIs(30);
        [self setupAutoHeightWithBottomView:_label bottomMargin:0];
    }
    return self;
}

-(void)setModel:(id)model{
    _label.text = @"搭嘎的发放围观玩儿啊喂饭";
//    _label1.text = @"多发俄方还是防患未然他人的 v 中";
//    [_label updateLayout];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
