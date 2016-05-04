//
//  ForemanLoginViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit

class ForemanLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    @IBAction func CheckJobsPressed(sender: AnyObject) {
    
    
    
        dispatch_async(dispatch_get_main_queue(), {
            
            let requestURL: NSURL = NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/foremanCheckJobs.php")!
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
                            
                            let alertController = UIAlertController(title: "Sorry!", message: "You have not assgined any jobs", preferredStyle: .Alert)
                            
                            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                            
                        }
                            
                        else {
                            
                            var jobsString = ""
                            
                            for index  in 0...(job.count - 1)
                            {
                                jobsString = job[index] + "\n" + jobsString
                                
                            }
                            
                            let alertController = UIAlertController(title: "Jobs:", message: "Assigned jobs: \n" + jobsString, preferredStyle: .Alert)
                            
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
    
        
    
    } // end foreman check pressed function
    
    
    
}
    

