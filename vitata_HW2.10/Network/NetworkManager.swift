//
//  NetworkManager.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    var data: Feed!
    
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
                let cell = try decoder.decode(Feed.self, from: data)
                self.data = cell
                //print(cell)
            } catch let error {
                print("!!!error from do-catch: \(error)")
            }
            
            semaphore.signal()
            
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
    }
    
    
    
    
}

