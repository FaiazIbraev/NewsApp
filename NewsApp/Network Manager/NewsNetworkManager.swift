//
//  NewsNetworkManager.swift
//  NewsApp
//
//  Created by Student on 4/8/22.
//

import Foundation
import SwiftyJSON


class NewsNetworkManager {
    static let shared = NewsNetworkManager()
    
    let mainUrl = "https://newsapi.org/v2/everything?apiKey=40becfa582e942ec840433582a453eed&sortBy=popularity"
    
    func getNews(keyWord: String, language: String){
        let urlString = "\(mainUrl)&q=\(keyWord)&language=\(language)"
        createRequest(urlString: urlString)
    }
    
    func createRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respons, error) in
                if let data = data {
                    let json = JSON(data)
                    if let news =  self.parseJSON(data: data){
                        self.newsDelegate?.fetchNews(news)
                    }
                   
                   
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> NewsModelAPI?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsModelAPI.self, from: data)
            return decodedData
        }catch{
            print(error)
            return nil
        }
    }
}


