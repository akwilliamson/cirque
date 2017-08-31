//
//  GameSetupViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController, GameColoring {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var showColorsButton: UIButton!
    @IBOutlet weak var colorOneSelectionView: UIView!
    @IBOutlet weak var colorTwoSelectionView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    
    var gameColors = [UIColor]()
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [showColorsButton]
    }
    
    var currentPlayer: Player = .one {
        didSet {
            populateDescriptionLabelText(for: currentPlayer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateGameColors()
    }
    
    @IBAction func showColorsButtonPressed(_ sender: UIButton) {
        
        guard let groupColorOne = gameColors.randomElement(), let groupColorTwo = gameColors.randomElement() else {
            print("gameColors array is empty"); return
        }
        
        colorOneSelectionView.backgroundColor = groupColorOne
        colorTwoSelectionView.backgroundColor = groupColorTwo
        
        [colorOneSelectionView, colorTwoSelectionView].forEach { $0?.isHidden = false }
        
        switch currentPlayer {
        case .one:
            playerOne = GamePlayer(currentPlayer, groupColorOne: groupColorOne, groupColorTwo: groupColorTwo)
        case .two:
            playerTwo = GamePlayer(currentPlayer, groupColorOne: groupColorOne, groupColorTwo: groupColorTwo)
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        [colorOneSelectionView, colorTwoSelectionView].forEach { $0?.isHidden = true }
        
        switch currentPlayer {
        case .one:
            currentPlayer = .two
        case .two:
            performSegue(withIdentifier: "StartGame", sender: self)
        }
        
        setNeedsFocusUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameSceneVC = segue.destination as? GameSceneViewController {
            gameSceneVC.playerOne = playerOne
            gameSceneVC.playerTwo = playerTwo
        }
    }
    
    private func populateDescriptionLabelText(for player: Player) {
        descriptionLabel.text = "\(player.name): Click 'Show' to see your colors for this match."
    }
}
