//
//  ViewController.swift
//  instaClone
//
//  Created by Jake Shapiro on 6/1/20.
//  Copyright © 2020 Jake Shapiro. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var uploadedImageView: UIImageView!
    
    @IBAction func uploadImage(_ sender: Any) {
        let ourImagePicker = UIImagePickerController()
        ourImagePicker.delegate = self
        ourImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        ourImagePicker.allowsEditing = false
        self.present(ourImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadedImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        // saving comment object with parse server
        let comment = PFObject(className: "Comment")
        comment["user"] = "jbob22"
        comment["body"] = "poo the poopoo head"
        comment.saveInBackground { (suc, error) in
            if suc {
                print ("comment sent")
            } else {
                print("comment failed to send")
            }
        }
        
        // set up a query
        let query = PFQuery(className: "Comment")
        query.getObjectInBackground(withId: "gA8ZkY9mVg") { (pfObj, error) in
            if let comment = pfObj {
                print("comment received, it says... \(comment["body"] ?? "")")
            } else {
                print("comment not received")
            }
        }
        
    }


}

