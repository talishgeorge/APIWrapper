//
//  ChangeHandler.swift
//  APIWarpper
//
//  Created by Talish George on 27/07/21.
//

import Foundation

class ChangeHandler<Section: TableViewSection> {
    private var previousSections: [Section] = []
    struct  Changes {
        let addedSections: IndexSet
        
        var hasChanges: Bool {
            return !addedSections.isEmpty
        }
    }
    
    func changes(sections: [Section]) -> Changes {
        let changes = Changes(addedSections: sectionsToInsert(sections: sections))
     
        previousSections = sections
        return changes
    }
    
    private func sectionsToInsert(sections: [Section]) -> IndexSet {
        IndexSet(sections.enumerated().compactMap { (offset: Int, element: Section) -> Int? in
            previousSections.filter({ $0.id == element.id}).isEmpty ? offset :nil
        })
    }
}
