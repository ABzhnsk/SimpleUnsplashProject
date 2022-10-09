//
//  DetailsViewPresenter.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 09.10.2022.
//

import Foundation

class DetailsViewPresenter {
    private let coreDataManager: CoreDataManager
    private var view: DetailsViewProtocol
    
    var model: PhotoModel
    var isHeartSelected: Bool? {
        didSet {
            showHeartButtonStateClosure?()
        }
    }
    var showHeartButtonStateClosure: (() -> Void)?

    
    init(view: DetailsViewProtocol,
         dataStorageManager: CoreDataManager,
         model: PhotoModel) {
        self.view = view
        self.coreDataManager = dataStorageManager
        self.model = model
    }
    
    func fetchButtonIsLike() {
        coreDataManager.isExistPhotoCoreData(id: model.id) { [weak self] result in
            switch result {
            case .success(let isExist):
                self?.isHeartSelected = isExist ? true : false
            case .failure(let error):
                self?.view.errorCoreData(with: error.localizedDescription)
            }
        }
    }
    func fetchLikePhoto() {
        coreDataManager.isExistPhotoCoreData(id: model.id) { [weak self] result in
            switch result {
            case .success(let isExist):
                if isExist {
                    self?.deletePhotoCoreData()
                } else {
                    self?.savePhotoCoreData()
                }
            case .failure(let error):
                self?.view.errorCoreData(with: error.localizedDescription)
            }
        }
    }
    
    private func deletePhotoCoreData() {
        coreDataManager.deletePhotoCoreData(photoViewModel: model) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.isHeartSelected = false
                }
            case .failure(let error):
                self?.view.errorCoreData(with: error.localizedDescription)
            }
        }
    }
    private func savePhotoCoreData() {
        coreDataManager.savePhotoCoreData(photoViewModel: model) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.isHeartSelected = true
                }
            case .failure(let error):
                self?.view.errorCoreData(with: error.localizedDescription)
            }
        }
    }

}
