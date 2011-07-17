//  This file is part of the BinaryStream package.
//
//  BinaryStreamTests.m
//  BinaryStream
//
//  Created by Víctor on 14/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import "InputStreamTests.h"

@implementation BinaryStreamTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    _inputStream = [[InputStream alloc] init];
    STAssertNotNil(_inputStream, @"Failed instantiating InputStream");
}

- (void)tearDown
{
    [_inputStream release];
    STAssertFalse([_inputStream retainCount] == 0, @"_inputStream didn't released");
    
    _inputStream = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Properties Initialization

- (void)testSetPath
{
    NSString *path = @"/Users/vbergae/Documents/Cocoa/BinaryStream/test1.bin";
    [_inputStream setPath:path];
    
    STAssertTrue([_inputStream.path isEqualToString:path], @"Path propertu broken");
}

- (void)testSetDefaultOffset
{
    STAssertTrue(_inputStream.offset == 0, 
             @"inputStream.offset should be 0 but is %d",
             _inputStream.offset);
}

- (void)testSetDefaultLen
{
    STAssertThrows([_inputStream len], @"Lend ");
}

- (void)testIsOpen
{
    STAssertTrue([_inputStream isOpen] == NO, @"iOpen should be NO");
}

#pragma mark -
#pragma mark Methods Tests

- (void)testOpenCloseStream
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/test1.bin"];
    
    // Opening file
    STAssertNoThrow([_inputStream openStream], @"openStrem fails");
    STAssertTrue([_inputStream isOpen], @"Stream appears to be closed");    
    STAssertTrue([_inputStream len] == 8,
                 @"File len should be 8 but is %d", 
                 [_inputStream len]);
    STAssertTrue([_inputStream offset] == 0,
                 @"Current should be 0 but is %d", 
                 [_inputStream offset]);
    
    //Closing file
    STAssertNoThrow([_inputStream closeStream], 
                    @"Exception throw closing stream");
    STAssertFalse([_inputStream isOpen], @"Stream appears to be opened");
    STAssertThrows([_inputStream len],
                 @"File len should throw an expcetion (file closed)");
    STAssertTrue([_inputStream offset] == 0,
                 @"Current should be 0 but is %d", 
                 [_inputStream offset]);
}

- (void)testReadChar
{
    NSLog(@"hex(128): 0x%x", -128);
    
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/test1.bin"];
    [_inputStream openStream];
    
    // Tests first 4 bytes in test1.bin file 
    // File contents (0x00, 0x01, 0x0A, 0xFF, 0x80, 0x81, 0x79, 0xFF)
    char value;
    
    value = [_inputStream readChar];
    STAssertTrue(value == 0, 
                 @"First byte should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 1, 
                 @"offset should be 1 but is %d", [_inputStream offset]);
    
    value = [_inputStream readChar];
    STAssertTrue(value == 1, 
                 @"First byte should be 1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 2, 
                 @"offset should be 2 but is %d", [_inputStream offset]);
    
    value = [_inputStream readChar];
    STAssertTrue(value == 10, 
                 @"First byte should be 10 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 3, 
                 @"offset should be 3 but is %d", [_inputStream offset]);
    
    value = [_inputStream readChar];
    STAssertTrue(value == -1, 
                 @"First byte should be -1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 4 but is %d", [_inputStream offset]);

    value = [_inputStream readChar];
    STAssertTrue(value == -128, 
                 @"First byte should be -128 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 5, 
                 @"offset should be 5 but is %d", [_inputStream offset]);

    value = [_inputStream readChar];
    STAssertTrue(value == -127, 
                 @"First byte should be -127 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 6, 
                 @"offset should be 6 but is %d", [_inputStream offset]);

    value = [_inputStream readChar];
    STAssertTrue(value == 128, 
                 @"First byte should be 128 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 7, 
                 @"offset should be 7 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == -1, 
                 @"First byte should be -1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 1 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];
}

- (void)testReadUnsignedChar
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/test1.bin"];
    [_inputStream openStream];
    
    // Tests first 4 bytes in test1.bin file 
    // File contents (0x00, 0x01, 0x0A, 0xFF, 0x80, 0x81, 0x79, 0xFF)
    unsigned char value;
    
    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == 0, 
                 @"First byte should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 1, 
                 @"offset should be 1 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == 1, 
                 @"First byte should be 1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 2, 
                 @"offset should be 2 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == 10, 
                 @"First byte should be 10 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 3, 
                 @"offset should be 3 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == 255, 
                 @"First byte should be 255 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 1 but is %d", [_inputStream offset]);

    value = [_inputStream readChar];
    STAssertTrue(value == 128, 
                 @"First byte should be 128 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 5, 
                 @"offset should be 5 but is %d", [_inputStream offset]);
    
    value = [_inputStream readChar];
    STAssertTrue(value == 129, 
                 @"First byte should be 129 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 6, 
                 @"offset should be 6 but is %d", [_inputStream offset]);
    
    value = [_inputStream readChar];
    STAssertTrue(value == 121, 
                 @"First byte should be 121 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 7, 
                 @"offset should be 7 but is %d", [_inputStream offset]);

    value = [_inputStream readUnsignedChar];
    STAssertTrue(value == 255, 
                 @"First byte should be 255 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 1 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];    
}

#pragma mark -
#pragma mark Intance/Helper Methods

- (void)setTestPath:(NSString *)path
{
    [_inputStream setPath:path];
}

@end
