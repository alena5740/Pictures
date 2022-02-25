//
//  Presenter.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit
import CoreData

// Протокол исходящих событий от View
protocol ViewOutputProtocol: AnyObject {
    func updateView()
}

// Протокол презентера
protocol PresenterProtocol: AnyObject {
    var pageCount: Int { get }
    func getData(page: Int)
    func getModelArray() -> [Model]
}

// Презентер
final class Presenter: PresenterProtocol {
    private let loadService: LoadServiceProtocol
    var pageCount = 0

    weak var delegatPresenter: ViewOutputProtocol?
    
    init(loadService: LoadServiceProtocol) {
        self.loadService = loadService
    }
    
    func getData(page: Int) {
        loadService.loadPhotos(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.pageCount = model.photos.pages
                let model = model.photos.photo
                for i in model {
                    let farm = i.farm ?? 0
                    let secret = i.secret ?? ""
                    let serverId = i.server ?? ""
                    let id = i.id ?? ""
                    let photoURL = "https://farm\(farm).staticflickr.com/\(serverId)/\(id)_\(secret).jpg"
                    self.saveData(title: i.title ?? "", imageURL: photoURL, id: id)
                }
                self.delegatPresenter?.updateView()
            case .failure(_):
                print("Ошибка получения данных")
            }
        }
    }
    
    private func saveData(title: String, imageURL: String, id: String) {
        guard let context = makeContextCoreData() else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Model")
        let predicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as? [Model]
        var model: Model?
        
        if fetchResults!.count == 0 {
            model = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context) as? Model
            model?.id = id
        } else {
            model = fetchResults![0]
        }
        
        model?.title = title
        model?.imageURL = imageURL
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func makeContextCoreData() -> NSManagedObjectContext? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        return context ?? nil
    }
    
    func getModelArray() -> [Model] {
        guard let context = makeContextCoreData() else { return [] }
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
  
        do {
            let model = try context.fetch(fetchRequest)
            return model
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
}
