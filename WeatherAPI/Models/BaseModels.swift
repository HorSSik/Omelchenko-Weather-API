//
//  BaseModels.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class BaseModels: ObservableObject<BaseModel.PrepareBaseModel> {
    
    typealias Models = [BaseModel]
    
    private(set) var values: Models
    
    init(models: Models) {
        self.values = models
        
        super.init()
        
        self.subscribe()
    }
    
    private func subscribe() {
        self.values.forEach { [weak self] model in
            (self?.notify).do { state in
                _ = model.observer(handler: state)
            }
        }
    }
}
