#import "PhotoLibrary.h"
#import "Photo.h"

@implementation PhotoLibrary

#pragma mark - Load photos
- (void)loadPhotos {
    _photos = [NSMutableArray array];
    
    ALAssetsLibrary *photoLibrary= [[ALAssetsLibrary alloc] init];
    [photoLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {                
                    dbgLog(@"Photo: %@",result);
                    
                    NSString *filename = result.defaultRepresentation.filename;
                    NSDate *date = [result valueForProperty:ALAssetPropertyDate];
                    UIImage *thumbnail = [UIImage imageWithCGImage:result.thumbnail];
                    
                    Photo *photo = [[Photo alloc] initPhotoWithName:filename andDate:date];
                    photo.thumbnail = thumbnail;
                    [_photos addObject:photo];
                }
            }];
        } else {
            [_delegate photoLibraryDidLoadPhotos:_photos];
        }
    } failureBlock:^(NSError *error) {
        dbgLog(@"Denied access to photos");
    }];
}

@end
