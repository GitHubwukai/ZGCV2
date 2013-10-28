//
//  WeatherCell.m
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

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

 -(void)setStrDay:(NSString *)strDay
{
	if (![strDay isEqualToString:_strDay]) {
		_strDay = [strDay copy];
		self.LabelDay.text = _strDay;
	}
}

- (void)setStrWeather:(NSString *)strWeather
{
	if (![strWeather isEqualToString:_strWeather]) {
		_strWeather = [strWeather copy];
		self.LabelWethaer.text = _strWeather;
	}
}

- (void)setStrTemperature:(NSString *)strTemperature
{
	if (![strTemperature isEqualToString:_strTemperature]) {
		_strTemperature = [strTemperature copy];
		self.LabelTemperature.text = _strTemperature;
	}
}
@end
