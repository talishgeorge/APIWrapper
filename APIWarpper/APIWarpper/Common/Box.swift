//
//  Box.swift
//  APIWarpper
//
//  Created by Talish George on 10/08/21.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listner: Listener?
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(fire: Bool = true, listner: Listener?) {
        self.listner = listner
        if fire {
            print(value)
            listner?(value)
        }
    }
}

