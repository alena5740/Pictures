//
//  TableViewCell.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Ячейка с информацией по картинке
final class TableViewCell: UITableViewCell {
    private let image = UIImageView()
    private let imageInfo = UILabel()
    
    static let reuseIdentifier = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupImage()
        setupImageInfo()
    }
    
    private func makeConstraintsImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 134),
            image.heightAnchor.constraint(equalToConstant: 134)
        ])
    }
    
    private func setupImage() {
        contentView.addSubview(image)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        makeConstraintsImage()
    }
    
    private func makeConstraintsImageInfo() {
        imageInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 166),
            imageInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            imageInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupImageInfo() {
        imageInfo.textColor = .black
        contentView.addSubview(imageInfo)
        imageInfo.numberOfLines = 0
        makeConstraintsImageInfo()
    }
    
    override func prepareForReuse() {
        image.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Model) {
        image.loadImageWithUrl(urlString: model.imageURL ?? "")
        imageInfo.text = model.title
    }
}
