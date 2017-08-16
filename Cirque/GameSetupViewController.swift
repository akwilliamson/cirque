//
//  GameSetupViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var colorOneView: UIView!
    @IBOutlet weak var colorTwoView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    
    var currentPlayer: CurrentPlayer = .player1 {
        didSet {
            colorOneView.isHidden = true
            colorTwoView.isHidden = true
            populateDescriptionLabelText(for: currentPlayer)
        }
    }
    
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateGameColors()
        populateDescriptionLabelText(for: .player1)
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        guard let colorOne = colors.randomElement else { return }
        colorOneView.backgroundColor = colorOne
        if let i = colors.index(of: colorOne) { colors.remove(at: i) }
        guard let colorTwo = colors.randomElement else { return }
        colorTwoView.backgroundColor = colorTwo
        if let i = colors.index(of: colorTwo) { colors.remove(at: i) }
        
        switch currentPlayer {
        case .player1:
            playerOne = GamePlayer(player: currentPlayer, colorOne: colorOne, colorTwo: colorTwo)
        case .player2:
            playerTwo = GamePlayer(player: currentPlayer, colorOne: colorOne, colorTwo: colorTwo)
        }
        colorOneView.isHidden = false
        colorTwoView.isHidden = false
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        switch currentPlayer {
        case .player1:
            currentPlayer = .player2
        case .player2:
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GameScene") as! GameSceneViewController
            
            vc.playerOneColorOne = playerOne?.colorOne
            vc.playerOneColorTwo = playerOne?.colorTwo
            vc.playerTwoColorOne = playerTwo?.colorOne
            vc.playerTwoColorTwo = playerTwo?.colorTwo
            vc.playerOne = playerOne
            vc.playerTwo = playerTwo
            
            show(vc, sender: self)
        }
    }
    
    func generateGameColors() {
        (1...8).forEach { num in
            colors.append(UIColor(hue: CGFloat(num)/8.0, saturation: 0.5, brightness: 1.0, alpha: 1.0))
        }
    }
    
    func populateDescriptionLabelText(for player: CurrentPlayer) {
        let playerNumber = player == .player1 ? "1" : "2"
        descriptionLabel.text = "Player \(playerNumber): Click 'Show' to see your colors for this match"
    }
}
