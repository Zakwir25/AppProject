//
//  AddToysViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 19/12/23.
//

import UIKit
import CoreData

class AddToysViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var namaMainan: UITextField!
    
    
    @IBOutlet weak var hargaMainan: UITextField!
    
    
    @IBOutlet weak var imgMainan: UIImageView!
    
    
   
    
    var imagePicker = UIImagePickerController()
    var toyToEdit: Mainan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
       
    }
    
    
    
    @IBAction func addImageBtn(_ sender: Any) {
        pickImage()
    }
    
    
    
    @IBAction func addMainan(_ sender: Any) {
        saveOrUpdateMainanToCoreData()
        if let menuViewController = presentingViewController as? MenuViewController {
                menuViewController.fetchDataFromCoreData()
                menuViewController.tableView.reloadData()
            }
            
            dismiss(animated: true, completion: nil)
    }
    

    func saveOrUpdateMainanToCoreData() {
            guard let nama = namaMainan.text, !nama.isEmpty,
                  let hargaString = hargaMainan.text, let harga = Int64(hargaString) else {
                showAlert(with: "Error", message: "isi semua")
                return
            }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                showAlert(with: "Error", message: "gagal mengakses core data")
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            if let mainan = toyToEdit {
                // Update existing toy
                mainan.namaMainan = nama
                mainan.hargaMainan = harga
                mainan.image = convertImageToBase64()
            } else {
                // Create a new toy
                let newMainan = Mainan(context: context)
                newMainan.namaMainan = nama
                newMainan.hargaMainan = harga
                newMainan.image = convertImageToBase64()
            }
            
            do {
                try context.save()
                showAlert(with: "Success", message: "mainan telah tersave")
                dismiss(animated: true, completion: nil)
            } catch {
                print("Error ketika save core data: \(error)")
                showAlert(with: "Error", message: "Failed to save data. Please try again.")
            }
        }
        
        func pickImage() {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
        
        func convertImageToBase64() -> String? {
            guard let imageData = imgMainan.image?.jpegData(compressionQuality: 1.0) else {
                return nil
            }
            return imageData.base64EncodedString()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imgMainan.contentMode = .scaleAspectFit
                imgMainan.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
        func showAlert(with title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    

}
