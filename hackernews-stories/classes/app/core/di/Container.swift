//
//  Container.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

struct Container {
    
    private lazy var services: Dictionary<String, ContainerRecord> = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    mutating func addService<T>(recipe: @escaping () -> T) {
        let key = typeName(some: T.self)
        services[key] = .recipe(recipe)
    }
    
    mutating func addService<T>(instance: T) {
        let key = typeName(some: T.self)
        services[key] = .instance(instance)
    }
    
    mutating func getService<T>() -> T? {
        let key = typeName(some: T.self)
        guard let serviceRecord = services[key] else { return nil }
        let instance: T? = serviceRecord.unwrap() as? T
        
        switch serviceRecord {
        case .recipe:
            if let instance = instance {
                addService(instance: instance)
            }
        default:
            break
        }
        
        return instance
    }
    
}
