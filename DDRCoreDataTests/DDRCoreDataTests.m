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
    NSArray *items = [DDRPerson allInstancesInManagedObjectContext:moc];
    XCTAssertEqual([items count], 1, @"[items count] is not 1");
}

- (void)insertPersonObjects
{
    NSManagedObjectContext *moc = _doc.mainQueueObjectContext;
    DDRPerson *p = [DDRPerson newInstanceInManagedObjectContext:moc];
    p.firstName = @"Dave";
    p.lastName = @"Reed";

}

@end