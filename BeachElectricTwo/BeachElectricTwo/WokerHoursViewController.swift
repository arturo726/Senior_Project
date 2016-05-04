//
//  WokerHoursViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit


class WokerHoursViewController: UIViewController {
    
    
    @IBOutlet weak var autoJobType: UILabel!
    @IBOutlet weak var hoursEnteredTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // dismisses keyboard from view when tapped away
         self.hideKeyboardWhenTapped()
        
        // activity indicator wheel while job type is loaded
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
        UIActivityIndicatorViewStyle.WhiteLarge)
        
        activityIndicator.color = UIColor.blackColor()
        activityIndicator.center = view.center;
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        
        
        // will automatically retreive the job type of 
        // currently logged in user
        
        
        
        let requestURL: NSURL = NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/fillInJobType.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
            
                
                do {
                    let someValue = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String]
                    print(someValue)
                    
                    if(someValue[0] == "no job") {
                        
                        let alertController = UIAlertController(title: "Sorry!", message: "You have no assigned jobs", preferredStyle: .Alert)
                        
                       
                        
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: {
                            (action: UIAlertAction!) in
                            
                        
                        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let nextView = story.instantiateViewControllerWithIdentifier("WorkerLoginViewController") as! WorkerLoginViewController
                            self.presentViewController(nextView, animated: true, completion: nil)
                        
                    
                    
                            }))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                        
                    else {
                    
                    self.autoJobType.text = someValue[0]
                    activityIndicator.stopAnimating()
                    
                    }
                    
                } catch let _ as NSError{
                    print("error")
                }
   
                
                
            }
            
            
            
        }
        task.resume()
    
    
    } // end viewLoad function
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitHoursPressed(sender: AnyObject) {
    
        
        let alertController = UIAlertController(title: "Thumbs up!", message: "Your hours have been successfully submitted", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/submitHours.php")!)
        request.HTTPMethod = "Post"
        
        let postString = "jobHours=\(hoursEnteredTextField.text!)&jobType=\(autoJobType.text!)"
        
        
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
        
        
    } // end sumbitHoursPressed

 
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    

}
