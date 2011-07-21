//  This file is part of the BinaryStream package.
//
//  BaseStream.h
//  BinaryStream
//
//  Created by Víctor on 21/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import "BaseStream.h"

@implementation BaseStream

@synthesize path            = _path;
@synthesize offset          = _currentOffset;
@dynamic    len;
@dynamic    isOpen;
@synthesize stringEncoding  = _stringEncoding;

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
#pragma mark Debug methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"Path: %@; Current Offset: %lu; File len: %lu; Open: %b", self.path, self.offset, self.len,self.isOpen];
}

@end
