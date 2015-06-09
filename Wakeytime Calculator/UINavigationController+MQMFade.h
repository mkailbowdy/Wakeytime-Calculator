//
//  UINavigationController+MQMFade.h
//  LoL Cooldowns
//
//  Created by Myhkail Mendoza on 5/3/15.
//  Copyright (c) 2015 Myhkail Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MQMFade)

- (void)pushFadeViewController:(UIViewController *)viewController;
- (void)fadePopViewController;

@end
