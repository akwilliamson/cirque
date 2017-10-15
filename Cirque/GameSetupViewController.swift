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
    @IBOutlet weak var showColorsButton: UIButton!
    @IBOutlet weak var colorOneSelectionView: UIView!
    @IBOutlet weak var colorTwoSelectionView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    
    var wedgeColors: [WedgeColor] = [.green, .yellow, .orange, .red, .pink, .purple, .blue, .brown]
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [showColorsButton]
    }
    
    var currentPlayer: Player = .one {
        didSet {
            populateDescriptionLabelText(for: currentPlayer)
        }
    }
    
    @IBAction func showColorsButtonPressed(_ sender: UIButton) {
        
        guard let wedgeColorOne = wedgeColors.randomElement(), let wedgeColorTwo = wedgeColors.randomElement() else {
            print("wedgeColors array is empty"); return
        }
        
        colorOneSelectionView.backgroundColor = wedgeColorOne.regularColor
        colorTwoSelectionView.backgroundColor = wedgeColorTwo.regularColor
        
        [colorOneSelectionView, colorTwoSelectionView].forEach { $0?.isHidden = false }
        
        switch currentPlayer {
        case .one: playerOne = GamePlayer(currentPlayer, wedgeColorOne: wedgeColorOne, wedgeColorTwo: wedgeColorTwo)
        case .two: playerTwo = GamePlayer(currentPlayer, wedgeColorOne: wedgeColorOne, wedgeColorTwo: wedgeColorTwo)
        }
        
        showColorsButton.isEnabled = false
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
        
        showColorsButton.isEnabled = true
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
