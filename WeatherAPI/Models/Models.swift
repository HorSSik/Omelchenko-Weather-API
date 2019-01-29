//
//  BaseModels.swift
//  WeatherAPI
//
//  Created by Student on 29.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import Foundation

class Models: ObservableObject<Model.PrepareModel> {
    
    typealias BaseModels = [Model]
    
    private(set) var values: BaseModels
    
    init(models: BaseModels) {
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
