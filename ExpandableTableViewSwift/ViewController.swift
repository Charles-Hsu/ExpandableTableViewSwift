//
//  ViewController.swift
//  ExpandableTableViewSwift
//
//  Created by Charles Hsu on 10/19/15.
//  Copyright © 2015 Pro Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayForBool: [Bool] = []
    
    let sectionTitleArray = [
        "Apple",
        "Strawberry",
        "Grapes",
        "Orange",
        "Banana",
        "Papaya",
        "Guava",
        "pineapple"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        arrayForBool = Array(count: sectionTitleArray.count, repeatedValue: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Datasource & Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0

        if arrayForBool[section] {
            numberOfRows = section + 2 // only for demo purpose, you can change any number what you want
        }
        print("\(__FUNCTION__):section:\(section):numberOfRows=\(numberOfRows)")
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
//        let manyCells = arrayForBool[indexPath.section]
//        
//        print("\(__FUNCTION__):\(indexPath.section)-\(indexPath.row):manyCells=\(manyCells)")
//        
//        if !manyCells {
//            cell.backgroundColor = UIColor.clearColor()
//            cell.textLabel?.text = ""
//        }
//        else {
        
            cell.textLabel?.text = String(format: "%@ %d", sectionTitleArray[indexPath.section], indexPath.row + 1)
            
            cell.backgroundColor = UIColor.redColor()
            cell.imageView?.image = UIImage(named: "point")
//            
//        }

        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        arrayForBool[indexPath.section] = false
//        
//        let indexSet = NSMutableIndexSet()
//        indexSet.addIndex(indexPath.section)
//
//        tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if arrayForBool[indexPath.section] {
            return 40
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    // MARK: - View for TableView Section
    
    func _tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRectMake(0, 0, 280, 40))
        sectionView.tag = section
        
        let label = UILabel(frame: CGRectMake(10, 0, tableView.frame.size.width-10, 40))
        
        label.backgroundColor = UIColor.whiteColor()
        label.text = String(format: "List of %@", sectionTitleArray[section])
        
        sectionView.addSubview(label)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: "sectionHeaderTapped:")
        sectionView.addGestureRecognizer(gesture)
        
        return sectionView
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell")
        
        headerCell?.textLabel?.text = String(format: "List of %@", sectionTitleArray[section])
        
        let gesture = UITapGestureRecognizer(target: self, action: "sectionHeaderTapped:")

        headerCell?.tag = section
        headerCell?.addGestureRecognizer(gesture)

        // Refs: What is the meaning of the “no index path for table cell being reused” message in iOS 6/7?
        // http://stackoverflow.com/questions/12772197/what-is-the-meaning-of-the-no-index-path-for-table-cell-being-reused-message-i
        
        let view = UIView(frame: headerCell!.frame)
        view.addSubview(headerCell!)
        
        return view
    }

    
    
    
    // MARK: Table Header Tapped Gesture
    
    func sectionHeaderTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("\(__FUNCTION__)")
        
        let indexPath = NSIndexPath(forRow: 0, inSection: gestureRecognizer.view!.tag)
        
//        if indexPath.row == 0 {
        
            let indexSet = NSMutableIndexSet()

        
            let collapsed = arrayForBool[indexPath.section]

        
            for var i=0; i < sectionTitleArray.count; i++ {
                
                print("section \(i) expanded : \(arrayForBool[i])")
                
                
                if indexPath.section == i {
                    arrayForBool[i] = !collapsed
                }
//                else if arrayForBool[i] == true {
//                    arrayForBool[i] = false
//                    indexSet.addIndex(i)
//                }
                
            }
            
            indexSet.addIndex(gestureRecognizer.view!.tag)

            tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Automatic)
            
//        }
        
        
    }
    
    

}

