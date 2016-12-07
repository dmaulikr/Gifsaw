//
//  ViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-04.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, PuzzleDelegate {
    
    var puzzleViewController: PuzzleViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gifsaw"
        view.backgroundColor = .black
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func display(_ puzzle: Puzzle) {
        if puzzleViewController != nil {
            puzzleViewController?.willMove(toParentViewController: nil)
            puzzleViewController?.view.removeFromSuperview()
            puzzleViewController?.removeFromParentViewController()
        }
        
        let container = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 64) // We don't want active calls to change the size of the puzzle so we hardcode this value :~(
        let size = AVMakeRect(aspectRatio: puzzle.media.size, insideRect: container)
        puzzleViewController = PuzzleViewController(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), puzzle: puzzle)
        puzzleViewController?.view.frame.origin = CGPoint.zero
        addChildViewController(puzzleViewController!)
        view.addSubview((puzzleViewController?.view)!)
        puzzleViewController?.didMove(toParentViewController: self)
    }

    func searchButtonPressed() {
        let categoryViewController = CategoryViewController()
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
}
