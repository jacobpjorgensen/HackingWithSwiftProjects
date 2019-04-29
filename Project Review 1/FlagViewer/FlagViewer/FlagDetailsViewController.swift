//
//  FlagDetailsViewController.swift
//  FlagViewer
//
//  Created by Jacob Jorgensen on 4/28/19.
//  Copyright © 2019 Jacob Jorgensen. All rights reserved.
//

import UIKit


class FlagDetailsViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = imageName {
            flagImageView.image  = UIImage(named: imageToLoad)
            flagImageView.layer.borderWidth = 1
            flagImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let activityItems: [Any]
        if let imageName = imageName {
            activityItems = [image, imageName]
        } else {
            activityItems = [image]
        }
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
