#import "PhotoLibrary.h"
#import "Photo.h"

@implementation PhotoLibrary

#pragma mark - Load photos
- (void)loadPhotos {
//    TODO: Load photos from photo library
    _photos = [NSMutableArray array];
    
    ALAssetsLibrary *photoLibrary= [[ALAssetsLibrary alloc] init];
    [photoLibrary enumerateGroupsWithTypes:ALAssetsGroupLibrary usingBlock:^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                Photo *photo = [[Photo alloc] initPhotoWithName:result.defaultRepresentation.filename
                                                        andDate:[result.defaultRepresentation valueForKey:ALAssetPropertyDate]];
                [_photos addObject:photo];
            }];
        }
    } failureBlock:^(NSError *error) {
        dbgLog(@"Denied access to photos");
    }];
}

@end
