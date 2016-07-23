//
//  ViewController.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftyJSON
import UIImageView_Letters

let kRequestURL : String = "https://api.myjson.com/bins/1dmu1"
let kChessLegendCellIdentifier : String = "legend cell"
var competitors : [ChessLegend] = [ChessLegend]()
var allChessLegends : [ChessLegend] = [ChessLegend]()
let kShowMatch : String = "Show Match"
let kHideMatch : String = "Hide Match"
let K_FACTOR : Float = 32
var matchResultValue : Int = Int()
let kCheckImageName : String = "king"
class ViewController: UIViewController {
    
    @IBOutlet weak var matchButtonShow: NSLayoutConstraint!
    
    @IBOutlet weak var matchButtonHide: NSLayoutConstraint!
    

    @IBOutlet weak var tableViewChessLegends: UITableView!
    
    @IBOutlet weak var matchButton: UIButton!
    
    @IBAction func matchButtonTapped(sender: AnyObject) {
        
        if competitors.count == 2 {
            
//            doMatch()
            
            let matchView : MatchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MatchViewController") as! MatchViewController
            
            self.presentViewController(matchView, animated: true, completion: nil)
            
            
        }
        else if competitors.count == 1 {
            
            self.alert("Select Players", message: "Please Select One More Player to being a match.")
        }
        else if competitors.count < 1 {
            self.alert("Select Players", message: "Please Select Two Players to being a match.")

        }
        else {
            self.alert("Players Exceeding", message: "Only Two Players of your choice are allowed.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initApplication()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        fetchData()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initApplication() {
//     self.tableViewChessLegends.allowsSelection = false
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.showMatchButton), name: kShowMatch, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.hideMatchButton), name: kHideMatch, object: nil)
        
        
    }
    
    func fetchData() {
        
        if totalRow >= 20 {
            
            loadPlayersFromLocalDatabase()
        }
        else {
            
            let URL : NSURL = NSURL.init(string: kRequestURL)!
            
            
            let json : JSON = ATJSONManager.sharedManager.getJSON(URL)!
            ChessLegend.buildLegends(json)
            
            loadPlayersFromLocalDatabase()

        }
    }
    
    func loadPlayersFromLocalDatabase() {
        
        allChessLegends = ATDatabaseManager.getDatabaseInstance().fetchAllChessLegends()
        
        if allChessLegends.count > 0 {
            self.tableViewChessLegends.reloadData()
        }
        
    }

    func addCompetitor(competitor : ChessLegend) {
        competitors.append(competitor)
        
        if competitors.count == 2 {
            NSNotificationCenter.defaultCenter().postNotificationName(kShowMatch, object: nil)
        }
    }
    
    func removeCompetitor(competitor : ChessLegend) {
        if let index : Int = competitors.indexOf(competitor) {
            competitors.removeAtIndex(index)
            if competitors.count < 2 {
                NSNotificationCenter.defaultCenter().postNotificationName(kHideMatch, object: nil)
            }
        }
        
    }
    
    func showMatchButton() {
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.matchButtonShow.priority = (competitors.count == 2) ? 750 : 250
            self.matchButtonHide.priority = (competitors.count == 2) ? 250 : 750
            self.view.layoutIfNeeded()
            
            }) { (finished) in
                
        }
    }
    
    func hideMatchButton() {
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.matchButtonShow.priority = (competitors.count < 2) ? 250 : 750
            self.matchButtonHide.priority = (competitors.count < 2) ? 750 : 250
            self.view.layoutIfNeeded()
        }) { (finished) in
            
        }
    }
    
//    func matchResult() {
//        
//        let result : Int = Int(arc4random_uniform(3)) + 1
//        
//        matchResultValue = result
//        print("Result Value : \(result)")
//        
//        var winnerChessLegend : ChessLegend = ChessLegend()
//        if result == 1 {
//            winnerChessLegend = competitors[0]
//            print("\(winnerChessLegend.name) Wins!")
//        }
//        else if result == 2 {
//            winnerChessLegend = competitors[1]
//            print("\(winnerChessLegend.name) Wins!")
//        }
//        else if result == 3 {
//            print("Draw")
//        }
//        else {
//            print("Unknown Case")
//        }
//        
//        
//
//    }
//    
//    func eloRatingSystem(competitors : [ChessLegend]) {
//        
//        let playerOneTransformRating : Float = (10 * competitors[0].rating)/400
//        let playerTwoTransformRating : Float = (10 * competitors[1].rating)/400
//
//        let playerOneExpectedScore : Float =  playerOneTransformRating / (playerOneTransformRating + playerTwoTransformRating)
//        let playerTwoExpectedScore : Float = playerTwoTransformRating / (playerOneTransformRating + playerTwoTransformRating)
//        
//        var playerOneActualScore : Float = Float()
//        var playerTwoActualScore : Float = Float()
//
//        switch matchResultValue {
//        case 1: playerOneActualScore = 1
//            playerTwoActualScore = 0
//        
//        case 2 : playerOneActualScore = 0
//        playerTwoActualScore = 1
//        case 3 : playerOneActualScore = 0.5
//        playerTwoActualScore = 0.5
//            
//        default:
//            print("Unknown Case")
//        }
//        
//        let playerOneNewRating : Float = competitors[0].rating + K_FACTOR * (playerOneActualScore - playerOneExpectedScore)
//        let playerTwoNewRating : Float = competitors[0].rating + K_FACTOR * (playerTwoActualScore - playerTwoExpectedScore)
//        
//        print("\(competitors[0].name) BEFORE : \(competitors[0].rating) AFTER : \(playerOneNewRating)")
//        print("\(competitors[1].name) BEFORE : \(competitors[1].rating) AFTER : \(playerTwoNewRating)")
//
//        let competitorOne : ChessLegend = ChessLegend.updateChessLegend(competitors[0], newRating: playerOneNewRating, previousRating: competitors[0].rating)
//        let competitorTwo : ChessLegend = ChessLegend.updateChessLegend(competitors[1], newRating: playerTwoNewRating, previousRating: competitors[1].rating)
//        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorOne)
//        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorTwo)
//        
//
//    }
//    
//    func doMatch() {
//        matchResult()
//        
//        eloRatingSystem(competitors)
//        
//        competitors.removeAll()
//        NSNotificationCenter.defaultCenter().postNotificationName(kHideMatch, object: nil)
//        loadPlayersFromLocalDatabase()
//    }
    
    

    func setChangeInRatingLabel(changeInRating : Float,label : UILabel) -> String {
        
        if changeInRating == 0 {
            label.backgroundColor = UIColor.clearColor()
            return ""
        }
        else if changeInRating > 0 {
            label.backgroundColor = UIColor.flatGreenColor()
        }
        else if changeInRating < 0 {
            label.backgroundColor = UIColor.flatWatermelonColor()
        }
        
        let roundOff = round(changeInRating*100)/100
        return "\(roundOff)"
    }
    
    func alert(title : String, message : String) {
        
        let alert : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(ok)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChessLegends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ChessLegendTableViewCell = tableView.dequeueReusableCellWithIdentifier(kChessLegendCellIdentifier) as! ChessLegendTableViewCell
    
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        let chessLegendModel : ChessLegend = allChessLegends[indexPath.row]
        
    
        cell.labelName.text = chessLegendModel.name
        cell.labelRating.text = "\(chessLegendModel.rating)"
        
        cell.labelChangeInRating.text = setChangeInRatingLabel(chessLegendModel.changeInRating, label: cell.labelChangeInRating)
        
        cell.imageViewProfile.setImageWithString(chessLegendModel.name, color: nil, circular: true)
        
        cell.labelChangeInRating.layer.cornerRadius = 8.0
        
        if competitors.count == 0 {
            cell.imageViewSelect.image = nil
        }
        
        return cell
        
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell : ChessLegendTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! ChessLegendTableViewCell
        
        
        if let image = UIImage.init(named: kCheckImageName) {
            if cell.imageViewSelect.image == image {
                cell.imageViewSelect.image = nil
                removeCompetitor(allChessLegends[indexPath.row])
            }
            else {
                cell.imageViewSelect.image = image                
                addCompetitor(allChessLegends[indexPath.row])
            }
        }
        
        
        
    }
}

