//
//  DDRManagedObject.h
//  DDRCoreData
//
//  Created by David M Reed on 3/29/14.
//  Copyright (c) 2014 David M Reed. All rights reserved.
//

// based/copied from talk given by
// Paul Goracke of Black Pixel
// http://seattlexcoders.org/2014/02/11/core-data-best-practices.html
// http://vimeo.com/89370886

#import <CoreData/CoreData.h>

@interface DDRManagedObject : NSManagedObject

+ (NSString*)entityName;

+ (instancetype)newInstanceInManagedObjectContext:(NSManagedObjectContext*)context;

+ (NSFetchRequest*)fetchRequest;

+ (NSArray*)allInstancesWithPredicate:(NSPredicate*)predicate inManagedObjectContext:(NSManagedObjectContext*)context;

+ (NSArray*)allInstancesWithPredicate:(NSPredicate*)predicate andSortDescriptors:(NSArray*)sortDescriptors inManagedObjectContext:(NSManagedObjectContext*)context;

+ (NSArray*)allInstancesInManagedObjectContext:(NSManagedObjectContext*)context;


@end