//
//  ServiceRegistry.swift
//  GraphEditor
//
//  Created by Dragoslav Ignjatovic on 11/1/18.
//  Copyright © 2018 Dragoslav Ignjatovic. All rights reserved.
//

import Foundation

class ServiceRegistry {
    static let sharedInstance = ServiceRegistry()
    let model: Model
    
    private init() {
        model = Model()
    }
}
