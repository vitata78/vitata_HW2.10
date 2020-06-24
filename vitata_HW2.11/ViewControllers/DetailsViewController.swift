//
//  ViewController.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var record: Record!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData(with: record)
    }
    
    private func fillData(with selectedItem: Record) {

        title = selectedItem.item
        
        if selectedItem.description != "" {
            descriptionTextView.text = selectedItem.description
        } else {
            descriptionTextView.text = "No data"
        }
        
        
        DispatchQueue.global().async {
            
            if
                let stringURL = self.record.image,
                stringURL != "",                                        // если в ячейке ничего нет
                let imageURL = URL(string: stringURL),
                let imageData = try? Data(contentsOf: imageURL) {       // если в ячейке не адрес
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = UIImage(data: imageData)
                }
                
            } else {
                
                // если что-то пошло не так - ставим заглушку
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = UIImage(named: "Placeholder")
                }
                
            }
               
        }
    }
    

    
  
}
