//
//  NetworkManager.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    var data: [Record]!
    
    private init() {}
    
    func getData() {

        let jsonUrl = "https://spreadsheets.google.com/feeds/cells/1T9veABsLs19foEHDr0XkHWL7bnbr2WXzRPhLmqY1l5s/1/public/full?alt=json"
        
        guard let url = URL(string: jsonUrl) else { return }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print("!!error from URLSession.shared.dataTask: \(error)"); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let data = try decoder.decode(Feed.self, from: data)
                self.data = self.processData(source: data)
                //print(cell)
            } catch let error {
                print("!!!error from do-catch: \(error)")
            }
            
            semaphore.signal()
            
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture) // дожидаемся загрузку данных
        
    }
    
    
    func processData(source: Feed) -> [Record] {
        var output: [Record] = []
        
        for entryItem in 0..<(source.feed?.entry?.count ?? 0) {
            
            if source.feed?.entry?[entryItem].gs$cell?.col == "1" && source.feed?.entry?[entryItem].gs$cell?.row != "1" {
                
                var description: String = ""
                var image: String = ""
                
                for entryDesc in 0..<(source.feed?.entry?.count ?? 0) {
                    
                    if source.feed?.entry?[entryDesc].gs$cell?.row == source.feed?.entry?[entryItem].gs$cell?.row && source.feed?.entry?[entryDesc].gs$cell?.col == "2" {
                        description = source.feed?.entry?[entryDesc].gs$cell?.inputValue ?? ""
                        
                    }
                    
                    if source.feed?.entry?[entryDesc].gs$cell?.row == source.feed?.entry?[entryItem].gs$cell?.row && source.feed?.entry?[entryDesc].gs$cell?.col == "3" {
                        image = source.feed?.entry?[entryDesc].gs$cell?.inputValue ?? ""
                        
                    }
                    
                }
                
                let item: String = source.feed?.entry?[entryItem].gs$cell?.inputValue ?? ""
                
                let record = Record(item: item, description: description, image: image)
                
                output.append(record)
            }
            
        }
        return output
    }
    
}

