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
    
    var selectedItem: Record!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData(with: selectedItem)
        
    }
    
    
    
    private func fillData(with selectedItem: Record) {

        descriptionTextView.text = selectedItem.description
        title = selectedItem.item
        
        DispatchQueue.global().async {
            guard let stringURL = self.selectedItem.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    

    
  
}
