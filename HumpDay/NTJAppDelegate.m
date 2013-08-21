//
//  NTJAppDelegate.m
//  HumpDay
//
//  Created by Joshua May on 20/08/2013.
//  Copyright (c) 2013 notjosh inc. All rights reserved.
//

#import "NTJAppDelegate.h"

#import "LaunchAtLoginController.h"

@interface NTJAppDelegate ()

@property (nonatomic, strong) IBOutlet NSMenu *menu;
@property (nonatomic, weak) IBOutlet LaunchAtLoginController *launchAtLoginController;

@property (nonatomic, strong) NSStatusItem *hump;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation NTJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.hump = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.hump.menu = self.menu;
    self.hump.highlightMode = YES;

    if ([self isFirstRun]) {
        self.launchAtLoginController.launchAtLogin = YES;
    }

    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(handleTick:)
                                                userInfo:nil
                                                 repeats:YES];

    [self handleTick:nil];
}

#pragma mark - Helper

- (BOOL)isFirstRun
{
    NSDictionary *defaults = @{
                               @"isFirstRun" : @YES
                               };
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];

    BOOL isFirstRun = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstRun"];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstRun"];

    return isFirstRun;
}

- (void)handleTick:(NSTimer *)timer
{
#if 0
    NSDateComponents *dateComponents = [self.calendar components:NSSecondCalendarUnit
                                                        fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents second];
#else
    NSDateComponents *dateComponents = [self.calendar components:NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit
                                                        fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];
#endif
    
    const NSInteger WEEKDAY_WEDNESDAY = 4;
    
    if (WEEKDAY_WEDNESDAY == weekday) {
        [self.hump setImage:[NSImage imageNamed:@"Hump"]];
        [self.hump setAlternateImage:[NSImage imageNamed:@"Hump-On"]];
    } else {
        [self.hump setImage:[NSImage imageNamed:@"NoHump"]];
        [self.hump setAlternateImage:[NSImage imageNamed:@"NoHump-On"]];
    }
}

@end
