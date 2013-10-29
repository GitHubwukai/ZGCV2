//
//  CommonUseCell.h
//  ZCGV2
//
//  Created by wukai on 13-10-29.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonUseCell : UITableViewCell
/**
 *  显示缩略图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageOwn;
/**
 *  显示名字
 */
@property (weak, nonatomic) IBOutlet UILabel *labelName;
/**
 *  显示介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *labelIntro;

@property (nonatomic, copy) UIImage *imgOwn;
@property (nonatomic, copy) NSString *strName;
@property (nonatomic, copy) NSString *strIntro;

@end
