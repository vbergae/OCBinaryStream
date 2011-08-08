//  This file is part of the BinaryStream package.
//
//  InputStream.m
//  BinaryStream
//
//  Created by Víctor on 12/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import "InputStream.h"

/**
 Private methods
 */
@interface InputStream(PrivateMethods)

/**
 Checks if is possible to read size from current offset
 
 @param unsingned long Size to check
 @param BOOL Return YES if is safety read the size
 */
- (BOOL)checkSizeToRead:(unsigned long)size;

/**
 Read a number of bytes and stores it in value pointer
 
 @param unsigned long Number of bytes to read
 @param void* Pointer to value which stores the bytes readed
 @exception NSException BUFFER_OVERFLOW
 */
- (void)readBytesOfLen:(unsigned long)len to:(void *)value;

@end

@implementation InputStream

#pragma mark -
#pragma mark Instance Methods

- (void)openStream
{
    const char *filename = [self.path 
                            cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
    _file = fopen(filename, "rb");
    
    NSAssert(_file, @"ERROR_OPENING_FILE");
    NSAssert(self.len > 0, @"ERROR_FILE_SIZE_ZERO");
    _currentOffset = 0;
    
    _buffer = (char *)malloc(self.len * sizeof(char));
    fread(_buffer, self.len, 1, _file);
    fclose(_file);
}


- (void)closeStream
{
    free(_buffer);
    _buffer     = NULL;
    _fileLen    = 0;
    _file       = NULL;
}

- (char)readChar
{
    char value;
    [self readBytesOfLen:sizeof(char) to:&value];
    
    return value;
}

- (unsigned char)readUnsignedChar
{
    unsigned char value;
    [self readBytesOfLen:sizeof(unsigned char) to:&value];
    
    return value;
}

- (short)readShort
{
    short value;
    [self readBytesOfLen:sizeof(short) to:&value];
    
    return NSSwapShort(value);
}

- (unsigned short)readUnsignedShort
{
    unsigned short value;
    [self readBytesOfLen:sizeof(unsigned short) to:&value];
    
    return NSSwapShort(value);
}

- (int)readInt
{
    int value;
    [self readBytesOfLen:sizeof(int) to:&value];
    
    return NSSwapInt(value);
}

- (unsigned int)readUnsignedInt
{
    unsigned int value;
    [self readBytesOfLen:sizeof(unsigned int) to:&value];
    
    return NSSwapInt(value);
}

- (long)readLong
{
    long value;
    [self readBytesOfLen:sizeof(long) to:&value];
    
    return NSSwapLong(value);
}

- (unsigned long)readUnsignedLong
{
    unsigned long value;
    [self readBytesOfLen:sizeof(unsigned long) to:&value];
    
    return NSSwapLong(value);
}

- (float)readFloat
{
    float value;
    [self readBytesOfLen:sizeof(float) to:&value];
    
    return value;
}

- (double)readDouble
{
    double value;
    [self readBytesOfLen:sizeof(double) to:&value];
    
    return value;
}

- (NSString *)readString
{
    unsigned char stringLen = [self readUnsignedChar];
    
    return [self readStringOfLen:stringLen];
}

- (NSString *)readStringOfLen:(unsigned long)len
{
    const char *value;
    [self readBytesOfLen:len to:&value];
    
    return [NSString stringWithCString:value
                              encoding:self.stringEncoding];
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)checkSizeToRead:(unsigned long)size
{
    return (size + _currentOffset <= _fileLen) ? YES : NO;
}

- (void)readBytesOfLen:(unsigned long)len to:(void *)value
{
    NSAssert([self checkSizeToRead:len], @"BUFFER_OVERFLOW");
    
    memcpy(value, &_buffer[_currentOffset], len);
    _currentOffset += len;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc
{
    if ([self isOpen]) {
        [self closeStream];
    }
    
    [super dealloc];
}

@end
