
//  Copyright © 2017 Nahin Ahmed. All rights reserved.
//

import UIKit

// login:- email: try@me.com, pass: test

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let session = UserDefaults.standard
        if (session.object(forKey: "session") != nil){
            
           // loginDone()
            
        } else {
            
            loginToDo()
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let session = UserDefaults.standard
        
        if (session.object(forKey: "session") != nil){

            let dc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loggedin") as! LoggedinViewController
            
            present(dc, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        
        if (submitBtn.titleLabel?.text == "Sign Out"){
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
            
            loginToDo()
            
            return
        }
        
        let username = usernameTF.text
        let password = passwordTF.text
        
        if (username == "" || password == ""){
            return
        }
        
        doLogin(user: username!, pass: password!)
    }
    
    func doLogin(user: String, pass: String){
        
        let url = URL(string: "http://www.kaleidosblog.com/tutorial/login/api/login")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let paramToSend = "username=" + user + "&password=" + pass
        request.httpBody = paramToSend.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data else {
                return
            }
            
            let json:Any?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch{
                return
            }
            
            
            guard let server_response = json as? NSDictionary else {
                return
            }
            
            if let data_block = server_response["data"] as? NSDictionary {
                if let session_data = data_block["session"] as? String {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async (
                        execute:self.loginDone
                    )
                }
            }
            
        })
        
        task.resume()
        
    }
    
    
    func loginToDo(){
        
        usernameTF.isEnabled = true
        passwordTF.isEnabled = true
        
        submitBtn.setTitle("Login", for: .normal)
        
    }
    
    func loginDone(){
        
        //usernameTF.isEnabled = false
        //passwordTF.isEnabled = false
        
        //submitBtn.setTitle("Sign Out", for: .normal)
        
        let dc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loggedin") as! LoggedinViewController
        
        present(dc, animated: true, completion: nil)
        
    }

}

