//
//  LogInViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true
        // Do any additional setup after loading the view.
        
         self.hideKeyboardWhenTapped()
    
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
    
    
    @IBAction func LoginPressed(sender: AnyObject) {
        
        // check for blank fields
        if(userEmailTextField.text!.isEmpty || userPasswordTextField.text!.isEmpty) {
            
            let alertController = UIAlertController(title: "Go back!", message: "Please fill all fields", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/checkUserLogin.php")!)
        
        request.HTTPMethod = "Post"
        
        let loginCreds = "Email=\(userEmailTextField.text!)&Password=\(userPasswordTextField.text!)"
        
        request.HTTPBody = loginCreds.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            //print("response=\(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            // take to forman page
            if(responseString!.isEqual("you are a foreman")) {
            
               
                NSOperationQueue.mainQueue().addOperationWithBlock{
                self.performSegueWithIdentifier("ForemanSegue", sender: nil)
                
                }

            
            }
            // take to worker page
            else if(responseString!.isEqual("you are a worker")) {
                
                NSOperationQueue.mainQueue().addOperationWithBlock{
                self.performSegueWithIdentifier("WorkerSegue", sender: nil)
                }
                
                
            }
            
            // display error, user not in the system
            else if(responseString!.isEqual("not in the system")) {
            
                NSOperationQueue.mainQueue().addOperationWithBlock{
                let alertController = UIAlertController(title: "Sorry!", message: "The combination of the user email and password are incorrect", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                    self.presentViewController(alertController, animated: true, completion: nil)
                
                }
            }
          
        }
        
        task.resume()
        
            
    }
 
    
    
    
 // end login Pressed
    
    

}





