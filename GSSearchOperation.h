/*
 GSSearchOperation.h
 
 Copyright (c) 2012 Gobas GmbH / Truong Vinh Tran
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

#import "GSSearchManager.h"

@interface GSSearchOperation : NSOperation

@property (nonatomic,assign,getter = isOperationStarted) BOOL operationStarted;

#pragma mark Variables

/** Method to initial a search operation with all required informations
 
 @param delegate is the target ViewController which will be called after success
 @param itemList is the array with all items which needs to be filtered
 @param searchValue is the string which needs to be found within the array
 */
- (id)initWithTarget:(id<GSSearchManagerDelegate>)delegate inArray:(NSArray*)itemList forValue:(NSString*)searchValue;

@end
