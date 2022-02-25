//
//  LoadService.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import Foundation

// Протокол сервиса для загрузки данных
protocol LoadServiceProtocol {
    func loadPhotos(page: Int, completion: @escaping (Result<ModelListed, Error>) -> Void)
}

// Сервис для загрузки данных
final class LoadService: LoadServiceProtocol {
    
    private let networkService = NetworkService()
    
    func loadPhotos(page: Int, completion: @escaping (Result<ModelListed, Error>) -> Void) {
        let urlString = "https://www.flickr.com/services/rest?method=flickr.interestingness.getList&api_key=ed537ed3baa944f25b0f5cabc0261ac1&per_page=20&page=\(page)&format=json&nojsoncallback=1"
        
        makeRequest(url: urlString, completion: completion)
    }
    
    private func makeRequest<T: Decodable> (url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        networkService.baseRequest(request: request, completion: completion)
    }
}
