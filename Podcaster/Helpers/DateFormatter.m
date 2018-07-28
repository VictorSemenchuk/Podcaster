//
//  DateFormatter.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

#pragma mark - Init

+ (instancetype)sharedDateFormatter {
    static DateFormatter *sharedDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatter = [[self alloc] init];
    });
    return sharedDateFormatter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

#pragma mark - Methods

+ (NSDate *)getDateFromString:(NSString *)string byFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [DateFormatter sharedDateFormatter].dateFormatter;
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}

+ (NSString *)getStringFromDate:(NSDate *)date byFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [DateFormatter sharedDateFormatter].dateFormatter;
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

@end
