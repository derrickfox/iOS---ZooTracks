//
//  EnterDataViewController.swift
//  ZooTracker
//
//  Created by Derrick Fox on 6/2/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import UIKit
import CoreData

class EnterDataViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var animalPicker: UIPickerView!
    
    var skyList = ["Raining", "Cloudy", "Partly Cloudy", "Partly Sunny", "Sunny"]
    var animalType:String = ""
    var skyString:String = ""
    
    var skyArray:NSMutableArray = []
    var tempArray:NSMutableArray = []
    
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var skyPicker: UIPickerView!
    @IBOutlet weak var tempNumPad: UITextField!
    
    @IBAction func saveButton(sender: AnyObject) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("Animal", inManagedObjectContext: context)
        let ent2 = NSEntityDescription.entityForName("Visit", inManagedObjectContext: context)
        
        
        var animal = Animal(entity: ent!, insertIntoManagedObjectContext: context)
        var visit = Visit(entity: ent2!, insertIntoManagedObjectContext: context)
        
        animal.name = animalType
        visit.sky = skyString
        var i = NSNumber(integer: tempNumPad.text.toInt()!)
        visit.temperature = i
        visit.time = NSDate()
        visit.toAnimal = animal
        
        context.save(nil)
        
        resultsLabel.text = "Saved!"
        
    }
    
    @IBAction func loadButton(sender: AnyObject) {
        resultsLabel.text = ""
        skyArray.removeAllObjects()
        tempArray.removeAllObjects()
        var countIt = 0
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Animal")
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "name = %@", animalType)
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        
        var animalList:NSSet = NSSet()
        
        var counter = 0
        var rainyCounter = 0
        var cloudyCounter = 0
        var partlyCloudyCounter = 0
        var partlySunnyCounter = 0
        var sunnyCounter = 0
        
        var veryColdTempCounter = 0
        var coldTempCounter = 0
        var warmTempCounter = 0
        var hotTempCounter = 0
        var veryHotTempCounter = 0
        
        for animal in results {
            let animal:Animal = animal as! Animal
            animalLabel.text = animal.name
            
            animalList = animal.toVisit
            for list in animalList {
                
                println(list.valueForKey("sky"))
                println(list.valueForKey("temperature"))
                println(list.valueForKey("time"))
                
                counter = counter + 1
                println("Counter : \(counter)")
                
                if (list.valueForKey("sky") as! String == "Raining"){
                    rainyCounter++
                }else if(list.valueForKey("sky") as! String == "Cloudy"){
                    cloudyCounter++
                }else if(list.valueForKey("sky") as! String == "Partly Cloudy"){
                    partlyCloudyCounter++
                }else if(list.valueForKey("sky") as! String == "Partly Sunny"){
                    partlySunnyCounter++
                }else if(list.valueForKey("sky") as! String == "Sunny"){
                    sunnyCounter++
                }
                
                var temperature = list.valueForKey("temperature")!.doubleValue
                
                if (temperature >= 90){
                    veryHotTempCounter++
                }else if(temperature >= 80 && temperature <= 89){
                    hotTempCounter++
                }else if(temperature >= 60 && temperature <= 79){
                    warmTempCounter++
                }else if(temperature >= 50 && temperature <= 59){
                    coldTempCounter++
                }else if(temperature <= 49){
                    veryColdTempCounter++
                }
                
                println("Rainy counter : \(rainyCounter)")
                println("Cloudy counter : \(cloudyCounter)")
                println("Partly Cloudy counter : \(partlyCloudyCounter)")
                println("Partly Sunny counter : \(partlySunnyCounter)")
                println("Sunny counter : \(sunnyCounter)")
                
                println("Hot days : \(hotTempCounter)")
                println("Warm days : \(warmTempCounter)")
                println("Cold days : \(coldTempCounter)")
            }
        }
        skyArray.addObject(rainyCounter)
        skyArray.addObject(cloudyCounter)
        skyArray.addObject(partlyCloudyCounter)
        skyArray.addObject(partlySunnyCounter)
        skyArray.addObject(sunnyCounter)
        
        tempArray.addObject(veryColdTempCounter)
        tempArray.addObject(coldTempCounter)
        tempArray.addObject(warmTempCounter)
        tempArray.addObject(hotTempCounter)
        tempArray.addObject(veryColdTempCounter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skyPicker.delegate = self
        animalLabel.text = animalType
        println("From second \(animalType)")

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        tempNumPad.resignFirstResponder()
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skyList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return skyList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skyString = skyList[row]
        println(skyList[row])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //nameIt = nameTextField.text
        if segue.identifier == "graph" {
            var nextController:GraphTableViewController = segue.destinationViewController as! GraphTableViewController
            nextController.skyArrayGraph = skyArray
            nextController.tempArrayGraph = tempArray
            nextController.animalType = animalType
        }else{
            var nextOne:AnimalListTableViewController = segue.destinationViewController as! AnimalListTableViewController
            nextOne.searchActive = false
        }
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
