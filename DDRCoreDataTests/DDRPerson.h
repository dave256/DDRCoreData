//
//  DDRPerson.h
//  DDRCoreData
//
//  Created by David Reed on 3/30/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DDRSyncedManagedObject.h"

@interface DDRPerson : DDRSyncedManagedObject

@property (nonatomic, copy) NSString * firstName;
@property (nonatomic, copy) NSString * lastName;

@end
