//
//  RegisterViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    @IBOutlet weak var foremanCode: UITextField!
    
    
    @IBOutlet weak var Scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        // dismisses keyboard when tapped away from the keyboard
        self.hideKeyboardWhenTapped()
        
        Scroll.contentSize.height = 900
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func RegisterButtonTouched(sender: AnyObject) {
        
        // check of all fields are filled out
        if (FirstNameTextField.text!.isEmpty || LastNameTextField.text!.isEmpty || EmailTextField.text!.isEmpty || PasswordTextField.text!.isEmpty || ConfirmPasswordTextField.text!.isEmpty) {
            
            let alertController = UIAlertController(title: "Go back!", message: "Please fill out the missing fields", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    
        // check if passwords match
        else if(PasswordTextField.text != ConfirmPasswordTextField.text) {
            
            let alertController = UIAlertController(title: "Go back!", message: "Passwords do not match", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            }
        

        else {
            
            let alertController = UIAlertController(title: "Thumbs up!", message: "Registration was successful", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/insert.php")!)
        request.HTTPMethod = "Post"
        let postString = "FirstName=\(FirstNameTextField.text!)&LastName=\(LastNameTextField.text!)&Email=\(EmailTextField.text!)&Password=\(PasswordTextField.text!)&ConfirmPassWord=\(ConfirmPasswordTextField.text!)&Foreman=\(foremanCode.text!)"
        
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response=\(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString=\(responseString)")
            
        }
        
            task.resume()
        
        } // end else
    
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}  // end view controller classs
