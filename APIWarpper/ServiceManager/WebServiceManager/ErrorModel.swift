//
//  ErrorModel.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

public class ErrorModel: Error {
    
    var messageKey: String
    var message: String {
        return ""//messageKey.localized()
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions

public extension ErrorModel {
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}

