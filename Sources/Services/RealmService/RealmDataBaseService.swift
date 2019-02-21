//
//  RealmDataBaseService.swift
//  WeatherAPI
//
//  Created by Student on 21.02.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class RealmDataBaseServise<StorageType: RLMModel>: DataBaseServiseType
    where StorageType: RealmModel
{
    
    typealias Model = StorageType.ConvertableType
    typealias Storage = StorageType
    
    public let provider: RealmProvider<Storage>
    
    init(provider: RealmProvider<Storage>) {
        self.provider = provider
    }
    
    func add(object: Model) {
        self.provider.add § Storage.init § object
    }
    
    open func read(id: ID) -> Model? {
        return self.provider.read(key: createKey(id: id, Storage.self))?.object()
    }
    
    open func read() -> [Model]? {
        return self.provider.read()?.compactMap { $0.object() }
    }
}
