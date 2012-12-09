/*
 GSSearchManager.m
 
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

#import "GSSearchManager.h"

//import to use in the operation queue
#import "GSSearchOperation.h"

@implementation GSSearchManager

@synthesize delegate = m_delegate;
@synthesize searchQueue = m_searchQueue;

#pragma mark - Main Methods

- (id)init{
    self = [super init];
    
    if (self) {
        //init the search queue
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.maxConcurrentOperationCount = 1; //one should be enough for search
        self.searchQueue = operationQueue;
        
    }
    return self;
}

- (void)dealloc{
    [self.searchQueue cancelAllOperations];
}

#pragma mark - Public Methods

- (void)addNewSearchRequest:(NSArray*)items withSearchString:(NSString*)searchingString{
    
    //dont allow without delegate
    if (!m_delegate) {
        NSLog(@"GSSearchManager#%@ Missing delegate",NSStringFromSelector(_cmd));
        return;
    }
    
    //cancel all previous operation
    [m_searchQueue cancelAllOperations];
    
    //add new operation
    GSSearchOperation *operation = [[GSSearchOperation alloc] initWithTarget:m_delegate inArray:items forValue:searchingString];
    [m_searchQueue addOperation:operation];
}

- (void)cancelAllSearchOperations{
    [m_searchQueue cancelAllOperations];
}


@end