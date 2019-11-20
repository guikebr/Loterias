//
//  ViewController.swift
//  Loterias
//
//  Created by Guilherme Santos on 18/04/19.
//  Copyright © 2019 Guilherme Santos. All rights reserved.
//

import UIKit

enum Gametype: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe:Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber){
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumber(for: .megasena)
    }
    func showNumber(for type:Gametype){
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megasena:
                game = 6>-<60
            balls.last!.isHidden = false
        case .quina:
                game = 5>-<80
            balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func genereteGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumber(for: .megasena)
        default:
            showNumber(for: .quina)
        }
    }
}

