//
//  TouchBarUnicornController.swift
//  unicornleap
//
//  Created by Sean Langley on 2016-11-23.
//  Copyright © 2016 Joshua Davey. All rights reserved.
//

import Cocoa

extension NSTouchBarCustomizationIdentifier {
    
    static let unicornTouchBar = NSTouchBarCustomizationIdentifier("com.popcornlabs.unicorn")
}

extension NSTouchBarItemIdentifier {
    static let unicorn = NSTouchBarItemIdentifier("unicorn")
}


@available(OSX 10.12.1, *)
class TouchBarUnicornController: NSObject, NSTouchBarDelegate, NSTouchBarProvider, CAAnimationDelegate {
    
    public var touchBar: NSTouchBar?

    @available(OSX 10.12.1, *)
    func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = NSTouchBarCustomizationIdentifier.unicornTouchBar
        touchBar.defaultItemIdentifiers = [.unicorn]
        touchBar.customizationAllowedItemIdentifiers = [.unicorn]
        
        return touchBar
        
    }
    
    @available(OSX 10.12.1, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        let touchBarItem = NSCustomTouchBarItem(identifier: identifier)
        let viewController = TinyUnicornViewController(nibName: nil, bundle: nil)
        
        let aView = NSView(frame: CGRect(x: 0, y: 0, width: 1185, height: 30))
        viewController?.view = aView
        touchBarItem.viewController = viewController
        
        return touchBarItem
    }
    
}
