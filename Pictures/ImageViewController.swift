//
//  ImageViewController.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Контроллер для отображения картинки в большом размере
final class ImageViewController: UIViewController {
    
    var presenter: PresenterImageProtocol?
    
    override func loadView() {
        let imageView = ImageView()
        guard let model = presenter?.getModel() else { return }
        imageView.configure(title: model.title ?? "", imageURL: model.imageURL ?? "")
        view = imageView
    }
}
