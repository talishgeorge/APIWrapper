//
//  NewsRequestModel.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

import Foundation

// API Request Model
final class NewsRequestModel: RequestModel {
    override var path: String {
        return ApiConstants.news
    }
}
