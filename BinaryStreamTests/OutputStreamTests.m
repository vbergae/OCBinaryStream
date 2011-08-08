//
//  OutputStreamTests.m
//  BinaryStream
//
//  Created by Víctor Berga on 24/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OutputStreamTests.h"

#define setTestFile(file)     [_testPath stringByAppendingPathComponent:file]

@implementation OutputStreamTests

- (void)setUp
{
    [super setUp];
    
    _testPath = @"/Users/vbergae/Desktop/tests";
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
    NSString *path = setTestFile(@"prop.dat");
    
    [_outputStream setPath:path];
    STAssertTrue([_outputStream.path isEqualToString:path], 
                 @"Path should be %@, but is %@",
                 path, _outputStream.path);
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
    [_outputStream setPath:setTestFile(@"open_close.dat")];
    
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
    [_outputStream setPath:setTestFile(@"char.dat")];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeChar:127], @"FAIL");
    STAssertNoThrow([_outputStream writeChar:-1], @"FAIL");
    STAssertNoThrow([_outputStream writeChar:255], @"FAIL");
    
    [_outputStream closeStream];
}

- (void)testWriteUnsignedChar
{
    [_outputStream setPath:setTestFile(@"uchar.dat")];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeUnsignedChar:10], @"FAIL");
    STAssertNoThrow([_outputStream writeChar:127], @"FAIL");
    STAssertNoThrow([_outputStream writeChar:128], @"FAIL");    
    STAssertNoThrow([_outputStream writeChar:-1], @"FAIL");
    STAssertNoThrow([_outputStream writeChar:255], @"FAIL");
    
    [_outputStream closeStream];    
}

- (void)testWriteShort
{
    [_outputStream setPath:setTestFile(@"short.dat")];
    [_outputStream openStream];
    
    STAssertNoThrow([_outputStream writeShort:0xFFFF], @"FAIL");
    
    [_outputStream closeStream];    
}

- (void)testWriteString
{
    [_outputStream setPath:setTestFile(@"string.dat")];
    [_outputStream openStream];
    
    NSString *cadena = @"Hola esto es una prueba";
    
    STAssertNoThrow([_outputStream writeString:cadena], @"FAIL");
    
    [_outputStream closeStream];
}

@end
