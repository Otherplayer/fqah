//
//  FQAHDiskCachedObject.m
//  
//
//  Created by __无邪_ on 15/11/21.
//
//

#import "FQAHDiskCachedObject.h"

@implementation FQAHDiskCachedObject

// Insert code here to add functionality to your managed object subclass
+ (instancetype)saveContent:(NSData *)content identifier:(NSString *)identifier{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key = %@",identifier];
    FQAHDiskCachedObject *cachedObject = [FQAHDiskCachedObject MR_findFirstWithPredicate:predicate];
    if (cachedObject == nil) {
        cachedObject = [FQAHDiskCachedObject MR_createEntity];
        cachedObject.key = identifier;
    }
    cachedObject.content = content;
    cachedObject.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
    //save
//    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];// should save on currentthread ???
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return cachedObject;
}

+ (instancetype)fetchCachedDataWithIdentifier:(NSString *)identifier{
    FQAHDiskCachedObject *cachedObject = [FQAHDiskCachedObject MR_findFirstByAttribute:@"key" withValue:identifier];
    return cachedObject;
}

+ (void)deleteCachedObjectWithIdentifier:(NSString *)identifier{
    FQAHDiskCachedObject *cachedObject = [FQAHDiskCachedObject MR_findFirstByAttribute:@"key" withValue:identifier];
    if (cachedObject) {
        BOOL isDeleted = [cachedObject MR_deleteEntity];
        NSLog(@"DELETE:[%d]",isDeleted);
    }
}

@end
