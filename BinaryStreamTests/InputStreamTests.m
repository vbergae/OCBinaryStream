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
    NSString *path = @"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test1.bin";
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test1.bin"];
    
    STAssertTrue([_inputStream.path isEqualToString:path], 
                 @"Path property broken");
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
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test1.bin"];
    
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
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test1.bin"];
    [_inputStream openStream];
    
    // Tests first 8 bytes in test1.bin file 
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
    STAssertTrue(value == 121, 
                 @"First byte should be 121 but is %d", 
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
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test1.bin"];
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

- (void)testReadShort
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test2.bin"];
    [_inputStream openStream];
    
    // Tests first 8 bytes in test2.bin file 
    // File contents (0x00, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0x00, 0xFF)
    
    short value;
    
    value = [_inputStream readShort];
    STAssertTrue(value == (short)0, 
                 @"First short should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 2, 
                 @"offset should be 2 but is %d", [_inputStream offset]);

    value = [_inputStream readShort];
    STAssertTrue(value == (short)1, 
                 @"Short should be 1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 4 but is %d", [_inputStream offset]);

    value = [_inputStream readShort];
    STAssertTrue(value == (short)-1, 
                 @"Short should be -1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 6, 
                 @"offset should be 4 but is %d", [_inputStream offset]);

    value = [_inputStream readShort];
    STAssertTrue(value == (short)255, 
                 @"Short should be 255 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];
}

- (void)testReadUnsignedShort
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test2.bin"];
    [_inputStream openStream];
    
    // Tests first 8 bytes in test2.bin file 
    // File contents (0x00, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0x00, 0xFF)
    
    unsigned short value;
    
    value = [_inputStream readShort];
    STAssertTrue(value == (unsigned short)0, 
                 @"First short should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 2, 
                 @"offset should be 2 but is %d", [_inputStream offset]);
    
    value = [_inputStream readShort];
    STAssertTrue(value == (unsigned short)1, 
                 @"Short should be 1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    value = [_inputStream readShort];
    STAssertTrue(value == (unsigned short)65535, 
                 @"Short should be 65535 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 6, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    value = [_inputStream readShort];
    STAssertTrue(value == (unsigned short)255, 
                 @"Short should be 255 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];
}

- (void)testReadInt
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test3.bin"];
    [_inputStream openStream];
    
    // Tests first 16 bytes in test2.bin file 
    // File contents (00000000 FFFFFFFF FFFF0000 0000FFFF)

    int value;
    
    value = [_inputStream readInt];
    STAssertTrue(value == (int)0, 
                 @"First int should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    value = [_inputStream readInt];
    STAssertTrue(value == (int)-1, 
                 @"First int should be -1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 8 but is %d", [_inputStream offset]);
    
    value = [_inputStream readInt];
    STAssertTrue(value == (int)-65536, 
                 @"First int should be -65536 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 12, 
                 @"offset should be 12 but is %d", [_inputStream offset]);    
    
    value = [_inputStream readInt];
    STAssertTrue(value == (int)65535, 
                 @"First int should be 65535 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 16, 
                 @"offset should be 16 but is %d", [_inputStream offset]);        
    
    [_inputStream closeStream];
}

- (void)testReadUnsignedInt
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test3.bin"];
    [_inputStream openStream];
    
    // Tests first 16 bytes in test3.bin file 
    // File contents (00000000 FFFFFFFF FFFF0000 0000FFFF)
    
    unsigned int value;
    
    value = [_inputStream readUnsignedInt];
    STAssertTrue(value == (unsigned int)0, 
                 @"First int should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 4, 
                 @"offset should be 4 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedInt];
    STAssertTrue(value == (unsigned int)4294967295, 
                 @"First int should be 4294967295 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 8 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedInt];
    STAssertTrue(value == (unsigned int)4294901760, 
                 @"First int should be 4294901760 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 12, 
                 @"offset should be 12 but is %d", [_inputStream offset]);    
    
    value = [_inputStream readUnsignedInt];
    STAssertTrue(value == (unsigned int)65535, 
                 @"First int should be 65535 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 16, 
                 @"offset should be 16 but is %d", [_inputStream offset]);  
    
    [_inputStream closeStream];
}

- (void)testReadLong
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test4.bin"];
    [_inputStream openStream];    

    // Tests first 16 bytes in test3.bin file 
    // File contents:
    //  1: 0x00000000 00000000 
    //  2: 0xFFFFFFFF FFFFFFFF
    //  3: 0x00000000 FFFFFFFF 
    //  4: 0xFFFFFFFF 00000000
    //  5: 0xFF000000 00000000 
    //  7: 0x00000000 000000FF
    
    long value;
    
    value = [_inputStream readLong];
    STAssertTrue(value == (long)0, 
                 @"First int should be 0 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 8 but is %d", [_inputStream offset]);

    value = [_inputStream readLong];
    STAssertTrue(value == (long)-1, 
                 @"First int should be -1 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 16, 
                 @"offset should be 8 but is %d", [_inputStream offset]);

    value = [_inputStream readLong];
    STAssertTrue(value == (long)4294967295, 
                 @"First int should be 4294967295 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 24, 
                 @"offset should be 24 but is %d", [_inputStream offset]);

    value = [_inputStream readLong];
    STAssertTrue(value == (long)-4294967296, 
                 @"First int should be -4294967296 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 32, 
                 @"offset should be 32 but is %d", [_inputStream offset]);

    value = [_inputStream readLong];
    STAssertTrue(value == (long)-72057594037927936, 
                 @"First int should be -72057594037927936 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 40, 
                 @"offset should be 40 but is %d", [_inputStream offset]);

    value = [_inputStream readLong];
    STAssertTrue(value == (long)255, 
                 @"First int should be 255 but is %d",
                 value);
    STAssertTrue([_inputStream offset] == 48, 
                 @"offset should be 48 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];
}

- (void)testReadUnsignedLong
{
    [self setTestPath:@"/Users/vbergae/Documents/Cocoa/BinaryStream/BinaryStreamTests/files/test4.bin"];
    [_inputStream openStream];    
    
    // Tests first 16 bytes in test3.bin file 
    // File contents:
    //  1: 0x00000000 00000000 
    //  2: 0xFFFFFFFF FFFFFFFF
    //  3: 0x00000000 FFFFFFFF 
    //  4: 0xFFFFFFFF 00000000
    //  5: 0xFF000000 00000000 
    //  7: 0x00000000 000000FF
    
    unsigned long value;
    
    value = [_inputStream readUnsignedLong];
    STAssertTrue(value == (unsigned long)0, 
                 @"First int should be 0 but is %lu", 
                 value);
    STAssertTrue([_inputStream offset] == 8, 
                 @"offset should be 8 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedLong];
    unsigned long foo = 18446744073709551615;
    STAssertTrue(value == foo, 
                 @"First int should be 18446744073709551615 but is %lu",
                 value);
    STAssertTrue([_inputStream offset] == 16, 
                 @"offset should be 8 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedLong];
    STAssertTrue(value == (unsigned long)4294967295, 
                 @"First int should be 4294967295 but is %d",
                 value);
    STAssertTrue([_inputStream offset] == 24, 
                 @"offset should be 24 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedLong];
    STAssertTrue(value == (unsigned long)18446744069414584320, 
                 @"First int should be 18446744069414584320 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 32, 
                 @"offset should be 32 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedLong];
    STAssertTrue(value == (unsigned long)18374686479671623680, 
                 @"First int should be 18374686479671623680 but is %d", 
                 value);
    STAssertTrue([_inputStream offset] == 40, 
                 @"offset should be 40 but is %d", [_inputStream offset]);
    
    value = [_inputStream readUnsignedLong];
    STAssertTrue(value == (unsigned long)255, 
                 @"First int should be 255 but is %d",
                 value);
    STAssertTrue([_inputStream offset] == 48, 
                 @"offset should be 48 but is %d", [_inputStream offset]);
    
    [_inputStream closeStream];
}

#pragma mark -
#pragma mark Intance/Helper Methods

- (void)setTestPath:(NSString *)path
{
    [_inputStream setPath:path];
}

@end
