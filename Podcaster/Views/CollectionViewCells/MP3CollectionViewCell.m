//
//  MP3CollectionViewCell.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MP3CollectionViewCell.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"
#import "FileManager.h"

@implementation MP3CollectionViewCell

#pragma mark - Methods

- (void)setupViews {
    [super setupViews];
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.widthAnchor constraintEqualToConstant:kMP3ImagePlaceholderWidth]]];
}

- (void)setValueForItem:(Item *)item {
    [super setValueForItem:item];
    FileManager *fileManager = [FileManager sharedFileManager];
    if (![item.image.localUrl isEqualToString:@""]) {
        self.imageView.image = self.imageView.image = [fileManager getImageFromPath:item.image.localUrl];
    } else {
        DownloadManager *downloadManager = [[DownloadManager alloc] init];
        [downloadManager downloadFileForURL:item.image.webUrl withCompletionBlock:^(NSData *data) {
            NSString *filename = [fileManager getFilenameFromStringURL:item.image.webUrl];
            NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, filename];
            [fileManager createFileWithData:data atPath:filePath withCompressionFactor:0.1];
            item.image.localUrl = filePath;
            self.imageView.image = [fileManager getImageFromPath:[NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, filename]];
        }];
    }
}

- (void)prepareForReuse {
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
}

@end
