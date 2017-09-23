//
//  GameSetupViewController.swift
//  Cirque
//
//  Created by Aaron Williamson on 8/13/17.
//  Copyright © 2017 Aaron Williamson. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController, GameSpaceColoring {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var showColorsButton: UIButton!
    @IBOutlet weak var colorOneSelectionView: UIView!
    @IBOutlet weak var colorTwoSelectionView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var playerOne: GamePlayer?
    var playerTwo: GamePlayer?
    
    var groupColors = [GroupColor]()
    
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
        populateGroupColors()
    }
    
    @IBAction func showColorsButtonPressed(_ sender: UIButton) {
        
        guard let groupColorOne = groupColors.randomElement(), let groupColorTwo = groupColors.randomElement() else {
            print("groupColors array is empty"); return
        }
        
        colorOneSelectionView.backgroundColor = groupColorOne.openColor
        colorTwoSelectionView.backgroundColor = groupColorTwo.openColor
        
        [colorOneSelectionView, colorTwoSelectionView].forEach { $0?.isHidden = false }
        
        switch currentPlayer {
        case .one: playerOne = GamePlayer(currentPlayer, groupColorOne: groupColorOne, groupColorTwo: groupColorTwo)
        case .two: playerTwo = GamePlayer(currentPlayer, groupColorOne: groupColorOne, groupColorTwo: groupColorTwo)
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
