//
//  ViewController.swift
//  RegesterAndLogin
//
//  Created by Marwa alsubhi on 12/03/1444 AH.

//Login and Rejester by Google , FaceBook , AppleID , Twitter
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore


class ViewController: UIViewController {
    
    //vars
    
    @IBOutlet weak var faceButton: FBLoginButton!
    
    //IBAction
    @IBAction func GoogleButton(_ sender: Any) {
        signUpByGoogle()
    }
    
    @IBAction func appleButton(_ sender: Any) {
    }
    
    @IBAction func twitterButton(_ sender: Any) {
    }
    
 
    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        faceButton.delegate = self
        
    }
    
    //funcions
    func signUpByGoogle(){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            print("Field to login with google", error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                  let authError = error as NSError
                  if  authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError
                      .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                      displayNameString += tmpFactorInfo.displayName ?? ""
                      displayNameString += " "
                    }
                   
                  } else {
                   // self.showMessagePrompt(error.localizedDescription)
                      print("Error to login")
                    return
                  }
                  // ...
                  return
                }
                // User is signed in
                print(" User is signed in")
                
                // go to google view controller
                goToHome()
                
                
              
            }
            
            
            
            
            
            
            
            
        }
        
    }
   
    func signUpByTwitter(){}
    func signuUPByApple(){}
 
    
    
  func goToHome(){
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "googleID") as! GoogleViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    

  


}

extension ViewController : LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        let credential = FacebookAuthProvider
          .credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { authResult, error in
            
            if let error = error {
              print("Error signing in\(error)")
            }
            
            self.goToHome()
           
        }
            
        
        
        
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
    }
    
    
}

