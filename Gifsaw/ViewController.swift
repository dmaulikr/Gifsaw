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
        puzzleViewController?.view.center.x = view.center.x
        addChildViewController(puzzleViewController!)
        view.addSubview((puzzleViewController?.view)!)
        puzzleViewController?.didMove(toParentViewController: self)
    }

    func searchButtonPressed() {
        let searchViewController = CollectionViewController(resource: Category.all, columns: 2, configure: { (cell: CategoryCell, category) in
            cell.label.text = category.name
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: category.jpg), options: [.transition(.fade(0.1))])
        })
        searchViewController.title = "Search"
        searchViewController.didSelect = { category in
            let resource = Resource<[MediaItem]>(url: URL(string:"https://api.popkey.co/v2/categories/\(category.id)/media")!, parseJSON: { data in
                guard let json = data as? [JSONDictionary] else { return nil }
                return json.flatMap(MediaItem.init)
            })

            let mediaViewController = CollectionViewController(resource: resource, columns: 3, configure: { (cell: MediaCell, media) in
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: URL(string: media.jpg), options: [.transition(.fade(0.1))])
            })
            mediaViewController.title = category.name
            mediaViewController.didSelect = { media in
                let previewViewController = PreviewViewController(media: media)
                previewViewController.delegate = self
                self.navigationController?.pushViewController(previewViewController, animated: true)
            }
            
            self.navigationController?.pushViewController(mediaViewController, animated: true)
        }
        
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}
