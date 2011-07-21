//  This file is part of the BinaryStream package.
//
//  InputStream.h
//  BinaryStream
//
//  Created by Víctor on 21/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import <Foundation/Foundation.h>

@interface BaseStream : NSObject {
@protected
    NSString            *_path;        
    FILE                *_file;
    char                *_buffer;
    unsigned long       _currentOffset;
    unsigned long       _fileLen;
    NSStringEncoding    _stringEncoding;    
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
/**
 Sets or gets the string enconding. Default is NSUTF8StringEncoding
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

@end
