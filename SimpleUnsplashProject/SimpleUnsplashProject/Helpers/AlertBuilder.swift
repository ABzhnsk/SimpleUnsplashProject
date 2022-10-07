//
//  AlertBuilder.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import UIKit

final class AlertBuilder {
    typealias Builder = AlertBuilder
    
    private var title: String?
    private var message: String?
    private var actions: [UIAlertAction] = []
    
    func title(_ text: String) -> Builder {
        title = text
        return self
    }
    func message(_ text: String) -> Builder {
        message = text
        return self
    }
    func action(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
        actions.append(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }
    func build() -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
    func show(_ viewController: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        viewController.present(build(), animated: animated, completion: completion)
    }
}
