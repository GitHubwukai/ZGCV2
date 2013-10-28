//
//  RightController.m
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

//需要在headerweather中添加一个状态圈
#import "RightController.h"
#import "JSON.h"
#import "WeatherCell.h"
#import "HeadWeatherView.h"

static  NSString *weatherUrl = @"http://m.weather.com.cn/data/101180708.html";

@interface RightController () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@end

@implementation RightController
{
	/**
	 *  保存获取的天气数据
	 */
	NSString *_outString;
//	解析用到的key
	/**
	 *  温度
	 */
	NSString *strKeyTemp;
	/**
	 *  天气
	 */
	NSString *strKeyWeather;

//	保存解析后的天气信息
	/**
	 *  保存天气信息
	 */
	NSMutableArray *marrayWeather;
	/**
	 *  保存气温信息
	 */
	NSMutableArray *marrayTemp;
	/**
	 *  保存星期
	 */
	NSMutableArray *weekArray;
	/**
	 *  今天是这个星期的第几天
	 */
	NSInteger num;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.title = @"淅川天气";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	//	请求天气数据
	[self getWeatherData];
	self.view.backgroundColor = [UIColor orangeColor];
	//添加下拉更新
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
	refresh.tintColor = [UIColor darkGrayColor];
	refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];
	[refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refresh;

	num = [self GetRecord];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	_outString = nil;
	marrayTemp = nil;
	marrayWeather = nil;
	strKeyTemp = nil;
	strKeyWeather = nil;

}

#pragma mark getWeatherData
/**
 *  获取天气数据
 */
- (void)getWeatherData
{
	NSURL *url = [NSURL URLWithString:weatherUrl];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
}

//接收返回的数据 
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	_outString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//获取失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"networl error");
}

//数据获取完成，解析数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

	//对解析结果进行保存  天气、温度
	marrayWeather = [[NSMutableArray alloc] initWithCapacity:6];
	marrayTemp = [[NSMutableArray alloc] initWithCapacity:6];
	//解析json保存到字典中
	NSMutableDictionary *dicJson = [_outString JSONValue];
	NSMutableDictionary *dicJsonSub = [dicJson objectForKey:@"weatherinfo"];

	strKeyTemp = @"temp";
	strKeyWeather = @"weather";
	for (int i = 1; i <= 6; i++) {
		NSString *str = [NSString stringWithFormat:@"%d", i];

		NSString *strTempName = [strKeyTemp stringByAppendingString:str];
		NSString *strWeatherName = [strKeyWeather stringByAppendingString:str];

		[marrayWeather addObject:[[NSString alloc] initWithFormat:@"%@", [dicJsonSub objectForKey:strWeatherName]]];
		[marrayTemp addObject:[[NSString alloc] initWithFormat:@"%@", [dicJsonSub objectForKey:strTempName]]];
	}
	NSLog(@"%@", marrayWeather);
	NSLog(@"%@", marrayTemp);
	//tableview数据重新加载一边
	[self.tableView reloadData];
}

#pragma mark - refreshView
//刷新状态
- (void)refreshView:(UIRefreshControl *)refresh
{
	if (refresh.refreshing) {
		refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing date..."];
		[self performSelector:@selector(handleData) withObject:nil afterDelay:2];
	}
}

//刷新数据源
- (void)handleData
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d h:mm:ss a"];
	NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated] ;

	//设置数据源
//	先把数据清空一下
	[self getWeatherData];
//停止刷新
	[self.refreshControl endRefreshing];
//	重新加载数据
	[self.tableView reloadData];
}
//获取第一天的天气

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [marrayWeather count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeatherCell";
	static BOOL nibRegistered = NO;
	if (!nibRegistered) {
	[tableView registerNib:[UINib nibWithNibName:@"WeatherCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
		nibRegistered = YES;
	}

    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
	cell.strWeather = marrayWeather[indexPath.row+1];
	cell.strTemperature = marrayTemp[indexPath.row+1];

	cell.strDay = [weekArray objectAtIndex:(indexPath.row+num+1)%7];
	cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 214;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	HeadWeatherView *headView = [[HeadWeatherView alloc] initWithFrame:CGRectMake(0, 0, 320, 214)];
	headView.strWeather = marrayWeather[section];
	headView.strTemperature = marrayTemp[section];
	headView.strTemp = marrayTemp[section];

	headView.strToday = [weekArray objectAtIndex:num];
	return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}
/**
 *  计算今天星期几
 *
 *  @return 返回今天星期几
 */
- (NSInteger )GetRecord
{
	weekArray = [[NSMutableArray alloc]initWithCapacity:7];
    [weekArray addObject:@"星期日"];
    [weekArray addObject:@"星期一"];
    [weekArray addObject:@"星期二"];
    [weekArray addObject:@"星期三"];
    [weekArray addObject:@"星期四"];
    [weekArray addObject:@"星期五"];
    [weekArray addObject:@"星期六"];
    //创建日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	//获取当前时间
	NSDate *now;

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
	NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
	//获取时间
	//   NSInteger year = [comps year];
	//   NSInteger month = [comps month];
	//   NSInteger day = [comps day];
    NSInteger week = [comps weekday]-1;
	//   NSInteger hour = [comps hour];
	//   NSInteger min = [comps minute];
	return week;


}

@end
