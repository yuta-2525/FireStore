//
//  LoginViewController.swift
//  FireStore
//
//  Created by 佐藤勇太 on 2021/12/01.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func login(){
        
        Auth.auth().signInAnonymously { (result, error) in
            let user = result?.user
            print(user)
            print("呼ばれている")
            
            UserDefaults.standard.set(self.textField.text, forKey: "userName")
            
            //画面遷移
            let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "viewVC") as! ViewController
            
            self.navigationController?.pushViewController(viewVC, animated: true)
            
        }
    }
    

    @IBAction func done(_ sender: Any) {
        
        login()
    }
    
    
    @IBAction func send(_ sender: Any) {
    }
    

}
