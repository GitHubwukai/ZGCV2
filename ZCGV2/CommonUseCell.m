//
//  CommonUseCell.m
//  ZCGV2
//
//  Created by wukai on 13-10-29.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "CommonUseCell.h"

@implementation CommonUseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImgOwn:(UIImage *)imgOwn
{
	if (![imgOwn isEqual:_imgOwn]) {
		_imgOwn = [imgOwn copy];
		self.imageView.image = _imgOwn;
	}else
		self.imageView.image = _imgOwn;
}

- (void)setStrName:(NSString *)strName
{
	if (![strName isEqualToString:_strName]) {
		_strName = [strName copy];
		self.labelName.text = _strName;
	}else
		self.labelName.text = _strName;
}

- (void)setStrIntro:(NSString *)strIntro
{
	if (![strIntro isEqualToString:_strIntro]) {
		_strIntro = [strIntro copy];
		self.labelIntro.text = _strIntro;
	}else
		self.labelIntro.text = _strIntro;
}

@end
