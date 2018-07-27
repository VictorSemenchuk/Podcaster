//
//  TEDCollectionViewCell.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "TEDCollectionViewCell.h"
#import "FileManager.h"

@implementation TEDCollectionViewCell

#pragma mark - Methods

- (void)setupViews {
    [super setupViews];
    self.imageView.image = [UIImage imageNamed:kTEDItemImagePlaceholder];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.widthAnchor constraintEqualToConstant:kTEDImagePlaceholderWidth]]];
}

- (void)setValueForItem:(Item *)item {
    [super setValueForItem:item];
    FileManager *fileManager = [FileManager sharedFileManager];
    if (![item.image.localUrl isEqualToString:@""]) {
        self.imageView.image = [fileManager getImageFromPath:item.image.localUrl];
    } else {
        DownloadManager *downloadManager = [[DownloadManager alloc] init];
        [downloadManager downloadFileForURL:[item.image.webUrl stringByAppendingString:@"w=300"] withCompletionBlock:^(NSData *data) {
            NSString *filename = [fileManager getFilenameFromStringURL:item.image.webUrl];
            NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, filename];
            [fileManager createFileWithData:data atPath:filePath];
            item.image.localUrl = filePath;
            self.imageView.image = [fileManager getImageFromPath:[NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, filename]];
        }];
    }
}

- (void)prepareForReuse {
    self.imageView.image = [UIImage imageNamed:kTEDItemImagePlaceholder];
}

@end
