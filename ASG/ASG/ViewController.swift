//
//  ViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 18/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "Logo")
        Logo.image = image
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Btn(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
}

