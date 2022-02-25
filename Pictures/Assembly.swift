//
//  Assembly.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Протокол сборщика модуля картинки в большом размере
protocol AssemblyProtocol: AnyObject {
    func pushToViewControllerImage(model: Model) -> UIViewController
}

// Сборщик модуля картинки в большом размере
final class Assembly: AssemblyProtocol {

    func pushToViewControllerImage(model: Model) -> UIViewController {
        let presenter = PresenterImage(model: model)
        let viewController = ImageViewController()
        viewController.presenter = presenter
        
        return viewController
    }
}
