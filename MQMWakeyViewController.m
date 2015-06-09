//
//  MQMWakeyViewController.m
//  Wakey.Wakey! Bedtime Suggestions
//
//  Created by Myhkail Mendoza on 2/4/15.
//  Copyright (c) 2015 Myhkail Mendoza. All rights reserved.
//

#import "MQMWakeyViewController.h"
#import "MQMAboutViewController.h"
#import "MQMSuggestedTimes.h"
#import <iAd/iAd.h>

@interface MQMWakeyViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *userTime;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UILabel *okayLabel;
@property (weak, nonatomic) IBOutlet UILabel *worstLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseTimeLabel;
@property (nonatomic)MQMSuggestedTimes *st;
@property (nonatomic) NSArray *labelsArray;


@end

@implementation MQMWakeyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        /*
        // Register for bigger fonts
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(updateFonts)
                              name:UIContentSizeCategoryDidChangeNotification
                            object:nil];
         */
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Custom UIButton for Info
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *infoButton = [UIImage imageNamed:@"initial_state-50.png"];
    // scaling set to 2.0 makes the image half the size
    UIImage *scaledInfoButton = [UIImage imageWithCGImage:[infoButton CGImage]
                                               scale:(infoButton.scale * 1.5)
                                         orientation:(infoButton.imageOrientation)];
    [button setImage:scaledInfoButton
            forState:UIControlStateNormal];
    [button addTarget:self action:@selector(aboutInfo:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 53, 31)]; // Must set the frame for the button
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    // End custom UIButton
    
    // Set the title for the navigationItem
    self.navigationItem.title = @"Wakey Wakey!";
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"avenir" size:21],
      NSFontAttributeName, nil]];
    
    // Set the default time to 8:00am
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *defaultTime = [[NSDateComponents alloc] init];
    [defaultTime setHour:8];
    [defaultTime setMinute:00];
    self.userTime.date = [calendar dateFromComponents:defaultTime];

    // Add labels to labelsArray
    self.labelsArray = @[self.bestLabel, self.goodLabel, self.okayLabel, self.worstLabel];
    // Set the UILabel text to blank so they are invisible
    for (int i = 0; i < 4; i++) {
        [self.labelsArray[i] setText:@""];
    }
    
    // Ad ads
    self.canDisplayBannerAds = YES;
    
    // Here we handle different screen sizes
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            if([UIScreen mainScreen].bounds.size.height == 667){
                // iPhone retina-4.7 inch(iPhone 6)
                //self.footerLabel.text = @"Note: It takes an average of 15 minutes to fall asleep!";
                // set the font size
                self.chooseTimeLabel.font = [self.chooseTimeLabel.font fontWithSize:28];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568){
                // iPhone retina-4 inch(iPhone 5 or 5s)
                // set the font size
                self.chooseTimeLabel.font = [self.chooseTimeLabel.font fontWithSize:23];
            }
            else{
                // iPhone retina-3.5 inch(iPhone 4s)
                // set the font size
                self.chooseTimeLabel.font = [self.chooseTimeLabel.font fontWithSize:21];
            }
        }
        else if ([[UIScreen mainScreen] scale] == 3.0)
        {
            //if you want to detect the iPhone 6+ only
            if([UIScreen mainScreen].bounds.size.height == 736.0){
                //iPhone retina-5.5 inch screen(iPhone 6 plus)
            }
            //iPhone retina-5.5 inch screen(iPhone 6 plus)
            self.chooseTimeLabel.font = [self.chooseTimeLabel.font fontWithSize:35];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self updateFonts];
}

- (IBAction)calculate:(id)sender
{
    // Create a suggestedTimes object
    self.st = [[MQMSuggestedTimes alloc] init];
    
    // Set the userChoice date to w/e the timepicker is on.
    self.st.userChoice = self.userTime.date;
    
    // setting the date in MQMSuggestedTimes will call the setUserChoice:(NSDate *)date method
    // Check the MQMSuggestedTimes implementation file to see what happens.
    
    // Set the text of the UILabels
    for (int i = 0; i < 4; i++) {
        [self.labelsArray[i] setText:self.st.stringsArray[0]];
    }
    
    float duration = 0.5;
    for (int i = 0; i < 4; i++) {
        // Set the text of the strings
        [self.labelsArray[i] setText:self.st.stringsArray[i]];
        
        // Set the Labels Animation
        [self.labelsArray[i] setAlpha:0.0];
        
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.labelsArray[i] setAlpha:1.0];
                         }
                         completion:NULL];
        if (i < 3) {
            duration = duration + 0.3;
        } else {
            duration = duration + 0.2;
        }
        // End Animation
    }
    
    // MOTION EFFECTS INTERPOLATING
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[ UIInterpolatingMotionEffect alloc] initWithKeyPath:@" center.x"
                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @-25; motionEffect.maximumRelativeValue = @25;
    
    for (int i = 0; i < 4; i++) {
        [self.labelsArray[i] addMotionEffect:motionEffect];
    }
    
    motionEffect = [[ UIInterpolatingMotionEffect alloc] initWithKeyPath:@" center.y"
                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @-25; motionEffect.maximumRelativeValue = @25;
    for (int i = 0; i < 4; i++) {
        [self.labelsArray[i] addMotionEffect:motionEffect];
    }
    
    // Here we handle different screen sizes
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            if([UIScreen mainScreen].bounds.size.height == 667){
                // iPhone retina-4.7 inch(iPhone 6)
                //self.footerLabel.text = @"Note: It takes an average of 15 minutes to fall asleep!";
                // set the font size
                self.bestLabel.font = [self.bestLabel.font fontWithSize:30];
                self.goodLabel.font = [self.goodLabel.font fontWithSize:29];
                self.okayLabel.font = [self.okayLabel.font fontWithSize:28];
                self.worstLabel.font = [self.worstLabel.font fontWithSize:27];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568){
                // iPhone retina-4 inch(iPhone 5 or 5s)
                // set the font size
                self.bestLabel.font = [self.bestLabel.font fontWithSize:25];
                self.goodLabel.font = [self.goodLabel.font fontWithSize:24];
                self.okayLabel.font = [self.okayLabel.font fontWithSize:23];
                self.worstLabel.font = [self.worstLabel.font fontWithSize:22];
            }
            else{
                // iPhone retina-3.5 inch(iPhone 4s)
                // set the font size
                self.bestLabel.font = [self.bestLabel.font fontWithSize:16];
                self.goodLabel.font = [self.goodLabel.font fontWithSize:16];
                self.okayLabel.font = [self.okayLabel.font fontWithSize:16];
                self.worstLabel.font = [self.worstLabel.font fontWithSize:16];
            }
        }
        else if ([[UIScreen mainScreen] scale] == 3.0)
        {
            //if you want to detect the iPhone 6+ only
            if([UIScreen mainScreen].bounds.size.height == 736.0){
                //iPhone retina-5.5 inch screen(iPhone 6 plus)
            }
            //iPhone retina-5.5 inch screen(iPhone 6 plus)
            self.bestLabel.font = [self.bestLabel.font fontWithSize:40];
            self.goodLabel.font = [self.goodLabel.font fontWithSize:39];
            self.okayLabel.font = [self.okayLabel.font fontWithSize:38];
            self.worstLabel.font = [self.worstLabel.font fontWithSize:37];
        }
    }
}

- (void)aboutInfo:(id)sender
{
    MQMAboutViewController *avc = [[MQMAboutViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}

/*- (void)updateFonts
{
    UIFont *headline = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    self.bestLabel.font = headline;
    self.goodLabel.font = headline;
    self.okayLabel.font = headline;
    self.worstLabel.font = headline;
    self.chooseTimeLabel.font = headline;
}*/



@end
