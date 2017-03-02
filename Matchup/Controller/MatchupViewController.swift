//
//  MatchupViewController.swift
//  Matchup
//
//  Created by Daniel Burke on 12/20/16.
//  Copyright © 2016 Daniel Burke. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MatchupViewController: UIViewController {
    
    let player1: Player
    let player2: Player
    
    let player1Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let player2Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let player1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return imageView
    }()
    
    let player2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return imageView
    }()
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        super.init(nibName: nil, bundle: nil)
        
        title = "Matchup"
        
        player1Label.text = player1.name
        player2Label.text = player2.name
        
        player1ImageView.layer.borderColor = player1.rating > player2.rating ? UIColor.yellow.cgColor : UIColor.clear.cgColor
        player2ImageView.layer.borderColor = player2.rating > player1.rating ? UIColor.yellow.cgColor : UIColor.clear.cgColor
        
        player1ImageView.alpha = player1.rating > player2.rating ? 1 : 0.3
        player2ImageView.alpha = player2.rating > player1.rating ? 1 : 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(player1ImageView)
        view.addSubview(player2ImageView)
        view.addSubview(player1Label)
        view.addSubview(player2Label)
        
        installConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player1ImageView.loadImage(imageURL: player1.imageURL)
        player2ImageView.loadImage(imageURL: player2.imageURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func installConstraints() {
        let views: [String: UIView] = [
            "player1ImageView": player1ImageView,
            "player2ImageView": player2ImageView,
            "player1Label": player1Label,
            "player2Label": player2Label
        ]
        
        player1Label.translatesAutoresizingMaskIntoConstraints = false
        player2Label.translatesAutoresizingMaskIntoConstraints = false
        player1ImageView.translatesAutoresizingMaskIntoConstraints = false
        player2ImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[player1ImageView(==150)]-[player1Label(==20)]", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[player1ImageView(==150)]", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[player2ImageView(==150)]-[player2Label(==20)]", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:[player2ImageView(==150)]-25-|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[player1Label(==150)]", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:[player2Label(==150)]-25-|", options: [], metrics: nil, views: views)
        ]
        NSLayoutConstraint.activate(constraints.flatMap({ $0 }))
    }
}
