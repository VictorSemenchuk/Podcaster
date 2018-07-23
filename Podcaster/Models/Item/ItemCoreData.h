//
//  Item.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ItemCoreData : NSManagedObject

@property (assign, nonatomic) NSUInteger guid;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *details;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSString *pubDate;

@end
