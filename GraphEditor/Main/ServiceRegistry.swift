//
//  ServiceRegistry.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class ServiceRegistry {
    let model: Model
    let context: Context
    let selection: SelectionModel
    let commandManager: CommandManager
    
    init() {
        model = Model()
        context = Context()
        selection = SelectionModel()
        commandManager = CommandManager()
    }
}
