//
//  OutputStreamTests.m
//  BinaryStream
//
//  Created by Víctor Berga on 24/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OutputStreamTests.h"

@implementation OutputStreamTests

- (void)setUp
{
    [super setUp];
    
    _testPath = @"/Users/vbergae/test.bin";
    _outputStream = [[OutputStream alloc] init];
    STAssertNotNil(_outputStream, @"Failed instantiatin OutputStream");
}

- (void)tearDown
{
    [_outputStream release];
    _outputStream = nil;
    
    [super tearDown];
}

#pragma mark - 
#pragma mark Properties Initialization

- (void)testSetPath
{    
    [_outputStream setPath:_testPath];
    STAssertTrue([_outputStream.path isEqualToString:_testPath], 
                 @"Path property broken");
}

- (void)testIsOpen
{
    STAssertFalse([_outputStream isOpen],
                  @"isOpen should be NO");
}

#pragma mark -
#pragma mark Method Tests

- (void)testOpenCloseStream
{
    [_outputStream setPath:_testPath];
    
    // Opening file
    STAssertNoThrow([_outputStream openStream], @"openStream fails");
    STAssertTrue([_outputStream isOpen], @"openStream fails");
    
    // Closing file
    STAssertNoThrow([_outputStream closeStream],  
                    @"Exception throw closing stream");
    STAssertFalse([_outputStream isOpen], @"Stream appears to be opened");
}

- (void)testWriteChar
{
    [_outputStream setPath:_testPath];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeChar:0xFF], @"FAIL");
    
    [_outputStream closeStream];
}

- (void)testWriteUnsignedChar
{
    [_outputStream setPath:_testPath];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeUnsignedChar:0xFF], @"FAIL");
    
    [_outputStream closeStream];    
}

- (void)testWriteShort
{
    [_outputStream setPath:_testPath];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeUnsignedChar:0xFFFF], @"FAIL");
    
    [_outputStream closeStream];    
}

@end
