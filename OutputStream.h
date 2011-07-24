//  This file is part of the BinaryStream package.
//
//  OutputStream.h
//  BinaryStream
//
//  Created by Víctor on 21/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import <Foundation/Foundation.h>
#import "BaseStream.h"

/**
 OutputStream - Class to write into a stream and save later as a file
 
 @author Víctor Berga <victor@victorberga.com>
 */
@interface OutputStream : BaseStream

#pragma mark -
#pragma mark Instance Methods

/**
 Open the stream in write mode
 
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
 Write char value in stream
 
 @param char Value to write
 */
- (void)writeChar:(char)value;

/**
 Write unsigned char value in stream
 
 @param unsgined char Value to write
 */
- (void)writeUnsignedChar:(unsigned char)value;

/**
 Write short value in stream
 
 @param short Value to write
 */
- (void)writeShort:(short)value;

/**
 Write unsigned short value in stream
 
 @param unsigned short Value to write
 */
- (void)writeUnsignedShort:(unsigned short)value;

/**
 Write int value in stream
 
 @param int Value to write
 */
- (void)writeInt:(int)value;

/**
 Write unsigned int value in stream
 
 @param unsigned int Value to write
 */
- (void)writeUnsignedInt:(unsigned int)value;

/**
 Write long value in stream
 
 @param long Value to write
 */
- (void)writeLong:(long)value;

/**
 Write unsigned long value in stream
 
 @param unsigned long Value to write
 */
- (void)writeUnsignedLong:(unsigned long)value;

/**
 Write float value in stream
 
 @param float long Value to write
 */
- (void)writeFloat:(float)value;

/**
 Write double long value in stream
 
 @param double long Value to write
 */
- (void)writeDouble:(double)value;

/**
 Write string value in stream
 
 @param NSString Value to write
 */
- (void)writeString:(NSString *)value;

@end
