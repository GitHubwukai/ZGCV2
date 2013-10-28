//
//  ZGCAppDelegate.h
//  ZCGV2
//
//  Created by wukai on 13-10-28.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
//对DDMenuController引用
@class DDMenuController;
@interface ZGCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@end
