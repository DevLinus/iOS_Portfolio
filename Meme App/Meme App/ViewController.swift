import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var imagePickerButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var takeAPictureButton: UIBarButtonItem!
    let textViewDelegate = TextFieldDelegate()
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        memeImageView.image = UIImage()
        shareButton.isEnabled = false
    }
    
    func setUPTextField (textField : UITextField){
        textField.delegate = textViewDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    
    fileprivate func setUpToolbarsWithSpaceHolder() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        topToolBar.items = [shareButton, space, cancelButton]
        bottomToolBar.items = [space,takeAPictureButton,space, imagePickerButton, space]
    }
    
    fileprivate func setPictureAndShareButtonEnabled() {
        takeAPictureButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        if memeImageView.image == nil {
            shareButton.isEnabled = false
        }
    }
    
    fileprivate func SetupGUI() {
        setUPTextField(textField: topTextField)
        setUPTextField(textField: bottomTextField)
        setPictureAndShareButtonEnabled()
        setUpToolbarsWithSpaceHolder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetupGUI()
        
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
        excecutePickerControler(sourceType: .photoLibrary)
    }

    
    fileprivate func excecutePickerControler(sourceType : UIImagePickerControllerSourceType ) {
        let picController = UIImagePickerController()
        picController.delegate = self
        picController.sourceType = sourceType
        present(picController, animated: true, completion: nil)
    }
    
    
    @IBAction func takeAPictureClick(_ sender: Any) {
        excecutePickerControler(sourceType: .camera)
    }
    @IBAction func shareMemeClick(_ sender: Any) {
        let memeDataHolder = memeStorage(oldImage: memeImageView.image!, newImage: generateMemedImage(), textTopTextField: topTextField.text!, textBottomTextField: bottomTextField.text!)
    
        let imageToShare = [memeDataHolder.newImage]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func updateVisibiltyOfToolBars(){
        topToolBar.isHidden = !topToolBar.isHidden
        bottomToolBar.isHidden = !bottomToolBar.isHidden
    }
    
    func generateMemedImage() -> UIImage {
        updateVisibiltyOfToolBars()
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        updateVisibiltyOfToolBars()
        return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.contentMode = .scaleAspectFill
            memeImageView.image = UIImage.scaleImageToSize(imgage: image,size: memeImageView.frame.size)// size: CGSize(width: 343, height: 505))
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled = true
        }
    }
    
    
}

