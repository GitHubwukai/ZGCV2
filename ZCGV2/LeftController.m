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

@interface LeftController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftController
{
	NSArray *_arrayMenuTitles;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_arrayMenuTitles = @[@"Home",@"门票",@"交通",@"住宿",@"攻略",@"附近景点"];
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
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _arrayMenuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	cell.textLabel.text = _arrayMenuTitles[indexPath.row];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.backgroundColor = [UIColor darkGrayColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DDMenuController *menuController = (DDMenuController *)((ZGCAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
	FeedController *controller = [[FeedController alloc] init];
	controller.title = _arrayMenuTitles[indexPath.row];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
	[menuController setRootController:navController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}
@end
