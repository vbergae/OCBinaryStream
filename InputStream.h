//  This file is part of the BinaryStream package.
//
//  InputStream.h
//  BinaryStream
//
//  Created by Víctor on 12/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import <Foundation/Foundation.h>

/**
 
 */
@interface InputStream : NSObject {
@private
    NSString *_path;
    FILE *_file;
    char *_buffer;
    unsigned long _currentOffset;
    unsigned long _fileLen;
}

/**
 
 */
@property (nonatomic, retain) NSString *path;
/**
 
 */
@property (nonatomic, readonly) unsigned long offset;
/**
 
 */
@property (nonatomic, readonly) unsigned long len;
/**
 
 */
@property (nonatomic, readonly) BOOL isOpen;

#pragma mark -
#pragma mark Initializers

/**
 
 */
- (id)initWithPath:(NSString *)path;

#pragma mark -
#pragma mark Instance Methods

/**
 
 */
- (void)openStream;

/**
 
 */
- (void)closeStream;

/**
 
 */
- (char)readChar;

/**
 
 */
- (unsigned char)readUnsignedChar;

/**
 
 */
- (short)readShort;

/**
 
 */
- (unsigned short)readUnsignedShort;

/**
 
 */
- (int)readInt;

/**
 
 */
- (unsigned int)readUnsignedInt;

/**
 
 */
- (long)readLong;

/**
 
 */
- (unsigned long)readUnsignedLong;

@end
