//
//  NewsNetworkManager.swift
//  NewsApp
//
//  Created by Student on 4/8/22.
//

import Foundation

protocol NewsNetworkDelegate {
    func fetchNews(news: NewsModelAPI)
    func errorFetchingNews(error: Error)
}
class NewsNetworkManager {
    
    static let shared = NewsNetworkManager()
    var newsDelegate: NewsNetworkDelegate?
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
                    if let news =  self.parseJSON(data: data){
                        self.newsDelegate?.fetchNews(news: news)
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
            newsDelegate?.errorFetchingNews(error: error)
            return nil
        }
    }
}


