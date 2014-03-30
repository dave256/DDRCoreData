//
//  DDRManagedObject.m
//  DDRCoreData
//
//  Created by David M Reed on 3/29/14.
//  Copyright (c) 2014 David M Reed. All rights reserved.
//

#import "DDRManagedObject.h"

@implementation DDRManagedObject

+ (NSString*)entityName
{
    // subclasses can override, but provide a reasonable default
    return NSStringFromClass(self);
}

+ (instancetype)newInstanceInManagedObjectContext:(NSManagedObjectContext*)context
{
    id object = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
    return object;
}

+ (NSFetchRequest*)fetchRequest
{
    return [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
}

+ (NSArray*)allInstancesWithPredicate:(NSPredicate*)predicate inManagedObjectContext:(NSManagedObjectContext*)context
{
    NSFetchRequest* request = [self fetchRequest];
    request.predicate = predicate;
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:request error:&error];
    if (results == nil) {
        NSLog(@"ERROR loading %@: %@", predicate, error);
    }
    return results;
}

+ (NSArray*)allInstancesWithPredicate:(NSPredicate*)predicate andSortDescriptors:(NSArray*)sortDescriptors inManagedObjectContext:(NSManagedObjectContext*)context
{
    NSFetchRequest* request = [self fetchRequest];
    request.predicate = predicate;
    request.sortDescriptors = sortDescriptors;
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:request error:&error];
    if (results == nil) {
        NSLog(@"ERROR loading %@: %@", predicate, error);
    }
    return results;
}

+ (NSArray*)allInstancesInManagedObjectContext:(NSManagedObjectContext*)context
{
    NSArray* results = [self allInstancesWithPredicate:nil inManagedObjectContext:context];
    return results;
}

@end
