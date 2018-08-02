//
//  ItemCoreDataService+Fetching.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService.h"

@interface ItemCoreDataService (Fetching)

- (NSArray *)fetchItems;
- (void)fetchItemsToDictionaryByPredicate:(NSPredicate *)predicate withCompletionBlock:(void(^)(NSMutableDictionary *items))completionBlock;
- (Item *)fetchItemByKey:(NSString *)key withValue:(NSString *)value;


@end
