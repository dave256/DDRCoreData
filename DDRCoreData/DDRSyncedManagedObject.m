//
//  DDRSyncedManagedObject.m
//  DDRCoreData
//
//  Created by David M Reed on 4/7/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

#import "DDRSyncedManagedObject.h"

@implementation DDRSyncedManagedObject

- (void)awakeFromInsert
{
    [super awakeFromInsert];

    // documentation indicates awakeFromInsert can be called on both child amd parent context so make certain it's only set once
    if (![self valueForKey:@"ddrSyncIdentifier"]) {
        // set ddrSyncIdentifier to unique string when object inserted/instatntiated
        [self setValue:[[NSUUID UUID] UUIDString] forKey:@"ddrSyncIdentifier"];
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    // log message indicating need ddrSyncIdentifier
    if ([key isEqualToString:@"ddrSyncIdentifier"]) {
        NSLog(@"no ddrSyncIdentifier key for object of type: %@", [self class]);
    }
    else {
        // call super to raise exception for all other keys
        [super valueForUndefinedKey:key];
    }
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // log message indicating need ddrSyncIdentifier
    if ([key isEqualToString:@"ddrSyncIdentifier"]) {
        NSLog(@"no ddrSyncIdentifier key for object of type: %@", [self class]);
    }
    else {
        // call super to raise exception for all other keys
        [super setValue:value forUndefinedKey:key];
    }
}

@end
