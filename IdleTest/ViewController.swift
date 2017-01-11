//
//  ViewController.swift
//  IdleTest
//
//  Created by Phillip Wright on 12/16/16.
//  Copyright © 2016 EnderLabs, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SessionCenter.sharedCenter.setup()
    }
}

