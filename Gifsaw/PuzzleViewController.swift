//
//  PuzzleViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-19.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit
import Kingfisher
import Gifu
import SAConfettiView

extension GIFImageView {
    
    convenience init(frame: CGRect, images: [UIImage]) {
        self.init(frame: frame)
        animationImages = images
        animationDuration = Double(images.count) * 0.08 // Not a significant value, just works well in majority of cases
        startAnimating()
    }
}

class PuzzleViewController: UIViewController {
    
    var puzzle: Puzzle!
    var rects: [CGRect] = []
    var tiles: [UIView] = []
    var hasSelection = false
    var selectedTile: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleTap(_ sender: UIGestureRecognizer) {
        guard sender.state == UIGestureRecognizerState.ended else { return }
        let location = sender.location(in: view)
        guard let container = view.subviews.first else { return }
        guard let tile = container.subviews.filter({ $0.frame.contains(location) }).first else { return }
        
        if hasSelection {
            selectedTile?.layer.borderColor = UIColor.clear.cgColor
            tile.layer.borderColor = UIColor.clear.cgColor
            let frame = tile.frame
            tile.frame = (selectedTile?.frame)!
            selectedTile?.frame = frame
            selectedTile = nil
        } else {
            selectedTile = tile
            tile.layer.borderColor = UIColor.red.cgColor
            tile.layer.borderWidth = 2.0
        }
        hasSelection = !hasSelection

        let solution = container.subviews.enumerated().map {
            (floor($0.1.frame.origin.x) == floor(rects[$0.0].origin.x) && floor($0.1.frame.origin.y) == floor(rects[$0.0].origin.y))
        }
        if !solution.contains(false) {
            confetti()
        }
    }
    
    func confetti() {
        let container = UIView(frame: view.bounds)
        self.view.addSubview(container)
        let confettiView = SAConfettiView(frame: container.bounds)
        container.addSubview(confettiView)
        confettiView.startConfetti()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { confettiView.stopConfetti() })
    }
}

extension PuzzleViewController {
    
    convenience init(frame: CGRect, puzzle: Puzzle) {
        self.init()
        view.frame = frame
        self.puzzle = puzzle
        let container = UIView(frame: view.frame)
        view.addSubview(container)
        load(media: puzzle.media) { images in
            let images = self.process(images: images)
            for (index, rect) in self.rects.enumerated() {
                let tile = UIView(frame: rect)
                let gif = GIFImageView(frame: tile.bounds, images: images[index])
                tile.addSubview(gif)
                
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                tile.addGestureRecognizer(recognizer)
                
                self.tiles.append(tile)
                container.addSubview(tile)
            }
            var shuffled = self.rects
            shuffled.shuffle()
            let _ = self.tiles.enumerated().map { $0.element.frame = shuffled[$0.offset] }
        }
    }
}

extension PuzzleViewController {
    
    func load(media: MediaItem, completion: @escaping ([UIImage]) -> ()) {
        ImageCache.default.retrieveImage(forKey: media.gif, options: nil) { image, _ in
            guard let image = image else { return }
            guard let images = image.images else { return }
            completion(images)
        }
    }
    
    func process(images: [UIImage]) -> [[UIImage]] {
        let rotated = images.map { $0.rotate(by: 90, flip: false) }
        let scaled = rotated.map { $0.scale(to: view.frame.size) }
        rects = self.makeTileRects(from: scaled[0])
        let unsortedTiles = scaled.map { self.makeTiles(from: $0, rects: rects) }
        let tiles = self.sort(unsortedTiles)
        return tiles
    }
    
    private func makeTileRects(from image: UIImage) -> [CGRect] {
        
        func makePoints(length: CGFloat, count: Int) -> [CGFloat] {
            var points: [CGFloat] = []
            for i in 0..<count {
                let point = length * CGFloat(i)
                points.append(point)
            }
            return points
        }
        
        let width = view.frame.size.width / CGFloat(puzzle.difficulty.0)
        let height = view.frame.size.height / CGFloat(puzzle.difficulty.1)
        let xPoints = makePoints(length: width, count: puzzle.difficulty.0)
        let yPoints = makePoints(length: height, count: puzzle.difficulty.1)
        let xCoordinates = xPoints.map { CGPoint(x: $0, y: 0) }
        let yCoordinates = yPoints.map { CGPoint(x: 0, y: $0) }
        
        var origins: [CGPoint] = []
        for yCoord in yCoordinates {
            for xCoord in xCoordinates {
                let origin = CGPoint(x: xCoord.x, y: yCoord.y)
                origins.append(origin)
            }
        }
        let rects = origins.map { CGRect(origin: $0, size: CGSize(width: width, height: height)) }
        return rects
    }
    
    
    private func makeTiles(from image: UIImage, rects: [CGRect]) -> [UIImage] {
        var tiles = [UIImage]()
        for rect in rects {
            if let cgImage = image.cgImage!.cropping(to: rect) {
                let tile = UIImage(cgImage: cgImage)
                tiles.append(tile)
            }
        }
        return tiles
    }
    
    private func sort(_ tiledFrames: [[UIImage]]) -> [[UIImage]] {
        var sortedTiles = [[UIImage]]()
        
        for _ in 0..<tiledFrames[0].count {
            let tiles = [UIImage]()
            sortedTiles.append(tiles)
        }
        
        for frame in tiledFrames {
            for (index, tile) in frame.enumerated() {
                sortedTiles[index].append(tile)
            }
        }
        return sortedTiles
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
