//
//  CommandManager.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/7/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class CommandManager {
    var commands: [Command]
    var currentCommandIndex: Int
    var count: Int {
        return commands.count
    }
    
    init() {
        commands = [Command]()
        currentCommandIndex = 0
    }
    
    func addCommand(command: Command) {
        while currentCommandIndex < commands.count {
            commands.remove(at: currentCommandIndex)
        }
        commands.append(command)
        doCommand()
    }
    
    private func doCommand() {
        if currentCommandIndex < commands.count {
            commands[currentCommandIndex].doCommand()
            currentCommandIndex += 1
            commands.forEach({ print("commands ->", $0) })
            print("currentCommandIndex -> ", currentCommandIndex)
        }
    }
    
    private func undoCommand() {
        if currentCommandIndex > 0 {
            currentCommandIndex -= 1
            commands[currentCommandIndex].undoCommand()
        }
    }
    
    private func currentCommandIsFirst() -> Bool {
        return currentCommandIndex == 0
    }
    
    private func currentCommandIsLast() -> Bool {
        return currentCommandIndex == commands.count
    }
    
    private func isEmpty() -> Bool {
        return commands.count == 0
    }
}
