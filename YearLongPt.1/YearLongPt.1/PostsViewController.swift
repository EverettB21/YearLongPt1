//
//  PostsViewController.swift
//  YearLongPt.1
//
//  Created by Everett Brothers on 9/20/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class PostsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var numPosts = 0
    @IBOutlet weak var titleLabel: UILabel!
    var postDark = false
    var posts: [Post] = []
    var chk = false
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstPostImg: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chk == false {
            firstView.isHidden = true
            secondView.isHidden = true
            thirdView.isHidden = true
            chk = true
        }
        
    }
    
    func submit(image: UIImage?, text: String) {
        posts.insert(Post(image: UIImage(), text: text), at: 0)
    }
    
    func updatePosts() {
        let num = posts.count
        firstPostImg.image = posts[0].image
        firstLabel.text = posts[0].text
        firstView.isHidden = false
        if num > 1 {
            secondImg.image = posts[1].image
            secondLabel.text = posts[1].text
            secondView.isHidden = false
        }
        if num > 2 {
            thirdImg.image = posts[2].image
            thirdLabel.text = posts[2].text
            thirdView.isHidden = false
        }
        if let userTab = tabBarController?.viewControllers?[0] as? ViewController {
            userTab.post = posts[0]
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            posts[0].image = selectedImage
            updatePosts()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePicker() {
        let ip = UIImagePickerController()
        ip.delegate = self
        ip.sourceType = .photoLibrary
        self.present(ip, animated: true, completion: nil)
    }
    
    @IBAction func addPost(_ sender: Any) {
        let ac = UIAlertController(title: "Add Post", message: nil, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "Choose File", style: .default) { [weak self, weak ac] _ in
            self?.submit(image: nil, text: ac?.textFields?[0].text ?? "Post")
            self?.imagePicker()
        }
        
        ac.addTextField() {text in
            text.placeholder = "Add message"
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(button)
        present(ac, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        if postDark {
            self.view.backgroundColor = .black
            titleLabel.textColor = .white
            tabBarController?.tabBar.unselectedItemTintColor = .lightGray
            firstLabel.textColor = .white
            secondLabel.textColor = .white
            thirdLabel.textColor = .white
            firstView.backgroundColor = .black
            secondView.backgroundColor = .black
            thirdView.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
            titleLabel.textColor = .black
            tabBarController?.tabBar.unselectedItemTintColor = .darkGray
            firstLabel.textColor = .black
            secondLabel.textColor = .black
            thirdLabel.textColor = .black
            firstView.backgroundColor = .white
            secondView.backgroundColor = .white
            thirdView.backgroundColor = .white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
