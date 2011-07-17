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

@interface InputStream(PrivateMethods)

/**
 
 */
- (BOOL)checkSizeToRead:(unsigned long)size;

/**
 
 */
- (void)readBytesOfLen:(unsigned long)len to:(void *)buf;

@end

@implementation InputStream

@synthesize path    = _path;
@synthesize offset  = _currentOffset;
@dynamic    len;
@dynamic    isOpen;

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

- (char)readChar
{
    char value;
    memcpy(&value, &_buffer[_currentOffset], sizeof(char));
    _currentOffset += sizeof(char);
    
    return value;
}

- (unsigned char)readUnsignedChar
{
    unsigned char value;
    memcpy(&value, &_buffer[_currentOffset], sizeof(unsigned char));
    _currentOffset += sizeof(unsigned char);
    
    return value;
}

- (short)readShort
{
    return 0xFFFF;
}

- (unsigned short)readUnsignedShort
{
    return 0xFFFF;
}

- (int)readInt
{
    return 0xFFFFFFFF;
}

- (unsigned int)readUnsignedInt
{
    return 0xFFFFFFFF;
}

- (long)readLong
{
    return 0xFFFFFFFF;
}

- (unsigned long)readUnsignedLong
{
    return 0xFFFFFFFF;
}

#pragma mark -
#pragma mark Private Methods

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
    _buffer = NULL;
    _fileLen = 0;
    _file = NULL;
}

- (BOOL)checkSizeToRead:(unsigned long)size
{
    return (size + _currentOffset <= _fileLen) ? YES : NO;
}

- (void)readBytesOfLen:(unsigned long)len to:(void *)buf
{
    if (![self checkSizeToRead:len]) {
        @throw [NSException exceptionWithName:@"Buffer overflow"
                                       reason:nil
                                     userInfo:nil];
    }
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc
{
    [_path release];
    _path = nil;
    
    [super dealloc];
}

@end
