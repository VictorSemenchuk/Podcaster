//
//  NSDate+Format.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/1/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "NSDate+Format.h"
#import "DateFormatter.h"

@implementation NSDate (Format)

+ (NSDate *)dateWithFormat:(NSString *)stringFormat fromString:(NSString *)string {
    return [DateFormatter getDateFromString:string byFormat:stringFormat];
}

@end
