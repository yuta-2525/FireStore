//
//  ViewController.swift
//  FireStore
//
//  Created by 佐藤勇太 on 2021/11/26.
//

import UIKit
import Firebase
import FirebaseFirestore
import EMAlertController
import FirebaseAuth

class ViewController: UIViewController {
    
    //DataBaseの指定
    let db1 = Firestore.firestore().collection("odai").document("fL9dQMT8RUPN7Wtml342")
    
    let db2 = Firestore.firestore()

    @IBOutlet weak var textView: UITextView!
    var userName = String()
    
    @IBOutlet weak var odaiLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        //お題をロード
        loadQuestionData()
    }
    
    func loadQuestionData(){
        db1.getDocument { (snapShot, error) in
            
            if error != nil{
                return
            }
            
            let data = snapShot?.data()
            self.odaiLabel.text = data!["odaiText"] as! String

        }
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        db2.collection("Answers").document().setData(["answer":textView.text as Any,"userName":userName as Any,"postDate":Date().timeIntervalSince1970])
                    
        //アラート
        let alert = EMAlertController(icon: UIImage(named: "check"), title: "投稿完了！", message: "みんなの回答を見てみよう！")
        let doneAction = EMAlertAction(title: "OK", style: .normal)
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
        textView.text = ""
        
    }
    
    @IBAction func checkAnswer(_ sender: Any) {
        //画面遷移
        let checkVC = self.storyboard?.instantiateViewController(withIdentifier: "checkVC") as! CheckViewController
        checkVC.odaiString = odaiLabel.text!
        self.navigationController?.pushViewController(checkVC, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseeAuth = Auth.auth()
        do {
            try firebaseeAuth.signOut()
        } catch let error as NSError {
            print("エラー",error)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

