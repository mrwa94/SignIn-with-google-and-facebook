//
//  GoogleViewController.swift
//  RegesterAndLogin
//
//  Created by Ayman alsubhi on 12/03/1444 AH.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class GoogleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Logout
    
    @IBAction func logOutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        let controller = storyboard?.instantiateViewController(withIdentifier: "homeID") as! ViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        print("Successful to logout from google account")
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
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
