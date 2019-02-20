//
//  Realm+Extensions.swift
//  WeatherAPI
//
//  Created by Student on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

extension Realm {
    
    private struct Key {
        static let realm = "com.realm.thread.key"
    }
    
    public static var current: Realm? {
        let key = Key.realm
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? call {
                (try? Realm()).flatMap(
                    sideEffect { thread.threadDictionary[key] = WeakBox($0) }
                )
            }
    }
    
    public func write(action: (Realm) -> ()) {
        if self.isInWriteTransaction {
            action(self)
        } else {
            try? self.write { action(self) }
        }
    }
    
    public static func write(action: (Realm) -> ()) {
        self.current.do { $0.write(action: action) }
    }
}
