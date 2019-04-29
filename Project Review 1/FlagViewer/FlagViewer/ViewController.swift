//
//  ViewController.swift
//  FlagViewer
//
//  Created by Jacob Jorgensen on 4/28/19.
//  Copyright © 2019 Jacob Jorgensen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }
    
    private func loadImages() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let countryName = flags[indexPath.row].replacingOccurrences(of: ".png", with: "")
        cell.textLabel?.text = countryName.uppercased()
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? FlagDetailsViewController {
            let imageName = flags[indexPath.row]
            let imageNameWithoutPrefix = imageName.replacingOccurrences(of: ".png", with: "")
            let countryName = imageNameWithoutPrefix.uppercased()
            vc.imageName = imageName
            vc.title = countryName.uppercased()
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

