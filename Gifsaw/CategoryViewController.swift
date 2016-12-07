//
//  CategoryViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-05.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var items: [Category] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Search"
        let spinner = makeSpinner()
        view.addSubview(spinner)
        spinner.startAnimating()
        PopkeyAPI.load(Category.all) { result in
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
            let collectionView = self.makeCollectionView()
            DispatchQueue.main.async {
                self.view.addSubview(collectionView)
            }
        }
    }
    
    override func viewDidLoad() {
        automaticallyAdjustsScrollViewInsets = false
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        view.backgroundColor = .black
    }
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = true
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .black
        collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        return collectionView
    }
    
    func makeSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        spinner.center = view.center
        spinner.color = UIColor.white
        return spinner
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = items[indexPath.row]
        cell.label.text = category.name
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: URL(string: category.jpg), options: [.transition(.fade(0.1))])
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        let resource = Resource<[MediaItem]>(url: URL(string:"https://api.popkey.co/v2/categories/\(item.id)/media")!, parseJSON: { data in
            guard let json = data as? [JSONDictionary] else { return nil }
            return json.flatMap(MediaItem.init)
        })
        
        let mediaViewController = MediaViewController(resource: resource, title: item.name)
        navigationController?.pushViewController(mediaViewController, animated: true)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double(view.frame.size.width) / 2
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
