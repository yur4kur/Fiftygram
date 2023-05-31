//
//  ViewController.swift
//  Fiftygram
//
//  Created by Юрий Куринной on 13.09.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let context = CIContext()
    var original: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }
    
    @IBAction func applyNoir(){
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    @IBAction func applyVintage(){
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    func display(filter: CIFilter) {
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let result = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(result!, from: result!.extent)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
}

