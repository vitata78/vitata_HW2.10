//
//  NetworkManager.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//
import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var data: [Record]!
    
    private init() {}
    
    
    func getData(completion: @escaping ([Record] ,Bool) -> Void) {
        
        let jsonUrl = "https://spreadsheets.google.com/feeds/cells/1T9veABsLs19foEHDr0XkHWL7bnbr2WXzRPhLmqY1l5s/1/public/full?alt=json"
        
        AF.request(jsonUrl)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    guard let feedData = value as? [String: Any] else { return }
                    guard let contentData = feedData["feed"] as? [String: Any] else { return }
                    guard let entryData = contentData["entry"] as? [[String: Any]] else { return }
                    
                    self.data = self.processData(source: Cell.getCells(from: entryData) ?? [])
                    
                    completion(self.data, true)
                    
                case .failure(let error):
                    print(error)
                    completion([],false)
                }
        }
        
//        AF.request(jsonUrl)
//            .validate()
//            .responseDecodable(of: Feed.self) { response in
//                switch response.result {
//                case .success(let feed):
//                    self.data = self.processData(source: feed)
//                    completion(self.data, true)
//
//                case .failure(let error):
//                    print(error)
//                    completion([],false)
//                }
//        }
    }
    
    
    func processData(source: [Cell]) -> [Record] {
        var output: [Record] = []

        for entryItem in 0..<source.count {

            if source[entryItem].col == "1" && source[entryItem].row != "1" {

                var description: String = ""
                var image: String = ""

                for entryDesc in 0..<source.count {

                    if source[entryDesc].row == source[entryItem].row && source[entryDesc].col == "2" {
                        description = source[entryDesc].inputValue ?? ""
                    }

                    if source[entryDesc].row == source[entryItem].row && source[entryDesc].col == "3" {
                        image = source[entryDesc].inputValue ?? ""
                    }

                }

                let item: String = source[entryItem].inputValue ?? ""
                
                let record = Record(item: item, description: description, image: image)

                output.append(record)
            }

        }
        return output
    }
    
}

