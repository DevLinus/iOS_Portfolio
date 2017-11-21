//
//  ViewController.swift
//  Meme App
//
//  Created by Florian Middendorf on 20.11.17.
//  Copyright © 2017 Florian Middendorf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    
    let textViewDelegate = TextFieldDelegate()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // image.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
      //  topEditField.delegate =  textViewDelegate
        //bottomEditField.delegate = textViewDelegate
       // topEditField.defaultTextAttributes = memeTextAttributes
     //   bottomEditField.defaultTextAttributes = memeTextAttributes
        subscribeToKeyboardNotifications()
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboarWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    
    @IBAction func imagePickerClick(_ sender: Any) {
        
    }
    
    @IBAction func takeAPictureClick(_ sender: Any) {
    }
    @IBAction func shareMemeClick(_ sender: Any) {
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}

