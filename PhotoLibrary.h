#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoLibraryDelegate <NSObject>
-(void)photoLibraryDidLoadPhotos:(NSArray *)photos;
@end

@interface PhotoLibrary : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *photos;

@property (nonatomic, weak) id <PhotoLibraryDelegate> delegate;

#pragma mark - Load photos
-(void)loadPhotos;

@end