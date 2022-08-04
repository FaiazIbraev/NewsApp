//
//  NewsModelAPI.swift
//  NewsApp
//
//  Created by Student on 4/8/22.
//

import Foundation

struct NewsModelAPI : Decodable {
    let articles : [Article]
}

struct Article: Decodable{
    let author: String?
    let title: String
    let description: String
    let content: String
    let source: Source
}

struct Source: Decodable{
    let name: String
}
