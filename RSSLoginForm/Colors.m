//
//  Colors.m
//  RSSLoginForm
//
//  Created by Dmitriy Komar on 7/4/21.
//

#import "Colors.h"

@implementation Colors

- (id)init
{
    self = [super init];
    if (self) {
        _blackCoral = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00];
        _turquoiseGreen = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00];
        _venetioanRed = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00];
        _black = [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 1.00];
        _littleBoyBlue = [UIColor colorWithRed: 0.50 green: 0.64 blue: 0.93 alpha: 1.00];
        _littleBoyBlueTouchDownBackgroundButton = [UIColor colorWithRed: 0.50 green: 0.64 blue: 0.93 alpha: 0.20];
        _littleBoyBlueTouchDownBackgroundText = [UIColor colorWithRed: 0.50 green: 0.64 blue: 0.93 alpha: 0.40];
        _white = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 1.00];
    }
    
    return self;
}

@end
