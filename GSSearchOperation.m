/*
 GSSearchOperation.m
 
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

#import "GSSearchOperation.h"


@interface GSSearchOperation()

//delegate object which will be called after finished
@property(nonatomic,weak)id<GSSearchManagerDelegate>delegate;

//list with all items
@property(nonatomic,retain) NSArray *itemList;

//searching item name
@property(nonatomic,retain) NSString *searchValue;

//flags for the operation status
@property(nonatomic,readwrite) BOOL executing;
@property(nonatomic,readwrite) BOOL finished;

@end

@implementation GSSearchOperation

@synthesize delegate = m_delegate;
@synthesize itemList = m_itemList;
@synthesize searchValue = m_searchValue;
@synthesize executing = m_executing;
@synthesize finished = m_finished;

- (id)initWithTarget:(id<GSSearchManagerDelegate>)delegate inArray:(NSArray*)itemList forValue:(NSString*)searchValue{
    self = [super init];
    
    if (self) {
        //initial
        self.delegate = delegate;
        self.itemList = itemList;
        self.searchValue = searchValue;
        
        m_executing = NO;
        m_finished = NO;
    }
    
    return self;
}

- (void)dealloc{
    self.delegate = nil;
    self.itemList = nil;
    self.searchValue = nil;
}

#pragma mark Operation Methods

- (void)start{
    
    [self setOperationStarted:YES];
    
    //missing setting
    if (!m_delegate||!m_searchValue||!m_itemList||m_executing) {
        return;
    }
    
    //set finished to NO by start
    [self willChangeValueForKey:@"isFinished"];
    m_finished = NO;
    [self didChangeValueForKey:@"isFinished"];
    
    if ([self isCancelled]) {
        return;
    }
    
    // Set executing state in KVO-compliance.
	[self willChangeValueForKey:@"isExecuting"];
	m_executing = YES;
	[self didChangeValueForKey:@"isExecuting"];
    
    
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.itemList];
    //NSMutableArray *removeList = [NSMutableArray new];
    
    //call parent to decide which items will be removed
    list = [m_delegate diffItems:m_searchValue withList:list];
    
    
    //forward the result to target method
    if([m_delegate respondsToSelector:@selector(didFinishFilterItems:)]) {
        [m_delegate didFinishFilterItems:list];
        
    }
    
    // Set executing and finished states in KVO-compliance.
	[self willChangeValueForKey:@"isExecuting"];
	m_executing = NO;
	[self didChangeValueForKey:@"isExecuting"];
    
	[self willChangeValueForKey:@"isFinished"];
	m_finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting {
	
    return m_executing;
}

- (BOOL)isFinished {
	
    return m_finished;
}

- (void)cancel
{
    if (![self isOperationStarted]) {
        return;
    }
    // Set executing and finished states in KVO-compliance.
	[self willChangeValueForKey:@"isExecuting"];
	m_executing = NO;
	[self didChangeValueForKey:@"isExecuting"];
    
	[self willChangeValueForKey:@"isFinished"];
	m_finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    
    [super cancel]; // Don't forget to call cancel on superclass.
}

@end
