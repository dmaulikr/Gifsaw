//
//  TagsViewController.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-11.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout

//class TagCell: UICollectionViewCell {
//    
//    var label: UILabel!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
//        isOpaque = true
//        backgroundColor = UIColor(red: 0, green: 118/255, blue: 255, alpha: 1)
//        
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowRadius = 1
//        self.layer.shadowColor = UIColor.black.cgColor
//        label = UILabel(frame: contentView.bounds)
//        label.autoresizingMask = .flexibleWidth
//        label.font = UIFont.boldSystemFont(ofSize: 17)
//        label.textColor = UIColor.white
//        label.textAlignment = .center
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowOffset = CGSize(width: 0, height: 1)
//        label.layer.shadowRadius = 0.0
//        label.layer.shadowOpacity = 0.5
//        contentView.addSubview(label)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class TagsViewController: UIViewController {
//    
//    var collectionView: UICollectionView!
//    var tags: [String]?
//    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        configureSpinner()
//        configureCollection()
//        spinner.startAnimating()
//        GfycatAPI.load(Tags.all) { result in
//            self.spinner.stopAnimating()
//            guard let tags = result else { return }
//            self.tags = tags
//            DispatchQueue.main.async {
//                self.view.addSubview(self.collectionView)
//                self.collectionView.reloadData()
//            }
//        }
//    }
//    
//    override func viewDidLoad() {
//        extendedLayoutIncludesOpaqueBars = true
//        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
//        title = "Tags"
//        view.backgroundColor = UIColor(red: 254/255.0, green: 40/255.0, blue: 81/255.0, alpha: 1)
//    }
//
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureCollection() {
//        let flowLayout = LeftAlignedCollectionViewFlowLayout()
//        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
//        collectionView.backgroundColor = UIColor(red: 254/255, green: 40/255, blue: 81/255, alpha: 1)
//        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
//        collectionView.dataSource = self
//        collectionView.isScrollEnabled = true
//        collectionView.bounces = true
//        collectionView.alwaysBounceVertical = true
//        collectionView.delegate = self
//        let margin = view.frame.size.width / 50
//        collectionView.contentInset = UIEdgeInsets(top: 64 + margin, left: margin, bottom: margin, right: margin)
//    }
//    
//    func configureSpinner() {
//        spinner.hidesWhenStopped = true
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
//        spinner.color = UIColor.white
//        view.addSubview(spinner)
//        spinner.center = view.center
//    }
//}
//
//extension TagsViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard tags != nil else { return 0 }
//        return tags!.count
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
//        let tag = tags?[indexPath.row]
//        cell.label.text = "#" + tag!
//        return cell
//    }
//}
//
//extension TagsViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let gifsViewController = GifsViewController(tag: (tags?[indexPath.row])!)
//        navigationController?.pushViewController(gifsViewController, animated: true)
//    }
//}
//
//extension TagsViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let string = "#" + (self.tags?[indexPath.row])!
//        let size = string.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)])
//        let width = Int(size.width) + 8
//        return CGSize(width: width, height: 40)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//}
//
//class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//        
//        var leftMargin = sectionInset.left
//        var maxY: CGFloat = -1.0
//        attributes?.forEach { layoutAttribute in
//            if layoutAttribute.frame.origin.y >= maxY {
//                leftMargin = sectionInset.left
//            }
//            
//            layoutAttribute.frame.origin.x = leftMargin
//            
//            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//            maxY = max(layoutAttribute.frame.maxY , maxY)
//        }
//        
//        return attributes
//    }
//}
