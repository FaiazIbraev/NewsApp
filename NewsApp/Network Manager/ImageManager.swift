//
//  ImageManager.swift
//  NewsApp
//
//  Created by Student on 6/8/22.
//

import Foundation
class ImageManager{
    static let shared = ImageManager()
    
    func createRequest(urlString: String, completion: ((Data) -> Void)?){
        let url = URL (string: urlString)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    completion!(data)
                    print("Image Data: \(data)")
                }
            }
            task.resume()
        }
    }
    
    
}
