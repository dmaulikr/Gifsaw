//
//  CollectionViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-05.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

final class CollectionViewController<Item, Cell: UICollectionViewCell>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var items: [Item] = []
    var columns: Int
    let reuseIdentifier = "Cell"
    let configure: (Cell, Item) -> ()
    var didSelect: (Item) -> () = { _ in }
    
    init(resource: Resource<[Item]>, columns: Int, configure: @escaping (Cell, Item) -> ()) {
        self.columns = columns
        self.configure = configure
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)

        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.center = view.center
        spinner.color = UIColor.white
        view.addSubview(spinner)
        spinner.startAnimating()
        
        PopkeyAPI.load(resource) { result in
            spinner.removeFromSuperview()
            guard
                let items = result
            else {
                let label = UILabel(frame: self.view.frame)
                label.textColor = .white
                label.text = "Could not download gifs :~("
                label.textAlignment = .center
                self.view.addSubview(label)
                return
            }
            self.items = items
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        view.backgroundColor = .black
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    // Flow layout delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double(view.frame.size.width) / Double(columns)
        let height = Double(width / (4/3))
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
