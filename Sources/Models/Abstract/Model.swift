//
//  Model.swift
//  WeatherAPI
//
//  Created by Student on 14.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

public class Model<Storage: RLMModel> {
    
    public typealias StorageType = Storage
    
    public static func instantiate(storage: StorageType) -> Self {
        return self.init(id: storage.id)
    }
    
    public var storage: StorageType {
        let id = self.id
        
        return Realm.current?.object(ofType: StorageType.self, forPrimaryKey: self.id)
            ?? modify(StorageType()) { storage in
                storage.id = id
                Realm.write { $0.add(storage, update: true) }
            }
    }
    
    private var isInWriteTransaction = false
    private var isInReadTransaction = false
    
    public let id: String
    
    private let lock: NSLocking = NSRecursiveLock()
    
    public required init(id: String) {
        self.id = id
        
        self.configure()
    }
    
    public func read() {
        self.performStorageTransaction(
            exclusing: { self.isInWriteTransaction },
            condition: { self.isInReadTransaction = $0 },
            action: { self.readStorage(self.storage) }
        )
    }
    
    public func write() {
        self.update {
            self.writeStorage(self.storage)
        }
    }
    
    public func update(action: () -> ()) {
        self.performStorageTransaction(
            exclusing: { self.isInReadTransaction },
            condition: { self.isInWriteTransaction = $0 },
            action: {
                Realm.write { _ in
                    action()
                }
            }
        )
    }
    
    open func configure() {
        self.read()
    }
    
    open func writeStorage(_ storage: StorageType) {
        
    }
    
    open func readStorage(_ storage: StorageType) {
        
    }
    
    private func locked(action: () -> ()) {
        self.lock.locked(action: action)
    }
    
    private func performStorageTransaction(
        exclusing: () -> Bool,
        condition: (Bool) -> (),
        action: () -> ()
    ) {
        self.locked {
            if exclusing() {
                return
            }
            
            condition(true)
            action()
            condition(false)
        }
    }
}
