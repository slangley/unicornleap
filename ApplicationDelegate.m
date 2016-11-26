//
//  ApplicationDelegate.m
//  unicornleap
//
//  Created by Sean Langley on 2016-11-20.
//  Copyright © 2016 Joshua Davey. All rights reserved.
//

#import "ApplicationDelegate.h"
#import "UnicornViewController.h"

@interface ApplicationDelegate ()
@property (strong, nonatomic) NSWindowController* windowController;
@end

@implementation ApplicationDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"");
    
    if ([[NSApplication sharedApplication] respondsToSelector:@selector(isAutomaticCustomizeTouchBarMenuItemEnabled)])
    {
        [NSApplication sharedApplication].automaticCustomizeTouchBarMenuItemEnabled = YES;
    }
    
    CGRect screen = NSScreen.mainScreen.frame;

    NSWindow *window = [[NSWindow alloc] initWithContentRect: screen
                                            styleMask: NSWindowStyleMaskBorderless
                                              backing: NSBackingStoreBuffered
                                                defer: NO];
    
    self.windowController = [[NSWindowController alloc] initWithWindow:window];
    [self.windowController showWindow:window];
    
    
    [window setBackgroundColor:[NSColor colorWithCalibratedHue:0 saturation:0 brightness:0 alpha:0.0]];
    [window setOpaque: NO];
    [window setIgnoresMouseEvents:YES];
    [window setLevel: NSFloatingWindowLevel];
    
    UnicornViewController* vc = [[UnicornViewController alloc] initWithNibName:nil bundle:nil];
    [vc becomeFirstResponder];
    vc.nextResponder = window;
    
    NSView* view = [[NSView alloc] initWithFrame:screen];
    vc.view = view;
    [view setWantsLayer:YES];
    window.contentViewController = vc;


    NSApplication *app = [notification object];
    NSMenu *appleMenu = [[NSMenu alloc] initWithTitle: @"Apple Menu"];
    [appleMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle: @"" ];
    [menuItem setSubmenu:appleMenu];
    [mainMenu addItem:menuItem];
    [app setMainMenu:mainMenu];
//    [app setAppleMenu:appleMenu];

}


@end

