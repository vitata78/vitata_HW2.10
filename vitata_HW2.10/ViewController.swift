//
//  ViewController.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
//    private let jsonUrl = "https://spreadsheets.google.com/feeds/cells/1T9veABsLs19foEHDr0XkHWL7bnbr2WXzRPhLmqY1l5s/1/public/full?alt=json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getData()
        // fetchData()
        print(NetworkManager.shared.data ?? 0)
        
    }
    
    @IBAction func buttonClicked() {
        print(NetworkManager.shared.data.feed?.entry?[2].gs$cell?.inputValue ?? 0)
        
    }
    
    
//
//    func fetchData() {
//
//        guard let url = URL(string: jsonUrl) else { print("!error from URL(string: jsonUrl)"); return }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error { print("!!error from URLSession.shared.dataTask: \(error)"); return }
//            guard let data = data else { return }
//
//            let decoder = JSONDecoder()
//
//            do {
//                let cell = try decoder.decode(Feed.self, from: data)
//                 print(cell)
//            } catch let error {
//                print("!!!error from do-catch: \(error)")
//            }
//
//        }.resume()
//
//
//    }
//
}
