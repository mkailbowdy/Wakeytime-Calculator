//
//  MQMAboutViewController.m
//  Wakey.Wakey! Bedtime Suggestions
//
//  Created by Myhkail Mendoza on 2/6/15.
//  Copyright (c) 2015 Myhkail Mendoza. All rights reserved.
//

#import "MQMAboutViewController.h"
#import <iAd/iAd.h>

@interface MQMAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation MQMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    [self adjustLabels];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Info";
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"avenir" size:21],
      NSFontAttributeName, nil]];
}

- (void)adjustLabels {
    // Now add the quote text to the labels. I need to add the strings from the dictionaries inside of the array
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label2.adjustsFontSizeToFitWidth = YES;
    self.label1.lineBreakMode = NSLineBreakByWordWrapping; // wrap to two lines
    self.label1.numberOfLines = 0;
    self.label2.lineBreakMode = NSLineBreakByWordWrapping; // wrap to two lines
    self.label2.numberOfLines = 0;
}


@end