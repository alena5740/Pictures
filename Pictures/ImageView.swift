//
//  ImageView.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Вью экрана картинки в большом размере
final class ImageView: UIView {
    private let image = UIImageView()
    private let imageInfo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImage()
        setupImageInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        self.addSubview(image)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        makeConstraintsImage()
    }
    
    private func makeConstraintsImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height / 8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            image.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32) * 1.33)
        ])
    }
    
    private func setupImageInfo() {
        self.addSubview(imageInfo)
        imageInfo.textAlignment = .center
        imageInfo.numberOfLines = 0
        imageInfo.textColor = .black
        makeConstraintsImageInfo()
    }
    
    private func makeConstraintsImageInfo() {
        imageInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageInfo.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            imageInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageInfo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            imageInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32)
        ])
    }
    
    func configure(title: String, imageURL: String) {
        image.loadImageWithUrl(urlString: imageURL)
        imageInfo.text = title
    }
}
