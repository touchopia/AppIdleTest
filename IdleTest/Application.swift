//
//  Application.swift
//  IdleTest
//
//  Created by Phillip Wright on 12/19/16.
//  Copyright © 2016 EnderLabs, Inc. All rights reserved.
//


import UIKit

public let ApplicationTouchDidBeginNotification = "ApplicationTouchDidBeginNotification"
public let ApplicationTouchDidMoveNotification = "ApplicationTouchDidMoveNotification"
public let ApplicationTouchDidEndNotification = "ApplicationTouchDidEndNotification"
public let ApplicationTouchDidCancelNotification = "ApplicationTouchDidCancelNotification"

public let ApplicationTouchKey = "ApplicationTouchKey"

open class Application: UIApplication {
    open static let touchDidBeginNotification = ApplicationTouchDidBeginNotification
    open static let touchDidMoveNotification = ApplicationTouchDidMoveNotification
    open static let touchDidEndNotification = ApplicationTouchDidEndNotification
    open static let touchDidCancelNotification = ApplicationTouchDidCancelNotification
    
    open static let touchKey = ApplicationTouchKey
    
    open override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if event.type == .touches {
            if let touches = event.allTouches {
                for touch in touches {
                    let userInfo = [ ApplicationTouchKey : touch ]
                    
                    if touch.phase == .began {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: ApplicationTouchDidBeginNotification), object: self, userInfo: userInfo)
                    } else if touch.phase == .moved {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: ApplicationTouchDidMoveNotification), object: self, userInfo: userInfo)
                    } else if touch.phase == .ended {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: ApplicationTouchDidEndNotification), object: self, userInfo: userInfo)
                    } else if touch.phase == .cancelled {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: ApplicationTouchDidCancelNotification), object: self, userInfo: userInfo)
                    }
                }
            }
        }
    }
}
