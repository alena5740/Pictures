//
//  PresenterImage.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import Foundation

// Протокол презентера экрана картинки
protocol PresenterImageProtocol {
    func getModel() -> Model
}

// Презентер экрана картинки
final class PresenterImage: PresenterImageProtocol {
    private let model: Model
    
    init(model: Model) {
        self.model = model
    }
    
    func getModel() -> Model {
        return model
    }
}
