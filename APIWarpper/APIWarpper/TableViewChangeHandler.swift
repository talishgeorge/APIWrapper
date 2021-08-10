//
//  TableViewChangeHandler.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

import Foundation
import UIKit

protocol TableViewRow: Equatable {
    associatedtype identifier: Equatable
    var id: identifier { get }
}

protocol TableViewSection: Equatable {
    associatedtype Row: TableViewRow
    associatedtype Identifier: Equatable
    
    var id: Identifier { get }
    var rows: [Row] { get }
}

struct HeaderViewModel: Equatable {
    let title: String
}

struct CellViewModel: Equatable {
    let title: String
}
