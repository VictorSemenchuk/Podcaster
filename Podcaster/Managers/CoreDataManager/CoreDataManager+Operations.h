//
//  CoreDataManager+Operations.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager (Operations)

- (void)addNewInstanceForEntityWithName:(NSString *)entityName withAssigningBlock:(void (^)(NSManagedObject *currentEntity, NSManagedObjectContext *context))assigningBlock;
- (NSArray *)fetchEntitiesWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate;
- (void)updateEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate withUpdatingBlock:(void(^)(NSManagedObject *object))updatingBlock;
- (void)removeEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate;

@end
