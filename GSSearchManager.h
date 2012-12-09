/*
 GSSearchManager.h
 
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


/** Protocol to access the search results or interact with the search process*/
@protocol GSSearchManagerDelegate <NSObject>

@optional
/** Method will be called after the search request is done
 
 @param resultArray is the array with all  matching items to the given string
 */
- (void)didFinishFilterItems:(NSArray*)resultArray;

@end

/** Class to handle search/filter in View using NSOperationsqueue.*/
@interface GSSearchManager : NSObject

#pragma mark Variables

//delegate for handling the search results
@property(nonatomic,weak)id<GSSearchManagerDelegate> delegate;

// operation queue for searching
@property(nonatomic,retain) NSOperationQueue *searchQueue;

#pragma mark Methods


/** Method to add a new search task using array with items and the searching string
 
 @param items is the list with all objects for searching
 @param searchingString is the string to look for
 */
- (void)addNewSearchRequest:(NSArray*)items withSearchString:(NSString*)searchingString;

/** Method to cancel all search operations
 
 */
- (void)cancelAllSearchOperations;



@end
