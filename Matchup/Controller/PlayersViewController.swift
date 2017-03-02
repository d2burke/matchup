//
//  PlayersViewController.swift
//  Matchup
//
//  Created by Daniel Burke on 3/1/17.
//  Copyright © 2017 Daniel Burke. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    var checkedCells = Set<IndexPath>()
    
    let disabledGray = UIColor.lightGray.withAlphaComponent(0.5)
    
    lazy var compareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Compare", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 6
        button.isEnabled = false
        button.backgroundColor = self.disabledGray
        return button
    }()
    
    let playerTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        compareButton.addTarget(self, action: #selector(PlayersViewController.didTapCompareButton), for: .touchUpInside)
        view.addSubview(compareButton)
        
        playerTableView.delegate = self
        playerTableView.dataSource = self
        view.addSubview(playerTableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(PlayersViewController.logOut))
        
        installConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let _ = UserDefaults.standard.object(forKey: "LoggedIn") else {
            presentLogin()
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapCompareButton(button: UIButton) {
        let indexPaths = Array(checkedCells)
        
        guard let indexPath1 = indexPaths.first,
            let indexPath2 = indexPaths.last,
            let player1 = Player(dict: players[indexPath1.row]),
            let player2 = Player(dict: players[indexPath2.row])
        else { return }
        
        let matchupView = MatchupViewController(player1: player1, player2: player2)
        navigationController?.pushViewController(matchupView, animated: true)
    }
    
    func installConstraints() {
        let views: [String: Any] = [
            "compareButton": compareButton,
            "playerTableView": playerTableView
        ]
        
        compareButton.translatesAutoresizingMaskIntoConstraints = false
        playerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[compareButton(==50)]-15-[playerTableView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[compareButton]-15-|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[playerTableView]|", options: [], metrics: nil, views: views)
        ]
        
        NSLayoutConstraint.activate(constraints.flatMap({ $0 }))
    }
    
    func presentLogin() {
        //Get view from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier :"Login") as? LoginViewController
        else { return }
        
        loginViewController.delegate = self
        present(loginViewController, animated: false, completion: nil)
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "LoggedIn")
        presentLogin()
    }
}

extension PlayersViewController: LoginViewControllerDelegate {
    func didLogin() {
        UserDefaults.standard.set("yes", forKey: "LoggedIn")
        dismiss(animated: true, completion: nil)
    }
}

extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = Player(dict: players[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = player?.name
        
        let isSelected = checkedCells.contains(indexPath)
        cell.accessoryType = isSelected ? .checkmark : .none
        
        if checkedCells.count == 2 {
            cell.textLabel?.textColor = isSelected ? .black : disabledGray
            cell.isUserInteractionEnabled = isSelected ? true : false //we want to be able to deselect
        } else {
            cell.textLabel?.textColor = .black
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
}

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if checkedCells.contains(indexPath) {
            checkedCells.remove(indexPath)
        } else {
            checkedCells.insert(indexPath)
        }
        
        let readyToCompare = checkedCells.count == 2
        let color: UIColor = readyToCompare ? .white : .gray
        let backgroundColor: UIColor = readyToCompare ? .blue : disabledGray
        
        compareButton.setTitleColor(color, for: .normal)
        compareButton.backgroundColor = backgroundColor
        compareButton.isEnabled = readyToCompare
        
        playerTableView.reloadData()
    }
}
