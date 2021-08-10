//
//  NewsServices.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

import Foundation

final class NewsServices {
    func getNews(category: String?, completion: @escaping(Swift.Result<NewsSourcesResponse, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: NewsRequestModel()) { (result) in
            completion(result)
        }
    }
}
