//  This file is part of the BinaryStream package.
//
//  OutputStream.m
//  BinaryStream
//
//  Created by Víctor on 21/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import "OutputStream.h"

@implementation OutputStream

- (BOOL)isOpen
{
    return (_file) ? YES : NO;
}

#pragma mark -
#pragma mark Instance Methods

- (void)openStream
{
    const char *filename = [self.path cStringUsingEncoding:NSASCIIStringEncoding];
    
    _file = fopen(filename, "wb");
    
    NSAssert(_file, @"ERROR_OPENING_FILE");
    _currentOffset = 0;
}

- (void)closeStream
{
    fclose(_file);
    _file       = NULL;
    _fileLen    = 0;    
}

- (void)writeChar:(char)value
{
    fwrite(&value, sizeof(char), 1, _file);
}

- (void)writeUnsignedChar:(unsigned char)value
{
    fwrite(&value, sizeof(unsigned char), 1, _file);
}

- (void)writeShort:(short)value
{
    fwrite(&value, sizeof(short), 1, _file);
}

- (void)writeUnsignedShort:(unsigned short)value
{
    fwrite(&value, sizeof(unsigned short), 1, _file);
}

- (void)writeInt:(int)value
{
    fwrite(&value, sizeof(int), 1, _file);
}

- (void)writeUnsignedInt:(unsigned int)value
{
    fwrite(&value, sizeof(unsigned int), 1, _file);
}

- (void)writeLong:(long)value
{
    fwrite(&value, sizeof(long), 1, _file);    
}

- (void)writeUnsignedLong:(unsigned long)value
{
    fwrite(&value, sizeof(unsigned long), 1, _file);    
}

- (void)writeFloat:(float)value
{
    fwrite(&value, sizeof(float), 1, _file);    
}

- (void)writeDouble:(double)value
{
    fwrite(&value, sizeof(double), 1, _file);    
}

- (void)writeString:(NSString *)value
{
    const char *cValue = [value cStringUsingEncoding:self.stringEncoding];
    fwrite(cValue, sizeof(cValue), 1, _file);
}

@end
