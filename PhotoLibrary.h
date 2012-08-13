#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoLibrary : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *photos;

#pragma mark - Load photos
-(void)loadPhotos;

@end