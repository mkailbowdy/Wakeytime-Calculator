//
//  MQMSuggestedTimes.m
//  Wakey.Wakey! Bedtime Suggestions
//
//  Created by Myhkail Mendoza on 2/11/15.
//  Copyright (c) 2015 Myhkail Mendoza. All rights reserved.
//

#import "MQMSuggestedTimes.h"
#import "MQMWakeyViewController.h"

@interface MQMSuggestedTimes ()
@property (nonatomic) NSMutableArray *datesArray;
@property (nonatomic, copy) NSArray *datesComponentsArray;
@property (nonatomic) NSMutableArray *privateStrings;
@end

@implementation MQMSuggestedTimes

- (instancetype)init
{
    self = [super init];
    if (self) {
        _privateStrings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)stringsArray
{
    return [self.privateStrings copy];
}

- (void)setUserChoice:(NSDate *)date
{
    // NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    // Get the date the user chose, then get the components of that date (Hour, day, etc)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Make components for the suggested times
    NSDateComponents *bestTimeComponents = [[NSDateComponents alloc] init];
    [bestTimeComponents setHour:-9];
    [bestTimeComponents setMinute:00];
    
    NSDateComponents *goodTimeComponents = [[NSDateComponents alloc] init];
    [goodTimeComponents setHour:-7];
    [goodTimeComponents setMinute:-30];
    
    NSDateComponents *okayTimeComponents = [[NSDateComponents alloc] init];
    [okayTimeComponents setHour:-6];
    [okayTimeComponents setMinute:00];
    
    NSDateComponents *worstTimeComponents = [[NSDateComponents alloc] init];
    [worstTimeComponents setHour:-4];
    [worstTimeComponents setMinute:-30];
    
    // Add components to array
    self.datesComponentsArray = @[bestTimeComponents, goodTimeComponents, okayTimeComponents, worstTimeComponents];
    
    // We need to make four NSDates using the NSDate that the user entered.
    
    for (int i = 0; i < 4; i++) {
        NSDate *newDate = [calendar dateByAddingComponents:self.datesComponentsArray[i]
                                                    toDate:date
                                                   options:0];
        [self.datesArray addObject:newDate];
        
        NSString *stringOfTime = [dateFormatter stringFromDate:newDate];
        [self.privateStrings addObject:stringOfTime];
        
        // DEBUGGING: make sure the hour and minutes are correct
        NSLog(@"Best suggested time: %@", self.privateStrings[i]);
    }
}


@end
