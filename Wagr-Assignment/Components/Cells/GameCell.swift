//
//  GameCell.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import UIKit

class GameCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    // BG
    @IBOutlet private var shadowView: UIView!
    @IBOutlet private var roundedView: UIView!
    
    // Home Team
    @IBOutlet private var homePrimary: UIView!
    @IBOutlet private var homeSecondary: UIView!
    @IBOutlet private var homeNameLabel: UILabel!
    @IBOutlet private var homeCityLabel: UILabel!
    @IBOutlet private var homeSpreadLabel: UILabel!
    
    // Away Team
    @IBOutlet private var awayPrimary: UIView!
    @IBOutlet private var awaySecondary: UIView!
    @IBOutlet private var awayNameLabel: UILabel!
    @IBOutlet private var awayCityLabel: UILabel!
    @IBOutlet private var awaySpreadLabel: UILabel!
    
    // Bottom Info
    @IBOutlet private var leagueIcon: UIImageView!
    @IBOutlet private var leagueNameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var timeIcon: UIImageView!

    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 6.0
        static let shadowRadius: CGFloat = 3.0
        static let shadowOpacity: Float = 0.4
        static let shadowOffset: CGSize = .zero
    }
    
    // MARK: - Static Properties
    
    static let identifier = "GameCell"

    // MARK: - Lifecycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Internal Methods
    
    func update(with game: Game) {
        
        guard let homeTeam = game.homeTeam, let awayTeam = game.awayTeam else {
            fatalError("Data is corrupted, game doesn't have 2 teams")
        }
        
        let gameViewModel = GameViewModel(game)
        updateHomeTeamUI(homeTeam, with: gameViewModel)
        updateAwayTeamUI(awayTeam, with: gameViewModel)
        
        leagueIcon.image = UIImage(named: game.league)!
        leagueNameLabel.text = gameViewModel.league
        timeLabel.text = game.date.stringWithTimezone()
    }
    
    private func updateHomeTeamUI(_ team: Team, with gameViewModel: GameViewModel) {
        let showCity = gameViewModel.showCity
        let teamViewModel = TeamViewModel(team)
        
        homePrimary.backgroundColor = UIColor(hex: team.primaryColor)
        homeSecondary.backgroundColor = UIColor(hex: team.secondaryColor)
        homeNameLabel.text = showCity ? teamViewModel.nameWithNoCity : teamViewModel.eplName
        homeCityLabel.text = team.city
        homeSpreadLabel.text = gameViewModel.homeSpread
        homeCityLabel.isHidden = !showCity
    }
    
    private func updateAwayTeamUI(_ team: Team, with gameViewModel: GameViewModel) {
        let showCity = gameViewModel.showCity
        let teamViewModel = TeamViewModel(team)
        
        awayPrimary.backgroundColor = UIColor(hex: team.primaryColor)
        awaySecondary.backgroundColor = UIColor(hex: team.secondaryColor)
        awayNameLabel.text = showCity ? teamViewModel.nameWithNoCity : teamViewModel.eplName
        awayCityLabel.text = team.city
        awaySpreadLabel.text = gameViewModel.awaySpread
        awayCityLabel.isHidden = !showCity
    }
    
    // MARK: - Private Functions
    
    private func configureUI() {
        roundedView.layer.cornerRadius = Constants.cornerRadius
        roundedView.clipsToBounds = true
        makeRoundedAndShadowed(view: shadowView)
    }
    
    private func makeRoundedAndShadowed(view: UIView) {
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = Constants.shadowOffset
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowRadius = Constants.shadowRadius
    }
    
}
