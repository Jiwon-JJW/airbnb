//
//  RoomInformationViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/05/24.
//

import UIKit

class RoomInformationViewController: UIViewController {
    @IBOutlet weak var roomInformationCollectionView: UICollectionView!
    
    private var roomInformationViewDataSource: RoomInformationViewDataSource
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.roomInformationViewDataSource = RoomInformationViewDataSource.init(searchResult: SearchResult(properties: []))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.roomInformationViewDataSource = RoomInformationViewDataSource.init(searchResult: SearchResult(properties: []))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "숙소찾기"
        self.roomInformationCollectionView.dataSource = roomInformationViewDataSource
        self.roomInformationCollectionView.setContentOffset((roomInformationCollectionView.cellForItem(at: IndexPath(row: 3, section: 0))?.frame.origin)!, animated: true)
    }
    
    func insert(searchResult: SearchResult) {
        self.roomInformationViewDataSource.update(searchResult: searchResult)
        self.roomInformationCollectionView.reloadData()
    }
}
