//
//  DDRCoreDataDocument.m
//  DDRCoreData
//
//  Created by David M Reed on 3/29/14.
//  Copyright (c) 2014 David M Reed. All rights reserved.
//

#import "DDRCoreDataDocument.h"

@implementation DDRCoreDataDocument
{
    NSManagedObjectContext *_privateMOC;
}

- (instancetype)initWithStoreURL:(NSURL*)theURL modelName:(NSString*)modelName options:(NSDictionary*)options
{
    self = [super init];

    if (self) {
        NSURL *modelURL = nil;
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        modelURL = [bundle URLForResource:modelName withExtension:@"momd"];
        ZAssert(modelURL, @"Failed to find model URL");
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        //_managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
        ZAssert(_managedObjectModel, @"Failed to initialize model");
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        ZAssert(_persistentStoreCoordinator, @"Failed to initialize persistent store coordinator");

        NSString *storeType = theURL == nil ? NSInMemoryStoreType : NSSQLiteStoreType;
        NSError *error;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:theURL options:options error:&error]) {
            ALog(@"Error adding persistent store to coordinator %@\n%@", [error localizedDescription], [error userInfo]);
        }
        else {
            _storeURL = theURL;
            _privateMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _privateMOC.persistentStoreCoordinator = _persistentStoreCoordinator;
            _mainQueueObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _mainQueueObjectContext.parentContext = _privateMOC;
        }
    }
    return self;
}

// code from Core Data, Second Edition by Marcus S. Zarra pp. 96-97
- (void)saveContext:(BOOL)wait
{
    // return if no MOC created yet
    if (!_mainQueueObjectContext) {
        return;
    }

    // if changes to save, save them up to the private queue
    if ([_mainQueueObjectContext hasChanges]) {
        [_mainQueueObjectContext performBlockAndWait:^{
            NSError *error;
            ZAssert([_mainQueueObjectContext save:&error], @"Error saving MOC: %@\n%@", [error localizedDescription], [error userInfo]);
        }];
    }

    // block to save the private queue to persistent store
    void (^savePrivate) (void) = ^{
        NSError *error = nil;
        ZAssert([_privateMOC save:&error], @"Error saving private moc: %@\n%@", [error localizedDescription], [error userInfo]);
    };

    // if changes need saved to persistent store
    if ([_privateMOC hasChanges]) {
        if (wait) {
            [_privateMOC performBlockAndWait:savePrivate];
        }
        else {
            [_privateMOC performBlock:savePrivate];
        }
    }
}

- (NSManagedObjectContext*)newChildOfMainQueueObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    moc.parentContext = _mainQueueObjectContext;
    return moc;
}

@end
