//
//  GameSetupViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

final class GameSetupViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var showColorsButton: UIButton!
    @IBOutlet weak var colorOneSelectionView: UIView!
    @IBOutlet weak var colorTwoSelectionView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var playerOne: Player?
    var playerTwo: Player?
    
    var wedgeColors: [WedgeColor] = [.green, .yellow, .orange, .red, .pink, .purple, .blue, .brown]
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [showColorsButton]
    }
    
    var currentPlayer: PlayerNumber = .one {
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
        case .one: playerOne = Player(currentPlayer, colors: [wedgeColorOne, wedgeColorTwo])
        case .two: playerTwo = Player(currentPlayer, colors: [wedgeColorOne, wedgeColorTwo])
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
        if let gameSceneVC = segue.destination as? GameViewController {
            gameSceneVC.playerOne = playerOne
            gameSceneVC.playerTwo = playerTwo
        }
    }
    
    private func populateDescriptionLabelText(for player: PlayerNumber) {
        descriptionLabel.text = "\(player): Click 'Show' to see your colors for this match."
    }
}
