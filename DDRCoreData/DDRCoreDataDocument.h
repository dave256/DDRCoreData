//
//  DDRCoreDataDocument.h
//  DDRCoreData
//
//  Created by David M Reed on 3/29/14.
//  Copyright (c) 2014 David M Reed. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DDRCoreDataDocument : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *mainQueueObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// will be nil for NSInMemoryStoreType
@property (readonly, strong, nonatomic) NSURL *storeURL;

- (instancetype)initWithStoreURL:(NSURL*)theURL modelName:(NSString*)modelName options:(NSDictionary*)options;

- (void)saveContext:(BOOL)wait;

- (NSManagedObjectContext*)newChildOfMainQueueObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType;

@end
