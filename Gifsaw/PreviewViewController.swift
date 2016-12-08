//
//  PreviewViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-15.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher

class PreviewViewController: UIViewController {
    
    var size = CGRect.zero
    var offset: CGFloat = 0
    var grid: GridView? = nil
    var media: MediaItem? = nil
    var difficulty = (0, 0)
    var delegate: PuzzleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playPressed() {
        let puzzle = Puzzle(media: self.media!, difficulty: difficulty)
        delegate?.display(puzzle)
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func difficultyChanged(sender: UISegmentedControl) {
        grid?.removeFromSuperview()
        
        switch sender.selectedSegmentIndex {
        case 0:
            difficulty = Difficulty.easy
            grid = GridView(frame: CGRect(x: offset, y: 0, width: size.width, height: size.height), difficulty: difficulty)
        case 1:
            difficulty = Difficulty.medium
            grid = GridView(frame: CGRect(x: offset, y: 0, width: size.width, height: size.height), difficulty: difficulty)
        case 2:
            difficulty = Difficulty.hard
            grid = GridView(frame: CGRect(x: offset, y: 0, width: size.width, height: size.height), difficulty: difficulty)
        default: break
        }
        
        if grid != nil {
            view.addSubview(grid!)
        }
    }
}

extension PreviewViewController {
    
    convenience init(media: MediaItem) {
        self.init(nibName: nil, bundle: nil)
        self.media = media
        let container = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 64) // We don't want active calls to change the size of the puzzle so we hardcode this value :~(
        self.size = AVMakeRect(aspectRatio: media.size, insideRect: container)
        self.offset = ((view.frame.size.width - size.width) / 2)
        
        let url = URL(string: media.gif)!
        let playerView = UIView(frame: self.size)
        let gifView = UIImageView(frame: CGRect(x: 0, y: 0, width: playerView.frame.height, height: playerView.frame.width))
        gifView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        gifView.contentMode = .scaleAspectFit
        gifView.frame.origin = CGPoint.zero
        gifView.kf.indicatorType = .activity
        gifView.kf.setImage(with: url, options: [.transition(.fade(0.1))]) { _ in
            self.difficulty = Difficulty.easy
            self.grid = GridView(frame: CGRect(x: self.offset, y: 0, width: self.size.width, height: self.size.height), difficulty: self.difficulty)
            self.grid?.layer.zPosition = 5.0
            self.view.addSubview(self.grid!)
    
            self.addSegmentedControl()
            self.addPlayButton()
        }
        
        playerView.addSubview(gifView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        playerView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    func addSegmentedControl() {
        let items = ["Easy", "Medium", "Hard"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .black
        segmentedControl.addTarget(self, action: #selector(difficultyChanged(sender:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
        
        UIView.animate(withDuration: 0.1) {
            segmentedControl.tintColor = .groupTableViewBackground
        }
    }
    
    func addPlayButton() {
        let playButton = UIButton(type: .custom)
        playButton.setTitle("Create new puzzle", for: .normal)
        playButton.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        playButton.backgroundColor = .green
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        playButton.layer.zPosition = 10
        view.addSubview(playButton)
        
        playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        
        UIView.animate(withDuration: 0.1) {
            playButton.backgroundColor = .green
        }
    }
}
