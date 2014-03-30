//
//  DDRCoreDataTests.m
//  DDRCoreDataTests
//
//  Created by David M Reed on 3/29/14.
//  Copyright (c) 2014 David M Reed. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DDRCoreDataDocument.h"
#import "DDRManagedObject.h"
#import "DDRPerson.h"

@interface DDRCoreDataTests : XCTestCase

@end

@implementation DDRCoreDataTests
{
    NSURL *_storeURL;
    DDRCoreDataDocument *_doc;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _storeURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"test.sqlite"]];
    _doc = [[DDRCoreDataDocument alloc] initWithStoreURL:_storeURL modelName:@"DDRCoreDataTests" options:nil];
    [self insertPersonObjects];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [[NSFileManager defaultManager] removeItemAtURL:_storeURL error:nil];
}

/*
- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}
*/

- (void)testInsertionOfPersonObjects
{
    NSManagedObjectContext *moc = _doc.mainQueueObjectContext;
    NSArray *sorters = @[[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@", @"firstName", @"Dave"];

    NSArray *items = [DDRPerson allInstancesWithPredicate:predicate andSortDescriptors:sorters inManagedObjectContext:moc];
    XCTAssertEqual([items count], 2, @"[items count] is not 2");

    DDRPerson *p = [items firstObject];
    XCTAssertEqual(@"Dave", p.firstName, @"first name is not Dave");
    XCTAssertEqual(@"Reed", p.lastName, @"last name is not Reed");

    p = [items objectAtIndex:1];
    XCTAssertEqual(@"Dave", p.firstName, @"first name is not Dave");
    XCTAssertEqual(@"Smith", p.lastName, @"last name is not Smith");

    items = [DDRPerson allInstancesWithPredicate:nil andSortDescriptors:sorters inManagedObjectContext:moc];
    XCTAssertEqual([items count], 3, @"[items count] is not 3");

    p = [items lastObject];
    XCTAssertEqual(@"John", p.firstName, @"first name is not John");
    XCTAssertEqual(@"Stroeh", p.lastName, @"last name is not Stroeh");
}

- (void)insertPersonObjects
{
    NSManagedObjectContext *moc = _doc.mainQueueObjectContext;
    DDRPerson *p = [DDRPerson newInstanceInManagedObjectContext:moc];
    p.firstName = @"Dave";
    p.lastName = @"Reed";

    p = [DDRPerson newInstanceInManagedObjectContext:moc];
    p.firstName = @"Dave";
    p.lastName = @"Smith";

    p = [DDRPerson newInstanceInManagedObjectContext:moc];
    p.firstName = @"John";
    p.lastName = @"Stroeh";

    NSError *error;
    [moc save:&error];
    XCTAssert(error == nil, @"save error: %@\n%@", [error localizedDescription], [error userInfo]);


}

@end
