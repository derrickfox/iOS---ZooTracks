//
//  SecondViewController.swift
//  Charting Demo
//
//  Created by Nikhil Kalra on 12/5/14.
//  Copyright (c) 2014 Nikhil Kalra. All rights reserved.
//

import UIKit
import JBChart

class GraphTableViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {
    
    @IBOutlet weak var lineChart: JBLineChartView!
    @IBOutlet weak var informationLabel: UILabel!
    
    var chartLegend = ["Raining", "Cloudy", "Partly Cloudy", "Partly Sunny", "Sunny"]
    var tempLegend = ["Very Cold", "Cold", "Warm", "Hot", "Very Hot"]
    var chartData = [70, 80, 76, 88, 90, 69, 74]
    var lastYearChartData = [75, 88, 79, 95, 72, 55, 90]
    var skyArrayGraph:NSMutableArray = []
    var tempArrayGraph:NSMutableArray = []
    var animalType:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        // line chart setup
        lineChart.backgroundColor = UIColor.darkGrayColor()
        lineChart.delegate = self
        lineChart.dataSource = self
        lineChart.minimumValue = 0
        lineChart.maximumValue = 10
        
        lineChart.reloadData()
        
        lineChart.setState(.Collapsed, animated: false)
        println(skyArrayGraph)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var footerView = UIView(frame: CGRectMake(0, 0, lineChart.frame.width, 16))
        
        println("viewDidLoad: \(lineChart.frame.width)")
        
        var footer1 = UILabel(frame: CGRectMake(0, 0, lineChart.frame.width/2 - 8, 16))
        footer1.textColor = UIColor.whiteColor()
        footer1.text = "\(chartLegend[0])"
        
        var footer2 = UILabel(frame: CGRectMake(lineChart.frame.width/2 - 8, 0, lineChart.frame.width/2 - 8, 16))
        footer2.textColor = UIColor.whiteColor()
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.Right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        var header = UILabel(frame: CGRectMake(0, 0, lineChart.frame.width, 50))
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.systemFontOfSize(24)
        header.text = animalType
        header.textAlignment = NSTextAlignment.Center
        
        lineChart.footerView = footerView
        lineChart.headerView = header
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        lineChart.reloadData()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        lineChart.setState(.Collapsed, animated: true)
    }
    
    func showChart() {
        lineChart.setState(.Expanded, animated: true)
    }
    
    // MARK: JBlineChartView
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 2
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0) {
            return UInt(skyArrayGraph.count)
        } else if (lineIndex == 1) {
            return UInt(tempArrayGraph.count)
        }
        
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if (lineIndex == 0) {
            return CGFloat(skyArrayGraph[Int(horizontalIndex)] as! NSNumber)
        } else if (lineIndex == 1) {
            return CGFloat(tempArrayGraph[Int(horizontalIndex)] as! NSNumber)
        }
        
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.lightGrayColor()
        } else if (lineIndex == 1) {
            return UIColor.whiteColor()
        }
        
        return UIColor.lightGrayColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return true }
        else if (lineIndex == 1) { return false }
        
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGrayColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return false }
        else if (lineIndex == 1) { return true }
        
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0) {
            let data: AnyObject = skyArrayGraph[Int(horizontalIndex)]
            let key = chartLegend[Int(horizontalIndex)]
            informationLabel.text = "Sky was \(key): \(data)"
        } else if (lineIndex == 1) {
            let data: AnyObject = tempArrayGraph[Int(horizontalIndex)]
            let key = tempLegend[Int(horizontalIndex)]
            informationLabel.text = "Temperature was \(key): \(data)"
        }
    }
    
    func didDeselectLineInLineChartView(lineChartView: JBLineChartView!) {
        informationLabel.text = ""
    }
    
    func lineChartView(lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 1) {
            return UIColor.whiteColor()
        }
        
        return UIColor.clearColor()
    }
    
}

