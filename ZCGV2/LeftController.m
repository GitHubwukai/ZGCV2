//
//  LeftController.m
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "LeftController.h"
#import "FeedController.h"
#import "DDMenuController.h"
#import "CommonViewController.h"

@interface LeftController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftController
{
	/**
	 *  菜单中section的标题
	 */
	NSArray *_arrayMenuSections;
	/**
	 *  保存菜单的信息
	 */
	NSDictionary * _dicMenus;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		NSArray *arrayUsefulInfo = @[@"门票",@"交通",@"住宿",@"攻略",@"附近景点"];
		NSArray *arrayuser = @[@"关于我们", @"评论",@"更新"];
		NSArray *arrayPlace = @[@"坐禅谷"];
		_arrayMenuSections = @[@"美景欣赏",@"实用信息", @"用户"];

		_dicMenus = @{_arrayMenuSections[0]:arrayPlace,
					  _arrayMenuSections[1]:arrayUsefulInfo,
					  _arrayMenuSections[2]:arrayuser};

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//默认选中第一行
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	if ([self isViewLoaded] && self.view.window==nil) {
		self.tableView = nil;
		self.view = nil;
		NSLog(@"left release");
	}
}
#pragma mark TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _arrayMenuSections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[_dicMenus objectForKey:_arrayMenuSections[section]] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	NSArray *temparray = [_dicMenus objectForKey:_arrayMenuSections[indexPath.section]];
	NSString *string = [NSString stringWithString:temparray[indexPath.row]];
	cell.textLabel.text = string;
//	cell.textLabel.textColor = [UIColor whiteColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//	cell.backgroundColor = [UIColor darkGrayColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DDMenuController *menuController = (DDMenuController *)((ZGCAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
	if ((indexPath.section == 1) && (indexPath.row == 2)) {
		CommonViewController *controller = [[CommonViewController alloc] init];
		controller.title = [_dicMenus objectForKey:_arrayMenuSections[indexPath.section]][indexPath.row];
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
		[menuController setRootController:navController animated:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];

	}
	else{
		FeedController *controller = [[FeedController alloc] init];
		controller.title = [_dicMenus objectForKey:_arrayMenuSections[indexPath.section]][indexPath.row];
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
		[menuController setRootController:navController animated:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

#pragma mark - TableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 20)];
	view.backgroundColor = [UIColor darkGrayColor];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 270, 16)];
	label.backgroundColor = [UIColor clearColor];
	label.text = _arrayMenuSections[section];
	label.font = [UIFont systemFontOfSize:14];
	[view addSubview:label];
	return view;
}
@end
