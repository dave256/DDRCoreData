//
//  DDRPerson.h
//  DDRCoreData
//
//  Created by David Reed on 3/30/14.
//  Copyright (c) 2014 David Reed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DDRManagedObject.h"

@interface DDRPerson : DDRManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
