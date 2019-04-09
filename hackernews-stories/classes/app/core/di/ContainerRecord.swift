//
//  ContainerRecord.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

enum ContainerRecord {
    case instance(Any)
    case recipe(() -> Any)
    
    func unwrap() -> Any {
        switch self {
        case .instance(let instance):
            return instance
        case .recipe(let recipe):
            return recipe()
        }
    }
    
}
