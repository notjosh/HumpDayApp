//
//  NTJAppDelegate.m
//  HumpDay
//
//  Created by Joshua May on 20/08/2013.
//  Copyright (c) 2013 notjosh inc. All rights reserved.
//

#import "NTJAppDelegate.h"

#import "StartAtLoginController.h"

@interface NTJAppDelegate ()

@property (nonatomic, strong) IBOutlet NSMenu *menu;

@property (nonatomic, strong) NSStatusItem *hump;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation NTJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.hump = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.hump.menu = self.menu;

//    [self.hump.button.cell highli]
    self.hump.highlightMode = YES;

    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(handleTick:)
                                                userInfo:nil
                                                 repeats:YES];

    [self handleTick:nil];
}

#pragma mark - Helper

- (void)handleTick:(NSTimer *)timer
{
#if 0
    NSDateComponents *dateComponents = [self.calendar components:NSSecondCalendarUnit
                                                        fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents second] % 10;
#else
    NSDateComponents *dateComponents = [self.calendar components:NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                        fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];
#endif

    const NSInteger WEEKDAY_WEDNESDAY = 4;

    NSImage *image = [NSImage imageNamed:@"NoHump"];

    // hump day
    if (WEEKDAY_WEDNESDAY == weekday) {
        image = [NSImage imageNamed:@"Hump"];
    }
    // valentine
    else if (dateComponents.month == 2 && dateComponents.day == 14) {
        image = [NSImage imageNamed:@"HumpMe"];
    }

    image.template = YES;

    self.hump.button.image = image;
}

@end
