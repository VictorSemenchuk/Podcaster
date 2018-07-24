//
//  ViewController.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParserService.h"
#import "Constants.h"
#import "SourceType.h"
#import "Item.h"

@interface FeedViewController : UIViewController

@property (nonatomic) NSArray *entitiesMP3Items;
@property (nonatomic) NSArray *entitiesTEDItems;
@property (nonatomic) XMLParserService *xmlParserServiceMP3;
@property (nonatomic) XMLParserService *xmlParserServiceTED;
@property (nonatomic) NSArray *tags;

@property (nonatomic) UICollectionView *collectionView;

@end
