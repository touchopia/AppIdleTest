//
//  main.swift
//  IdleTest
//
//  Created by Phillip Wright on 12/19/16.
//  Copyright © 2016 EnderLabs, Inc. All rights reserved.
//

import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(Application.self),
    NSStringFromClass(AppDelegate.self)
)
