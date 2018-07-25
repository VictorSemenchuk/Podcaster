//
//  DateFormatter.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

@property (nonatomic) NSDateFormatter *dateFormatter;

+ (instancetype)sharedDateFormatter;
+ (NSDate *)getDateFromString:(NSString *)string byFormat:(NSString *)format;

@end
