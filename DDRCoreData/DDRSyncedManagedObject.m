//
//  DDRSyncedManagedObject.m
//  DDRCoreData
//
//  Created by David M Reed on 4/7/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

#import "DDRSyncedManagedObject.h"

@implementation DDRSyncedManagedObject

@dynamic ddrSyncIdentifier;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    if (![self valueForKey:@"ddrSyncIdentifier"]) {
        [self setValue:[[NSUUID UUID] UUIDString] forKey:@"ddrSyncIdentifier"];
    }
}

@end
