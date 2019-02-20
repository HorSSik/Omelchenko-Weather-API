//
//  DataBaseManager.swift
//  WeatherAPI
//
//  Created by Student on 18.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

import RealmSwift

class RealmProvider<Model: RLMModel>: DataBaseProviderType {

    typealias DataBaseObject = Model
    typealias FactoryType = () -> Realm?
    
    private let factory: FactoryType
    
    init(factory: @escaping FactoryType = { Realm.current }) {
        self.factory = factory
    }
    
    public func add(object: DataBaseObject) {
        self.write { realm in
            realm.create(DataBaseObject.self, value: object, update: true)
        }
    }
    
    public func read(key: String) -> DataBaseObject? {
        return self.factory()?.object(ofType: DataBaseObject.self, forPrimaryKey: key)
    }
    
    public func read() -> [DataBaseObject]? {
        let results = self.factory()?.objects(DataBaseObject.self)
    
        return results?.map { $0 }
    }

    private func write(action: (Realm) -> ()) {
        self.factory()?.write { realm in
            action(realm)
        }
    }
}
