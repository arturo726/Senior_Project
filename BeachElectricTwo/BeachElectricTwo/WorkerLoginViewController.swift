//
//  WorkerLoginViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit

class WorkerLoginViewController: UIViewController {

    
    @IBAction func HourButttonPressed(sender: AnyObject) {
    
        self.performSegueWithIdentifier("fillJobsSegue", sender: nil)
    
    }
    
    
    
    
    @IBAction func CheckJobPressed(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
        let requestURL: NSURL = NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/workerCheckJob.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                
                do {
                    let job = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String]
                    
                    
                    if(job[0] == "no job") {
                        
                        let alertController = UIAlertController(title: "Sorry!", message: "You currently have no jobs assgined", preferredStyle: .Alert)
                        
                        let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                
                    else {
                        
                        let alertController = UIAlertController(title: "Jobs:", message: "Your current job: \n" + job[0], preferredStyle: .Alert)
                        
                        let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)

                    }
                    
                } catch let _ as NSError{
                    print("error")
                }
            
            }
            }
            
        task.resume()
            
            })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
