//
//  MatchViewController.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import PNChart
import Charts


let kWinImageName : String = "king"
let kLossImageName : String = "checkmate"

class MatchViewController: UIViewController {
    @IBOutlet weak var pieChart: PieChartView!

    @IBOutlet weak var playerOneWinImage: UIImageView!

    
    @IBOutlet weak var startMatchButton: UIButton!
    @IBOutlet weak var playerTwoWinImage: UIImageView!
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
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
        self.iamgeViewPlayerOne.setImageWithString(competitors[0].name, color: nil, circular: false)
        self.iamgeViewPlayerOne.layer.cornerRadius = 8.0
        
        self.labelPlayerTwoName.text = competitors[1].name
        self.labelPlayerTwoRating.text = "\(competitors[1].rating)"
        self.imageViewPlayerTwo.setImageWithString(competitors[1].name, color: nil, circular: false)
        self.imageViewPlayerTwo.layer.cornerRadius = 8.0

        self.startMatchButton.enabled = false
        
        self.pieChart.descriptionTextColor = NSUIColor.flatBlackColorDark()
        self.pieChart.infoTextColor = NSUIColor.flatBlackColorDark()
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
//            self.viewPlayerOne.backgroundColor = UIColor.flatLimeColorDark()
//            self.viewPlayerTwo.backgroundColor = UIColor.flatRedColorDark()
            self.playerOneWinImage.image = UIImage.init(named: kWinImageName)
            self.playerTwoWinImage.image = UIImage.init(named: kLossImageName)
        }
        else if result == 2 {
            winnerChessLegend = competitors[1]
            print("\(winnerChessLegend.name) Wins!")
//            self.viewPlayerOne.backgroundColor = UIColor.flatRedColorDark()
//            self.viewPlayerTwo.backgroundColor = UIColor.flatLimeColorDark()
            self.playerTwoWinImage.image = UIImage.init(named: kWinImageName)
            self.playerOneWinImage.image = UIImage.init(named: kLossImageName)
        }
        else if result == 3 {
            print("Draw")
//            self.viewPlayerOne.backgroundColor = UIColor.flatSandColorDark()
//            self.viewPlayerTwo.backgroundColor = UIColor.flatSandColorDark()
            
            self.playerTwoWinImage.image = UIImage.init(named: kWinImageName)
            self.playerOneWinImage.image = UIImage.init(named: kWinImageName)
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
        
        var winner : ChessLegend = ChessLegend()
        var losser : ChessLegend = ChessLegend()
        
        switch matchResultValue {
        case 1: playerOneActualScore = 1
        playerTwoActualScore = 0
            winner = competitors[0]
            losser = competitors[1]
            
        case 2 : playerOneActualScore = 0
        playerTwoActualScore = 1
        winner = competitors[1]
        losser = competitors[0]
        case 3 : playerOneActualScore = 0.5
        playerTwoActualScore = 0.5
        winner = competitors[0]
        losser = competitors[1]
        default:
            print("Unknown Case")
        }
        
        let winnerPreviousRating : Float = winner.rating
        let losserPreviousRating : Float = losser.rating
        
        let playerOneNewRating : Float = competitors[0].rating + K_FACTOR * (playerOneActualScore - playerOneExpectedScore)
        let playerTwoNewRating : Float = competitors[0].rating + K_FACTOR * (playerTwoActualScore - playerTwoExpectedScore)
        

        
        let competitorOne : ChessLegend = ChessLegend.updateChessLegend(competitors[0], newRating: playerOneNewRating, previousRating: competitors[0].rating)
        let competitorTwo : ChessLegend = ChessLegend.updateChessLegend(competitors[1], newRating: playerTwoNewRating, previousRating: competitors[1].rating)
        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorOne)
        ATDatabaseManager.getDatabaseInstance().updateChessLegend(competitorTwo)
        
        
        var losserChange : Float = Float()
        var winnerChange : Float = Float()
        
        if winner == competitorOne {
            winnerChange = Float(abs(competitorOne.changeInRating))
            losserChange = Float(abs(competitorTwo.changeInRating))
        }
        else {
            winnerChange = Float(abs(competitorTwo.changeInRating))
            losserChange = Float(abs(competitorOne.changeInRating))
        }
        
        let dataPoints : [String] = ["Rating of \(winner.name) prior to match","Rating won by \(winner.name) after match","Rating of \(losser.name) prior to match","Rating lost by \(losser.name) after match"]
    
        let values : [Double] = [Double(winnerPreviousRating),Double(winnerChange),Double(losserPreviousRating),Double(losserChange)]
        
        setChart(dataPoints, values: values)
        

    }
    
    func doMatch() {
        matchResult()
        
        eloRatingSystem(competitors)
        
        if matchResultValue == 1 {
            
            self.alert("Winner", message: "\(competitors[0].name) won the game!")
        }
        else if matchResultValue == 2 {
            self.alert("Winner", message: "\(competitors[1].name) won the game!")

        }
        else if matchResultValue == 3 {
            self.alert("Draw", message: "Match was draw!")
        }
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Ratings")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        self.pieChart.data = pieChartData
        
        let colors: [UIColor] = [UIColor.flatYellowColorDark(), UIColor.flatOrangeColor(),UIColor.flatSkyBlueColor(),UIColor.flatGreenColorDark()]
        
        pieChartDataSet.colors = colors
        
        self.pieChart.animate(xAxisDuration: 1.4, easingOption: ChartEasingOption.EaseInOutQuad)

        
    }
    
    func alert(title : String, message : String) {
        
        let alert : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(ok)
        
        self.presentViewController(alert, animated: true, completion: nil)
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
