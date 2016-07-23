//
//  MatchViewController.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {


    
    @IBOutlet weak var startMatchButton: UIButton!
    @IBOutlet weak var iamgeViewPlayerOne: UIImageView!
    
    @IBOutlet weak var labelPlayerOneName: UILabel!
    
    @IBOutlet weak var labelPlayerOneRating: UILabel!
    
    @IBOutlet weak var labelPlayerOneExpectedScore: UILabel!
    
    @IBOutlet weak var imageViewPlayerTwo: UIImageView!
    
    @IBOutlet weak var labelPlayerTwoExpectedScore: UILabel!
    @IBOutlet weak var labelPlayerTwoRating: UILabel!
    @IBOutlet weak var labelPlayerTwoName: UILabel!
    
    
    
    @IBOutlet weak var viewPlayerOne: UIView!
    
    @IBOutlet weak var viewPlayerTwo: UIView!
    
    @IBAction func startMatchButtonTapped(sender: AnyObject) {
        
        doMatch()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initUI()
        
        self.performSelector(#selector(MatchViewController.showExpectedScore), withObject: nil, afterDelay: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        
        competitors.removeAll()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func initUI() {
    
        self.labelPlayerOneName.text = competitors[0].name
        self.labelPlayerOneRating.text = "\(competitors[0].rating)"
        
        self.labelPlayerTwoName.text = competitors[1].name
        self.labelPlayerTwoRating.text = "\(competitors[1].rating)"
        
        self.startMatchButton.enabled = false
    }

    func showExpectedScore() {
        let playerOneTransformRating : Float = (10 * competitors[0].rating)/400
        let playerTwoTransformRating : Float = (10 * competitors[1].rating)/400
        
        let playerOneExpectedScore : Float =  playerOneTransformRating / (playerOneTransformRating + playerTwoTransformRating)
        let playerTwoExpectedScore : Float = playerTwoTransformRating / (playerOneTransformRating + playerTwoTransformRating)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            
            let scoreOne : Float = round(playerOneExpectedScore * 1000)/1000
            let scoreTwo : Float = round(playerTwoExpectedScore * 1000)/1000

            self.labelPlayerOneExpectedScore.text = "\(scoreOne)"
            self.labelPlayerTwoExpectedScore.text = "\(scoreTwo)"
            }) { (finished) in
                
                self.startMatchButton.enabled = true

        }
        
    }
    
    func matchResult() {
        
        let result : Int = Int(arc4random_uniform(3)) + 1
        
        matchResultValue = result
        print("Result Value : \(result)")
        
        var winnerChessLegend : ChessLegend = ChessLegend()
        if result == 1 {
            winnerChessLegend = competitors[0]
            print("\(winnerChessLegend.name) Wins!")
            self.viewPlayerOne.backgroundColor = UIColor.flatLimeColorDark()
            self.viewPlayerTwo.backgroundColor = UIColor.flatRedColorDark()
        }
        else if result == 2 {
            winnerChessLegend = competitors[1]
            print("\(winnerChessLegend.name) Wins!")
            self.viewPlayerOne.backgroundColor = UIColor.flatRedColorDark()
            self.viewPlayerTwo.backgroundColor = UIColor.flatLimeColorDark()
        }
        else if result == 3 {
            print("Draw")
            self.viewPlayerOne.backgroundColor = UIColor.flatSandColorDark()
            self.viewPlayerTwo.backgroundColor = UIColor.flatSandColorDark()
        }
        else {
            print("Unknown Case")
        }
        
        
        
    }
    
    func eloRatingSystem(competitors : [ChessLegend]) {
        
        let playerOneTransformRating : Float = (10 * competitors[0].rating)/400
        let playerTwoTransformRating : Float = (10 * competitors[1].rating)/400
        
        let playerOneExpectedScore : Float =  playerOneTransformRating / (playerOneTransformRating + playerTwoTransformRating)
        let playerTwoExpectedScore : Float = playerTwoTransformRating / (playerOneTransformRating + playerTwoTransformRating)
        
        var playerOneActualScore : Float = Float()
        var playerTwoActualScore : Float = Float()
        
        switch matchResultValue {
        case 1: playerOneActualScore = 1
        playerTwoActualScore = 0
            
        case 2 : playerOneActualScore = 0
        playerTwoActualScore = 1
        case 3 : playerOneActualScore = 0.5
        playerTwoActualScore = 0.5
            
        default:
            print("Unknown Case")
        }
        
        let playerOneNewRating : Float = competitors[0].rating + K_FACTOR * (playerOneActualScore - playerOneExpectedScore)
        let playerTwoNewRating : Float = competitors[0].rating + K_FACTOR * (playerTwoActualScore - playerTwoExpectedScore)
        
        print("\(competitors[0].name) BEFORE : \(competitors[0].rating) AFTER : \(playerOneNewRating)")
        print("\(competitors[1].name) BEFORE : \(competitors[1].rating) AFTER : \(playerTwoNewRating)")
        
        let competitorOne : ChessLegend = ChessLegend.updateChessLegend(competitors[0], newRating: playerOneNewRating, previousRating: competitors[0].rating)
        let competitorTwo : ChessLegend = ChessLegend.updateChessLegend(competitors[1], newRating: playerTwoNewRating, previousRating: competitors[1].rating)
        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorOne)
        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorTwo)
        
        
    }
    
    func doMatch() {
        matchResult()
        
        eloRatingSystem(competitors)
                
//        NSNotificationCenter.defaultCenter().postNotificationName(kHideMatch, object: nil)
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
