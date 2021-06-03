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
    private var network: Network
    private var roomId: Int
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.network = Network()
        self.roomId = 0
        self.roomInformationViewDataSource = RoomInformationViewDataSource.init(searchResult: SearchResult(properties: []))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.network = Network()
        self.roomId = 0
        self.roomInformationViewDataSource = RoomInformationViewDataSource.init(searchResult: SearchResult(properties: []))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "숙소찾기"
        self.roomInformationCollectionView.dataSource = roomInformationViewDataSource
    }
    
    func insert(searchResult: SearchResult) {
        self.roomInformationViewDataSource.update(searchResult: searchResult)
        self.roomInformationCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)

        if segue.identifier == "MapViewController" {
            guard let viewController = segue.destination as? MapViewController else {
                return
            }
            viewController.insert(searchResult: self.roomInformationViewDataSource.searchResult)
        } else {
            guard let viewController = segue.destination as? RoomDetailInformationController else {
                return
            }
            requestRoomDetail(path: roomId, nextViewController: viewController)
        }

    }
    
    @IBAction func mapButtonTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "MapViewController", sender: sender)
    }
    
    func requestRoomDetail(path: Int, nextViewController: RoomDetailInformationController) {
        let endPoint = RoomDetailAPIEndPoint(path: "/rooms/\(path)", httpMethod: .get)
        network.request(with: endPoint, dataType: RoomDetailModel.self, completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                nextViewController.insert(roomDetail: data)
            }
        })
    }
}

extension RoomInformationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.roomId = indexPath.row + 1
        performSegue(withIdentifier: "RoomDetailInformationController", sender: nil)
    }
}
