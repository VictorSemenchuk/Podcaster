//
//  NSString+Format.h
//  Podcaster
//
//  Created by Victor Macintosh on 31/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

+ (NSString *)stringWithFormat:(NSString *)stringFormat fromDate:(NSDate *)date;

@end
