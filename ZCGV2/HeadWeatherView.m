//
//  HeadWeatherView.m
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "HeadWeatherView.h"

@interface HeadWeatherView ()
/**
 *  今天的天气
 */
@property (strong, nonatomic)  UILabel *labelWeather;
/**
 *  今天的最高温度
 */
@property (strong, nonatomic)  UILabel *labelTemperature;
/**
 *  今天星期几
 */
@property (strong, nonatomic)  UILabel *labelToday;
/**
 *  今天的气温
 */
@property (strong, nonatomic)  UILabel *labeltemp;

@end
@implementation HeadWeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor orangeColor];
//		地点
		UILabel *labelPlace = [[UILabel alloc] initWithFrame:CGRectMake(140, 40, 40, 20)];
		labelPlace.text = @"淅川";
		labelPlace.backgroundColor = [UIColor clearColor];
		[self addSubview:labelPlace];
//天气
		self.labelWeather = [[UILabel alloc] initWithFrame:CGRectMake(130, 55, 60, 30)];
		self.labelWeather.textAlignment = NSTextAlignmentCenter;
		self.labelWeather.font = [UIFont systemFontOfSize:12];
		self.labelWeather.text = self.strWeather;
		self.labelWeather.backgroundColor = [UIColor clearColor];
		[self addSubview:self.labelWeather];
//温度
		self.labelTemperature = [[UILabel alloc] initWithFrame:CGRectMake(108, 90, 104, 82)];
		self.labelTemperature.textAlignment = NSTextAlignmentCenter;
		self.labelTemperature.font = [UIFont systemFontOfSize:20];
		self.labelTemperature.text = self.strTemperature;
		self.labelTemperature.backgroundColor = [UIColor clearColor];
		[self addSubview:self.labelTemperature];
//星期几
		self.labelToday = [[UILabel alloc] initWithFrame:CGRectMake(45, 194, 51, 21)];
		self.labelToday.backgroundColor = [UIColor clearColor];
		self.labelToday.text = self.strToday;//一个bug

		[self addSubview:self.labelToday];
//温差
		self.labeltemp = [[UILabel alloc] initWithFrame:CGRectMake(238, 194, 102, 21)];
		self.labeltemp.backgroundColor = [UIColor clearColor];
		self.labeltemp.text = self.strTemp;
		[self addSubview:self.labeltemp];

    }
    return self;
}


- (void)setStrWeather:(NSString *)strWeather
{
	if (![strWeather isEqualToString:_strWeather]) {
		_strWeather = strWeather;
		self.labelWeather.text = _strWeather;
	}
}

- (void)setStrTemperature:(NSString *)strTemperature
{
	if (![strTemperature isEqualToString:_strTemperature]) {
		_strTemperature = strTemperature;
		self.labelTemperature.text = _strTemperature;
	}
}

- (void)setStrToday:(NSString *)strToday
{
	if (![strToday isEqualToString:_strToday]) {
		_strToday = strToday;
		self.labelToday.text = _strToday;
	}
}

- (void)setStrTemp:(NSString *)strTemp
{
	if (![strTemp isEqualToString:_strTemp]) {
		_strTemp = strTemp;
		self.labeltemp.text = _strTemp;
	}
}
@end
