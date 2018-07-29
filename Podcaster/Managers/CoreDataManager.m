//
//  CoreDataManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "CoreDataManager.h"

static NSString * const kDatabaseFilename = @"ModelCoreData.sqlite";
static NSString * const kModelName = @"Model";

@interface CoreDataManager ()

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSPersistentStoreCoordinator *persistentCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataManager

#pragma mark - CoreData Stack Items

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *persistentCoordinator = self.persistentCoordinator;
        if (persistentCoordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _managedObjectContext.persistentStoreCoordinator = persistentCoordinator;
        }
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [NSBundle.mainBundle URLForResource:kModelName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentCoordinator {
    if (!_persistentCoordinator) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:kDatabaseFilename];
        NSLog(@"CoreData persistent store URL: %@", storeURL);
        
        NSError *error;
        _persistentCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        if (![_persistentCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        }
    }
    return _persistentCoordinator;
}

#pragma mark - Operations

- (void)addNewInstanceForEntityWithName:(NSString *)entityName withAssigningBlock:(void (^)(NSManagedObject *currentEntity, NSManagedObjectContext *context))assigningBlock {
    NSManagedObject *currentEntity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
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


