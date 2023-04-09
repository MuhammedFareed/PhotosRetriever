//
//  Storyboardable.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol Storyboardable: UIViewController {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var storyboardIdentifier: String { get }
}

extension Storyboardable {
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardBundle: Bundle {
        return .main
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    static func instantiate() -> Self {
        let viewController =
        UIStoryboard(name: storyboardName, bundle: storyboardBundle)
            .instantiateViewController(identifier: storyboardIdentifier) { coder in
                return Self(coder: coder)
            }
        
        return viewController
    }
}
