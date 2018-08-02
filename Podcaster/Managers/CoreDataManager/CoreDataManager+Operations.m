//
//  CoreDataManager+Operations.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "CoreDataManager+Operations.h"

@implementation CoreDataManager (Operations)

#pragma mark - Operations

- (void)addNewInstanceForEntityWithName:(NSString *)entityName withAssigningBlock:(void (^)(NSManagedObject *currentEntity, NSManagedObjectContext *context))assigningBlock {
    NSManagedObject *currentEntity;
    assigningBlock(currentEntity, self.managedObjectContext);
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSArray *)fetchEntitiesWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        [request setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        return results;
    } else {
        return nil;
    }
}

- (void)updateEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate withUpdatingBlock:(void (^)(NSManagedObject *))updatingBlock {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        [request setPredicate:predicate];
    }
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    if (results) {
        NSManagedObject *object = results.firstObject;
        updatingBlock(object);
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

- (void)removeEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        [request setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    if (results) {
        for(NSManagedObject *object in results) {
            [self.managedObjectContext deleteObject:object];
        }
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}


@end
