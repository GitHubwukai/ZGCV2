//
//  WeatherCell.h
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell
/**
 *  今天星期几
 */
@property (weak, nonatomic) IBOutlet UILabel *LabelDay;
/**
 *  今天的天气
 */
@property (weak, nonatomic) IBOutlet UILabel *LabelWethaer;
/**
 *   今天的最高气温
 */
@property (weak, nonatomic) IBOutlet UILabel *LabelTemperature;

@property (copy, nonatomic) NSString *strDay;
@property (copy, nonatomic) NSString *strWeather;
@property (copy, nonatomic) NSString *strTemperature;

@end
