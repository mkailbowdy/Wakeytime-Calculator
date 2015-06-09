//
//  MQMSuggestedTimes.h
//  Wakey.Wakey! Bedtime Suggestions
//
//  Created by Myhkail Mendoza on 2/11/15.
//  Copyright (c) 2015 Myhkail Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MQMSuggestedTimes : NSObject

@property (nonatomic, readonly, copy) NSArray *stringsArray;
@property (nonatomic, strong) NSDate *userChoice;

@end
