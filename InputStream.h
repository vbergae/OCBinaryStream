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
 Class to read a binary file
 
 @author Víctor Berga <victor@victorberga.com>
 */
@interface InputStream : NSObject {
@private
    NSString        *_path;
    FILE            *_file;
    char            *_buffer;
    unsigned long   _currentOffset;
    unsigned long   _fileLen;
}

/**
 Path to file 
 */
@property (nonatomic, retain) NSString *path;
/**
 Current offset
 */
@property (nonatomic, readonly) unsigned long offset;
/**
 File len
 */
@property (nonatomic, readonly) unsigned long len;
/**
 Return YES if the file is open and ready
 */
@property (nonatomic, readonly) BOOL isOpen;

#pragma mark -
#pragma mark Initializers

/**
 Initialize a new InputStream object
 
 @param NSString File path to read
 @return InputStream
 @access pubblic
 */
- (id)initWithPath:(NSString *)path;

#pragma mark -
#pragma mark Instance Methods

/**
 Open the stream in read mode
 
 @access public
 */
- (void)openStream;

/**
 Close the stream
 
 @access public
 */
- (void)closeStream;

/**
 Read next char in stream
 
 @return char
 @access public
 */
- (char)readChar;

/**
 Read next unsigned char in stream
 
 @return unsigned char
 @access public
 */
- (unsigned char)readUnsignedChar;

/**
 Read next short in stream
 
 @return short
 @access public 
 */
- (short)readShort;

/**
 Read next unsigned short in stream
 
 @return unsigned short
 @access public 
 */
- (unsigned short)readUnsignedShort;

/**
 Read next int in stream
 
 @return int
 @access public 
 */
- (int)readInt;

/**
 Read next unsigned int in stream
 
 @return unsigned int
 @access public  
 */
- (unsigned int)readUnsignedInt;

/**
 Read next long in stream
 
 @return long
 @access public  
 */
- (long)readLong;

/**
 Read next unsigned long in stream
 
 @return unsigned long
 @access public  
 */
- (unsigned long)readUnsignedLong;

@end
