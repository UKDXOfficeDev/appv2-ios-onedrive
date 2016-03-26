//
//  ViewController.swift
//  OneDriveClient
//
//  Created by Peter Daukintis on 19/03/2016.
//  Copyright (c) 2016 Peter Daukintis. All rights reserved.
//

import UIKit

class ViewModel {
    var name: String = ""
    var desc: String = ""
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var appsTableView : UITableView!
    var tableData = [ViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://api.github.com/users/peted70/repos")
        let task = session.dataTaskWithURL( url!, completionHandler: {
            (data, response, error) -> Void in
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            } else {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    for object in json as! NSMutableArray {
                        let vm = ViewModel()
                        if let nm = object["name"] as? String {
                            vm.name = nm
                        }
                        if let dsc = object["description"] as? String {
                            vm.desc = dsc
                        }
                        self.tableData.append(vm)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.appsTableView.reloadData()
                        })
                    }
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
                print("Task completed \(data)")
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")

        cell.textLabel?.text = self.tableData[indexPath.row].name
        cell.detailTextLabel?.text = self.tableData[indexPath.row].desc
        
        return cell
    }
}

