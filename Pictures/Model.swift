//
//  Model.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import Foundation

// Модель с названием картинки
struct ModelTitle {
    var title: String
}

// Модель с ссылкой на картинку маленького размера
struct ModelSmallImage {
    var smallImageURL: String
}

// Модель с ссылкой на картинку большого размера
struct ModelLargeImage {
    var largeImageURL: String
}

// Декодируемая модель
struct ModelListed: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
    let pages: Int
}

struct Photo: Codable {
    let id: String?
    let title: String?
    let farm: Int?
    let server: String?
    let secret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case farm
        case server
        case secret
    }
}

// Декодируемая модель
struct ModelSizeListed: Codable {
    let sizes: Sizes
}

struct Sizes: Codable {
    let size: [Size]
}

struct Size: Codable {
    let label: String?
    let source: String?
}
