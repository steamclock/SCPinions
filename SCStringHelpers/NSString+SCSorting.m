//
//  NSString+SCSorting.m
//
// -- Software License --
//
// Copyright (C) 2012, Steam Clock Software, Ltd.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// ----------------------

#import "NSString+SCSorting.h"

@implementation NSString (SCSorting)

-(NSString*)stringForSmartSorting
{
    NSCharacterSet* nonalphanumeric = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    NSString* text = [self stringByTrimmingCharactersInSet:nonalphanumeric];
    
    NSRange range = [text rangeOfString:@"a " options:NSCaseInsensitiveSearch];
    
    if(range.location == 0) {
        return [[text substringFromIndex:2] stringByTrimmingCharactersInSet:nonalphanumeric];
    }
    
    range = [text rangeOfString:@"the " options:NSCaseInsensitiveSearch];
    
    if(range.location == 0) {
        return [[text substringFromIndex:4] stringByTrimmingCharactersInSet:nonalphanumeric];
    }
    
    return text;
}

+(NSComparisonResult (^)(id obj1, id obj2))smartSortComparator
{
    return [self smartSortComparatorWithExtraction:^NSString *(id obj) {
        return obj;
    }];
}

+(NSComparisonResult (^)(id obj1, id obj2))smartSortComparatorWithExtraction:(NSString* (^)(id))extraction
{
    return ^NSComparisonResult(id obj1, id obj2) {
        NSString* a = [extraction(obj1) stringForSmartSorting];
        NSString* b = [extraction(obj2) stringForSmartSorting];
        
        if ([a intValue] < [b intValue]) {
            return NSOrderedAscending;
        }
        
        if ([a intValue] > [b intValue]) {
            return NSOrderedDescending;
        }
        
        return [a localizedStandardCompare:b];
    };
}


-(BOOL)matchesSearchString:(NSString*)searchString {
    if (!searchString) {
        return NO;
    }
    
    NSRange foundRange = [self rangeOfString:searchString options:NSDiacriticInsensitiveSearch | NSCaseInsensitiveSearch];
    
    if (foundRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end
