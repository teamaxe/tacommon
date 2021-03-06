/**
 Implementation: Using NSMutableArray as the container.

 @class TAStack TAStack.h
 */

#import "TAStack.h"

@interface TAStack ()

@property (nonatomic) NSMutableArray *items;

@end

@implementation TAStack

- (id) init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
    }

    return self;
}

- (id)copyWithZone:(NSZone *)zone {

    id copy = [[self.class alloc] init];
    NSEnumerator *reversedItemsEnumeration = [self.items reverseObjectEnumerator];
    NSMutableArray *reversedItems = [[NSMutableArray alloc] initWithCapacity:self.items.count];

    id nextItem;
    while (nextItem = [reversedItemsEnumeration nextObject]) {
        [reversedItems addObject:nextItem];
    }

    [copy pushItemsFromArray:reversedItems];
    return copy;
}

- (void) clear {
    [self.items removeAllObjects];
}

- (BOOL) isEmpty {
    return self.items.count == 0;
}

- (id) peek {
    return (self.items.count) ? [self.items lastObject] : nil;
}

- (id) pop {

    id poppedObject;

    if (self.items.count) {
        poppedObject = [self.items lastObject];
        [self.items removeLastObject];
    }

    return poppedObject;
}

- (void)push:(id)item {
    [self.items addObject:item];
}

- (void) pushItemsFromArray:(NSArray *) items {

    for (id item in items) {
        [self push:item];
    }
}

- (void) pushItemsFromDictionary:(NSDictionary *) items {

    NSMutableArray *unsortedItems = (NSMutableArray *)[items allKeys];

    NSArray *sortedItems = [unsortedItems sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    for (id item in sortedItems) {
        [self push:item];
    }
}

- (void) pushItemsFromOrderedSet:(NSOrderedSet *)items {

    for (id item in items) {
        [self push:item];
    }
}

- (void) pushItemsFromStack:(TAStack *) items {
    TAStack *tempStack = [items copy];

    while (!tempStack.isEmpty) {
        [self push:[tempStack pop]];
    }
}

- (NSUInteger) size {
    return self.items.count;
}

- (NSString *)description {

    return [self.items description];
    
}

@end
