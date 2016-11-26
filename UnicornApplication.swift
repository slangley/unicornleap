//
//  UnicornApplication.swift
//  unicornleap
//
//  Created by Sean Langley on 2016-11-22.
//  Copyright © 2016 Joshua Davey. All rights reserved.
//

import Cocoa

@available(OSX 10.12.1, *)
class UnicornApplication: NSApplication, NSTouchBarDelegate {
    
    let tbController = TouchBarUnicornController()

    @available(OSX 10.12.1, *)
    override func makeTouchBar() -> NSTouchBar? {
        return tbController.makeTouchBar()
    }

    
    @available(OSX 10.12.1, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        return tbController.touchBar(touchBar, makeItemForIdentifier: identifier)
    }
}
