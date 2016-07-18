//
//  QRWebViewController.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/17/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit

class QRWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urls : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: urls!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
