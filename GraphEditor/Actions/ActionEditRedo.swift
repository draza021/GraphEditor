//
//  ActionEditRedo.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/7/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class ActionEditRedo: ActionAbstract {
    override func perform() {
        SREG.commandManager.doCommand()
    }
}
