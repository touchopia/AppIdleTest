//
//  SessionCenter.swift
//  IdleTest
//
//  Created by Phillip Wright on 12/16/16.
//  Copyright © 2016 EnderLabs, Inc. All rights reserved.
//

import UIKit

public class SessionCenter: NSObject {
    static let sharedCenter = SessionCenter()
    private override init() {}
    
    fileprivate var idleTimer : Timer?
    fileprivate var absoluteStartTime: Date?
    fileprivate var startTime: Date?
    fileprivate var endTime: Date?
    fileprivate let idleTimerMaxDuration: TimeInterval = 10.0
    fileprivate var timerIsActive = false
    fileprivate var initialSetupCompleted = false
    fileprivate var elapsedTime: TimeInterval = 0
    public var sessionUUID: UUID?
    
    fileprivate var elapsedTimeString : String {
        return String(format: "+ %2.2f seconds", elapsedTime)
    }

    public func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(SessionCenter.touchDidBegin(notify:)), name: NSNotification.Name(rawValue: ApplicationTouchDidBeginNotification), object: nil)
        timerIsActive = false
        initialSetupCompleted = true
    }
    
    @objc private func touchDidBegin(notify: NSNotification) {
        if self.timerIsActive == false {
            startSession()
            print("Session Started - T-minus \(idleTimerMaxDuration)")
        } else {
            endTime = Date()
            elapsedTime = elapsedTime + calcElapsedTime()
            extendSession()
        }
    }
    
    @objc private func idleTimerTriggered(timer: Timer) {
        self.endSession()
    }
    
    func calcElapsedTime() -> TimeInterval {
        if let startTime = startTime, let endTime = endTime {
            return endTime.timeIntervalSince(startTime)
        }
        return 0
    }
    
    private func startSession() {
        if(initialSetupCompleted == false) { setup() }
        self.timerIsActive = true
        startTime = Date()
        endTime = nil
        
        if absoluteStartTime == nil {
            sessionUUID = UUID() // only create one session uuid
            absoluteStartTime = startTime
        }
        
        // restart timer
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(timeInterval: idleTimerMaxDuration, target: self, selector: #selector(idleTimerTriggered(timer:)), userInfo: nil, repeats: false)
    }
    
    @objc private func endSession() {
        endTime = Date()
        elapsedTime = elapsedTime + calcElapsedTime()
        
        print("\n\nSession Ended: Total elapsedTime: \(elapsedTimeString)")
        
        if let absoluteStartTime = absoluteStartTime, let endTime = endTime, let sessionUUID = sessionUUID {
            print("Session UUID: \(sessionUUID)")
            print("Start Date: \(absoluteStartTime), \nEnd Date: \(endTime)\n")
        }
        
        clearSession()
    }
    
    @objc private func clearSession() {
        idleTimer?.invalidate()
        idleTimer = nil
        sessionUUID = nil
        elapsedTime = 0
        absoluteStartTime = nil
        startTime = nil
        endTime = nil
        timerIsActive = false
    }
    
    private func extendSession() {
        startSession()
        print("Session Extended \(idleTimerMaxDuration) \(elapsedTimeString)")
    }

    
    
}
