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
 
 @oaram unsingned long Size to check
 @param BOOL Return YES if is safety read the size
 @access private
 */
- (BOOL)checkSizeToRead:(unsigned long)size;

/**
 Read a number of bytes and stores it in value pointer
 
 @param unsigned long Number of bytes to read
 @param void* Pointer to value which stores the bytes readed
 @access private
 */
- (void)readBytesOfLen:(unsigned long)len to:(void *)value;

@end

@implementation InputStream

@synthesize path            = _path;
@synthesize offset          = _currentOffset;
@dynamic    len;
@dynamic    isOpen;
@synthesize stringEncoding  = _stringEncoding;

#pragma mark -
#pragma mark Initializers

- (id)init
{
    self = [super init];
    if (self)
    {
        _path           = nil;
        _file           = NULL;
        _buffer         = NULL;
        _currentOffset  = 0;
        _fileLen        = 0;
        _stringEncoding = NSUTF8StringEncoding;
    }
    
    return self;
}

- (id)initWithPath:(NSString *)path
{
    self = [self init];
    if (self)
    {
        [self setPath:path];
    }
    
    return self;
}

#pragma mark -
#pragma mark Dynamic Properties

- (unsigned long)len
{
    if (!_fileLen)
    {
        NSAssert(_file, @"ERROR_FILE_CLOSED");
        
        fseek(_file, 0, SEEK_END);
        _fileLen = ftell(_file);
        fseek(_file, 0, SEEK_SET);        
    }

    return _fileLen;
}

- (BOOL)isOpen
{
    return (_buffer) ? YES : NO;
}

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
    if (![self checkSizeToRead:len]) {
        @throw [NSException exceptionWithName:@"Buffer overflow"
                                       reason:nil
                                     userInfo:nil];
    }
    
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
    
    [_path release];
    _path = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Debug methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"Path: %@; Current Offset: %lu; File len: %lu; Open: %b", self.path, self.offset, self.len,self.isOpen];
}

@end
