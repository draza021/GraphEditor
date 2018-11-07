//
//  MainViewController.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 10/30/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - Actions
extension MainViewController {
    @IBAction func undoAction(_ sender: UIBarButtonItem) {
        print("undoAction tapped")
        SREG.actionManager.undoAction().perform()
    }
    
    @IBAction func redoAction(_ sender: UIBarButtonItem) {
        print("redoAction tapped")
        SREG.actionManager.redoAction().perform()
    }
}



