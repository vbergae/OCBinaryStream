//  This file is part of the BinaryStream package.
//
//  BinaryStreamTests.h
//  BinaryStream
//
//  Created by Víctor on 14/07/11.
//  Copyright 2011 Víctor Berga <victor@victorberga.com>. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.

#import <SenTestingKit/SenTestingKit.h>
#import "InputStream.h"

@interface BinaryStreamTests : SenTestCase {
@private
    InputStream *_inputStream;
}

- (void)setTestPath:(NSString *)path;

@end
