//
//  FeedController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedController.h"

@implementation FeedController


- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	if ([self isViewLoaded] && self.view.window == nil) {
		self.view = nil;
		NSLog(@"feedView 释放");
	}
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}

@end
