//
//  Player.swift
//  Matchup
//
//  Created by Daniel Burke on 1/1/17.
//  Copyright © 2017 Daniel Burke. All rights reserved.
//

import Foundation
import UIKit

struct Player {
    let imageURL: String
    let name: String
    let rating: Int
    
    init?(dict: [String: Any]) {
        guard
            let imageURL = dict["imageURL"] as? String,
            let name = dict["name"] as? String,
            let rating = dict["rating"] as? Int else {
                return nil
        }
        
        self.imageURL = imageURL
        self.name = name
        self.rating = rating
    }
}

var players = [
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/BRA371156.png", "name": "Tom Brady", "rating": 112],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/CAR358797.png", "name": "Derek Carr", "rating": 97],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/ROD339293.png", "name": "Aaron Rodgers", "rating": 104],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/RYA238179.png", "name": "Matt Ryan", "rating": 117],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/PRE285723.png", "name": "Dak Prescott", "rating": 105],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/ROE750381.png", "name": "Ben Roethlisberger", "rating": 95],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/NEW693984.png", "name": "Cam Newton", "rating": 76],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/BRE229498.png", "name": "Drew Brees", "rating": 102],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/COU709400.png", "name": "Kirk Cousins", "rating": 98],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/STA134157.png", "name": "Matthew Stafford", "rating": 93],
    ["imageURL": "https://static.nfl.com/static/content/public/static/img/fantasy/transparent/200x200/TAY764868.png", "name": "Tyrod Taylor", "rating": 90]
]
