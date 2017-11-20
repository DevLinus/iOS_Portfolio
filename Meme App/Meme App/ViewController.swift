//
//  ViewController.swift
//  Meme App
//
//  Created by Florian Middendorf on 20.11.17.
//  Copyright © 2017 Florian Middendorf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var imagePickerToolBar: UIToolbar!
    @IBOutlet weak var SharePictureToolBar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func imagePickerClick(_ sender: Any) {
    }
    
    @IBAction func takeAPictureClick(_ sender: Any) {
    }
    @IBAction func shareMemeClick(_ sender: Any) {
    }
    
}

