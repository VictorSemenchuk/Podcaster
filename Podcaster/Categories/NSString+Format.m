//
//  NSString+Format.m
//  Podcaster
//
//  Created by Victor Macintosh on 31/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (NSString *)stringWithFormat:(NSString *)stringFormat fromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:stringFormat];
    return [dateFormatter stringFromDate:date];
}

@end
