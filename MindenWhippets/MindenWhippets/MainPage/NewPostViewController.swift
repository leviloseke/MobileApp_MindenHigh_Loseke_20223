//
//  NewPostViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/11/23.
//

import UIKit

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mainImageButton: UIButton!
    @IBOutlet weak var firstImageButton: UIButton!
    @IBOutlet weak var secondImageButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var currentButton: UIButton?
    
    var firestore: FirestoreService!
    let storage = StorageService.shared
    
    private lazy var pickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(firestore)
        print(storage)
        
        pickerController.delegate = self
        
        setUpElements()
    }
    
    func setUpElements() {
        //style the elements
        Utilities.styleTextField(titleTextField)
        Utilities.styleFilledButton(saveButton)
    }
  

    
    @IBAction func dismissKeyBoard() {
        titleTextField.endEditing(true)
    }
    
    @IBAction func setPhoto(_ sender: UIButton) {
        currentButton = sender
        present(pickerController, animated: true)
    }
    @IBAction func savePost() {
        guard let title = titleTextField.text,
        let mainImage = mainImageButton.backgroundImage(for: .normal),
        let firstImage = firstImageButton.backgroundImage(for: .normal),
        let secondImage = secondImageButton.backgroundImage(for: .normal)
        else { return }
        
        storage.bulkUpload([mainImage, firstImage, secondImage]) { [weak self] (urlPaths) in
            let photo = Photo(mainImagePath: urlPaths[0], title: title,
                              otherImagePaths: [urlPaths[1], urlPaths[2]])
            
            self?.firestore.save(photo, completion: { (result) in
                print(result)
                self?.navigationController?.popViewController(animated: true)
            })
            
        }
    }
}

    extension NewPostViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        func imagePickerControllerDidCanecel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            guard let image = info[.originalImage] as? UIImage else { return }
            currentButton!.setBackgroundImage(image, for: .normal)
            
        }
    }
