//
//  ViewModel.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

import Foundation

final class ViewModel {
    private(set) var sections: [Section] = []
    let changeHandler = ChangeHandler<Section>()
    let change = Box<ChangeHandler<Section>.Changes?>(nil)
    var newsResponse: NewsSourcesResponse? {
        didSet {
            sections = [article].compactMap { $0 }
            change.value = changeHandler.changes(sections: sections)
        }
    }
}

extension ViewModel {
    
    struct Section: TableViewSection {
 
        let id: String
        let rows: [Row]
        let category: Category
        
        enum Category: Equatable {
            case articles(HeaderViewModel)
        }
//        let header: Header
//        let footer: Footer
//
//        enum  Header: Equatable {
//            case page(TitleModel)
//        }
//
//        enum Footer: Equatable {
//            case button(ButtonModel)
//        }
//
//        struct TitleModel: Equatable {
//            let text: String
//        }
//
//        struct ButtonModel: Equatable {
//            let title = ""
//        }
    }
    
    struct Row: TableViewRow {
        let id: String
        let category: Category
        
        enum Category: Equatable {
            
            case general(CellViewModel)
        }
    }
}

extension ViewModel {
    
    var article: Section? {
        
        guard let articles = newsResponse?.articles else {
            return nil
        }
        
        let newsRows = articles.compactMap { news -> Row? in
            guard let description = news.description else {
                return nil
            }
            let cellModel = CellViewModel(title: description)
            return Row(id: "1", category: .general(cellModel))
        }
        
        let headerModel = HeaderViewModel(title: "News")
        return Section(id: "1", rows: newsRows, category: .articles(headerModel))
    }
}
