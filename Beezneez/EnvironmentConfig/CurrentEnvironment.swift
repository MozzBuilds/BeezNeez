//
//  CurrentEnvironment.swift
//  TemplateApp
//
//  Created by Colin Morrison on 23/08/2023.
//

import Foundation
import OSLog

public enum CurrentEnvironment {
    
    private static let infoDictionary: [String: Any] = {
      
        
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Property list not found for this environment")
    }
      
    return dict
    }()

    // MARK: - Base URL
    
    static let baseURLString: String = {
      
    guard let urlString = CurrentEnvironment.infoDictionary["baseURL"] as? String else {
      fatalError("Base URL has not been set in property list for this environment")
    }
      
    return urlString
    }()
}
