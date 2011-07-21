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
#import "BaseStream.h"

/**
 Class to read a binary file
 
 @author Víctor Berga <victor@victorberga.com>
 */
@interface InputStream : BaseStream

#pragma mark -
#pragma mark Instance Methods

/**
 Open the stream in read mode
 
 @exception NSException ERROR_OPENING_FILE
 @exception NSException ERRROR_FILE_SIZE_ZERO
 */
- (void)openStream;

/**
 Close the stream
 
@throws Exception on error
 */
- (void)closeStream;

/**
 Read next char in stream
 
 @return char
 */
- (char)readChar;

/**
 Read next unsigned char in stream
 
 @return unsigned char
 */
- (unsigned char)readUnsignedChar;

/**
 Read next short in stream
 
 @return short
 */
- (short)readShort;

/**
 Read next unsigned short in stream
 
 @return unsigned short
 */
- (unsigned short)readUnsignedShort;

/**
 Read next int in stream
 
 @return int
 */
- (int)readInt;

/**
 Read next unsigned int in stream
 
 @return unsigned int
 */
- (unsigned int)readUnsignedInt;

/**
 Read next long in stream
 
 @return long
 */
- (long)readLong;

/**
 Read next unsigned long in stream
 
 @return unsigned long
 */
- (unsigned long)readUnsignedLong;

/**
 Read next float in stream
 
 @return float
 */
- (float)readFloat;

/**
 Read next double in stream
 
 @return double
 */
- (double)readDouble;

/**
 Reads a string with a len of the first unsigned byte
 
 @return NSString
 */
- (NSString *)readString;

/**
 Reads a string with the specified len
 
 @param unsigned long
 @return NSString
 */
- (NSString *)readStringOfLen:(unsigned long)len;

@end
