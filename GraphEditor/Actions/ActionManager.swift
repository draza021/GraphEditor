//
//  ActionManager.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/7/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class ActionManager {
    func undoAction() -> ActionEditUndo {
        return ActionEditUndo()
    }
    
    func redoAction() -> ActionEditRedo {
        return ActionEditRedo()
    }
}
