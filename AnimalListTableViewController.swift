//
//  AnimalListTableViewController.swift
//  ZooTracker
//
//  Created by Derrick Fox on 6/3/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import UIKit
import CoreData

class AnimalListTableViewController: UITableViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered:[String] = []
    var searchActive : Bool = false
    var selectedAn = ""
    
    var myList = [
        "African Lion",
        "Aldabra Tortoise",
        "American Alligator",
        "American Black Duck",
        "Andean Bear",
        "Asian Elephant",
        "Asian Fairy-bluebird",
        "Asian Small-clawed Otter",
        "Bald Eagle",
        "Banded Mongoose",
        "Barred Owl",
        "Black Crake",
        "Blue-billed Curassow",
        "Blue-crowned Motmot",
        "Blue-gray Tanager",
        "Blue-naped Mousebird",
        "Blue-winged Teal",
        "Boat-billed Heron",
        "Brown Kiwi",
        "Brown Pelican",
        "Burrowing Owl",
        "Cattle Egret",
        "Clouded Leopard",
        "Common Raven",
        "Crested Caracal",
        "Crested Screamer",
        "Dama Gazelle",
        "Double-wattled Cassowary",
        "Emu",
        "Fishing Cat",
        "Flamingo",
        "Giant Anteater",
        "Giant Panda",
        "Greater Rhea",
        "Green-winged Teal",
        "Guira Cuckoo",
        "Hamerkop",
        "Hooded Merganser",
        "Indian Peafowl",
        "King Vulture",
        "Komodo Dragon",
        "Kori Bustard",
        "Little Blue Heron",
        "Mandarin Duck",
        "Maned Wolf",
        "Meerkat",
        "Micronesian Kingfisher",
        "Mountain Bamboo-Partridge",
        "North American Porcupine",
        "Northern Pintail",
        "Pheasant Pigeon",
        "Plumed Whistling-Duck",
        "Red Panda",
        "Red-billed Hornbill",
        "Red-crested Cardinal",
        "Red-legged Seriema",
        "Redhead",
        "Ring-tailed Lemur",
        "Ringed Teal",
        "Roseate Spoonbill",
        "Ruppell's Griffon Vulture",
        "Scarlet Ibis",
        "Silver-beaked Tanager",
        "Sloth Bear",
        "Smew",
        "Socorro Dove",
        "Southern Masked-Weaver",
        "Stanley Crane",
        "Sunbittern",
        "Temminck's Tragopan",
        "Tiger",
        "tron3",
        "Von der Decken's Hornbill",
        "White Stork",
        "White-cheeked Pintail",
        "White-faced Ibis",
        "White-faced Whistling-Duck",
        "White-naped Crane",
        "Whooping Crane",
        "Wood Duck"]
    
    var animalName:String = "Maybe"

    override func viewDidLoad() {
        super.viewDidLoad()
        var duplicateArray:NSArray = myList
        println(duplicateArray)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /*
    override func viewDidAppear(animated: Bool) {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Animal")
        
        myList = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
    }
    */
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "next" {
        selectedAn = ""
        
        //if (searchActive == true){
        if (filtered.count > 0){
            println("Filtered array count = \(filtered.count)")
            var selectedItem: String = filtered[self.tableView.indexPathForSelectedRow()!.row] as String
            selectedAn = selectedItem
        }else{
            var selectedItem: String = myList[self.tableView.indexPathForSelectedRow()!.row] as String
            selectedAn = selectedItem
        }
            animalName = selectedAn
        
            let IVC:EnterDataViewController = segue.destinationViewController as! EnterDataViewController
            
            IVC.animalType = animalName
            /*
            IVC.item = selectedItem.valueForKey("item") as! String
            IVC.quantity = selectedItem.valueForKey("quantity") as! String
            IVC.info = selectedItem.valueForKey("info") as! String
            IVC.existingItem = selectedItem
            */
            
       }else if segue.identifier == "back"{
            println("cooool")
        }
        selectedAn = ""
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(searchActive) {
            return filtered.count
        }
        return myList.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        cell.textLabel!.font = UIFont.boldSystemFontOfSize(12)

        //cell.textLabel.font = UIFont(systemFontOfSize:22.0);
        if let ip = indexPath as NSIndexPath?{
            /*
            cell.textLabel?.text = myList[ip.row] as? String
            */
            
            //if(searchActive){
            if(filtered.count > 0){
                cell.textLabel?.text = filtered[ip.row]
                cell.imageView?.image = UIImage(named: filtered[indexPath.row] as String)
            } else {
                cell.textLabel?.text = myList[ip.row] as String;
                cell.imageView?.image = UIImage(named: myList[indexPath.row] as String)
            }
            /*
            cell.imageView?.image = UIImage(named: myList[indexPath.row] as! String)
            */
        }
        // Configure the cell...
        return cell

        /*
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = myList[indexPath.row] as! String;
        }
        */
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = myList.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
