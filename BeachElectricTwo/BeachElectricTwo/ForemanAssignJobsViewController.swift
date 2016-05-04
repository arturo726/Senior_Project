//
//  ForemanAssignJobsViewController.swift
//  BeachElectricTwo
//
//  Created by Arturo Martinez
//  Copyright © 2016 Arturo Martinez. All rights reserved.
//

import UIKit

class ForemanAssignJobsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // , UITextFieldDelegate
   
    
    @IBOutlet weak var JobTypeTextField: UITextField!
    @IBOutlet weak var WorkerTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    
    
    @IBOutlet weak var Scroll: UIScrollView!
    
    
    // job types for picker
    var jobs = [" ", "Electrical", "Plumbing", "Drywall"]
    var JobPicker = UIPickerView()
    
    
    
    // initialize worker picker wheel
    var workers = [""]
    var WorkerPicker = UIPickerView();


    // dismiss picker wheel after done is pressed
    func donePicker(sender : UIBarButtonItem!) {
        self.view.endEditing(true)
        
    }
    
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    // when button is pressed, will retrieve workers who are not assigned to a job and will present the workers with the most experience at the top and dispaly the rest in descending code
    @IBAction func RetreiveWorkerButton(sender: AnyObject) {
    
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/fillInWorker.php")!)
        request.HTTPMethod = "Post"
        
        let postString = "JobTipo=\(JobTypeTextField.text!)"
        print(JobTypeTextField.text!)
        
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
            

            
            do{
                let someValue = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as![String]
                self.workers = someValue
                
            } catch let _ as NSError{
                print("error")
            }
            
            
        }
        
        task.resume()
    
    } //end retreieve worker button
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Scroll.contentSize.height = 900

        
                // sets Jop type intially to first job = electrical
        JobTypeTextField.text = jobs[0]
        
        // set up toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 200/255, green: 50/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style : UIBarButtonItemStyle.Plain, target: self, action: "donePicker:")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker:")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        
        
        // display picker view for type of job
        
        JobPicker.showsSelectionIndicator = true
        JobPicker.delegate = self
        JobPicker.dataSource = self
        JobTypeTextField.inputView = JobPicker
        JobTypeTextField.inputAccessoryView = toolBar
        
        
        // display picker for workers
        
        WorkerPicker.showsSelectionIndicator = true
        WorkerPicker.delegate = self
        WorkerPicker.dataSource = self
        WorkerTextField.inputView = WorkerPicker
        WorkerTextField.inputAccessoryView = toolBar
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    
    // number of picker wheels
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    
            return 1
    
        }
    
    // number of rows
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == JobPicker {
            return jobs.count
        }
        
        else if pickerView == WorkerPicker {
            return workers.count
        }
        
        return 1
    }
    

    
    // set label for each row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == JobPicker {
        return jobs[row]
        
        }
        
        else if pickerView == WorkerPicker {
            return workers[row]
            
        }

        return ""
    }

    
    // detect what has been selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == JobPicker {
            JobTypeTextField.text = jobs[row]
       
        }

        else if pickerView == WorkerPicker {
            WorkerTextField.text = workers[row]
            
        }
        
    }
    
    
    @IBAction func SubmitTocuhed(sender: AnyObject) {
    
        
        // check of all fields are filled out
        if (JobTypeTextField.text!.isEmpty || WorkerTextField.text!.isEmpty || LocationTextField.text!.isEmpty ) {
            
            let alertController = UIAlertController(title: "Go back!", message: "Please fill out the missing fields", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    
            
        else {
            
            let alertController = UIAlertController(title: "Thumbs up!", message: "Job was assigned", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.cs.loyola.edu/~gmejia/Project2/sendJobs.php")!)
            request.HTTPMethod = "Post"
            
            let postString = "JobTipo=\(JobTypeTextField.text!)&assignedWorker=\(WorkerTextField.text!)&workSite=\(LocationTextField.text!)"
            
            
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

        
        
    
    } // SubmitTouched
    

}
