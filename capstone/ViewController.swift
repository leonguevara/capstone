//
//  ViewController.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/15/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainMenu: UITableView!
    
    var menuItems = [Dictionary<String,String>()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Se asigna este controlador como delegado de la tabla del menú principal
        mainMenu.delegate = self
        mainMenu.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if (menuItems.count != 0) {
            menuItems.removeAll()
            // Elementos del menú principal
            menuItems.append(["name":"Rutas","imageName":"route.png","segue":"mapSegue"])
            menuItems.append(["name":"Lector de códigos QR","imageName":"qrcode.png","segue":"qrSegue"])
            menuItems.append(["name":"Eventos","imageName":"calendar.png","segue":"eventSegue"])
            menuItems.append(["name":"Acerca de...","imageName":"about.png","segue":"aboutSegue"])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSourceMethods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MenuCellController
        let row = indexPath.row
        
        cell.menuOption.text = menuItems[row]["name"]
        cell.menuImage?.image = UIImage(named:menuItems[row]["imageName"]!)
        
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Dependiendo del renglón que elija, es la ruta que seguirá
        
        let row = indexPath.row
        let chosenSegue = menuItems[row]["segue"]
        
        if ((chosenSegue == "qrSegue") || (chosenSegue == "mapSegue")) {
            performSegueWithIdentifier(chosenSegue!, sender: self)
        }
    }
}

