//
//  SecondVC.swift
//  Example
//
//  Created by Joe Kletz on 25/09/2017.
//  Copyright © 2017 FolioReader. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    var coverImage:UIImage? = nil
    
    @IBOutlet var myImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myImageView.image = coverImage
    }

}
