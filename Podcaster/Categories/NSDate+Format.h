//
//  NSDate+Format.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/1/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

+ (NSDate *)dateWithFormat:(NSString *)stringFormat fromString:(NSString *)string;

@end
