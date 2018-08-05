//
//  DataManager.h
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Item.h"
#import "Constants.h"
#import "DownloadManager.h"
#import "FileManager.h"
#import "FileManager+Creating.h"
#import "EntitiesConstants.h"
#import "XMLParserService.h"
#import "ItemCoreDataService.h"

@protocol DataManagerDelegate <NSObject>

- (void)dataWasFetched:(NSArray *)items;

@end

@protocol DataManagerSavingDelegate <NSObject>

- (void)wasFinishedBackgroundDownloadingForItem:(Item *)item;
- (void)updatedProgressFor:(float)progess;

@end

@interface DataManager : NSObject

@property (nonatomic) Item *item;
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) XMLParserService *xmlParserServiceMP3;
@property (nonatomic) XMLParserService *xmlParserServiceTED;
@property (nonatomic) ItemCoreDataService *itemCoreDataService;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSArray *entitiesMP3Items;
@property (nonatomic) NSArray *entitiesTEDItems;
@property (nonatomic) NSMutableDictionary *entitiesCoreDataItems;
@property (weak, nonatomic) id<DataManagerDelegate> delegate;
@property (nonatomic) id<DataManagerSavingDelegate> savingDelegate;

- (void)processItems;

@end
