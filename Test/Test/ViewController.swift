//
//  ViewController.swift
//  Test
//
//  Created by Ilias Alexopoulos on 07/09/2016.
//  Copyright © 2016 WorkAngel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewTest: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonSelected(sender: UIButton) {
        imageViewTest.backgroundColor = UIColor.blackColor();
    }

}

