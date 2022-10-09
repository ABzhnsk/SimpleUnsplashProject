//
//  DataStorageManager.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import CoreData

open class CoreDataManager {
    //MARK: - CoreData
    public static let modelName = "SimpleUnsplashDB"
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    public init() {}

    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.modelName,
                                              managedObjectModel: CoreDataManager.model)
        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
        return container
      }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: - CRUD
    func fetchPhotoCoreData(completion: (Result<[FavouritePhoto], Error>) -> Void) {
        let request = FavouritePhoto.fetchRequest()
        let dateOrder = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateOrder]
        do {
            let fetchResult = try context.fetch(request)
            completion(.success(fetchResult))
        } catch {
            completion(.failure(error))
        }
    }
    func savePhotoCoreData(photoViewModel: PhotoModel, completion: (Result<Bool, Error>) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: "FavouritePhoto", in: context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(photoViewModel.downloads, forKey: "downloads")
            managedObject.setValue(photoViewModel.createdAt, forKey: "createdAt")
            managedObject.setValue(photoViewModel.imageUrl, forKey: "imageUrl")
            managedObject.setValue(photoViewModel.userLocation, forKey: "userLocation")
            managedObject.setValue(photoViewModel.userName, forKey: "userName")
            managedObject.setValue(photoViewModel.id, forKey: "id")
            do {
                try context.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
    func deletePhotoCoreData(photoViewModel: PhotoModel, completion: (Result<Bool, Error>) -> Void) {
        let id = photoViewModel.id
        let request = FavouritePhoto.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        do {
            let fetchResult = try context.fetch(request)
            if let targetPhotoEntity = fetchResult.first {
                context.delete(targetPhotoEntity)
                do {
                    try context.save()
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    func isExistPhotoCoreData(id: String, completion: (Result<Bool, Error>) -> Void) {
        let request = FavouritePhoto.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        do {
            let fetchResult = try context.fetch(request)
            if !fetchResult.isEmpty {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
