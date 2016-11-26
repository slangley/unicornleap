//
//  main.m
//  Sasdfa
//
//  Created by Sean Langley on 2016-11-21.
//  Copyright © 2016 Sean Langley. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ApplicationDelegate.h"
#import "unicornleap-swift.h"
//#import "UnicornApplication.h"

int main(int argc, const char * argv[]) {
    // create an autorelease pool
    
    @autoreleasepool {
        
        // make sure the application singleton has been instantiated
        UnicornApplication * application = [UnicornApplication sharedApplication];
        
        // instantiate our application delegate
        ApplicationDelegate * applicationDelegate = [[ApplicationDelegate alloc] init];
        
        // assign our delegate to the NSApplication
        [application setDelegate:applicationDelegate];
        
        // call the run method of our application
        [application run];
        
    }
    
    // execution never gets here ..
    return 0;
}
