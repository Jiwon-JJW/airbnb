//
//  ConditionViewController.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/20.
//

import UIKit

class FindingAccommdationViewController: UIViewController {
    
    @IBOutlet weak var findingAccommdationConditionView: UIScrollView!
    
    private var findingAccommdationCondition: FindingAccommdationCondition
    
    private var calendarView: CalendarView
    private let calendarDelegate: CalendarViewDelgate
    
    @IBOutlet weak var costGraphView: CostGraphView!
    private var currentState: CurrentState
    
    @IBOutlet weak var beforeButton: UIButton!
    @IBOutlet weak var afterButton: UIButton!
    
    @IBOutlet weak var conditionTableView: UITableView!
    @IBOutlet weak var content: UIStackView!
    
    @IBOutlet weak var adultCountLabel: UILabel!
    
    private var tableViewDataSource: FindingAccommodationTableViewDataSource!
    private var costGraph = CostGraph(averagePrice: 0, numberOfRooms: [])
    
    private var network = Network()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.findingAccommdationCondition = FindingAccommdationCondition()
        self.calendarDelegate = CalendarViewDelgate(conditionData: self.findingAccommdationCondition)
        self.currentState = .date
        self.calendarView = CalendarView.init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.findingAccommdationCondition = FindingAccommdationCondition()
        self.calendarDelegate = CalendarViewDelgate.init(conditionData: self.findingAccommdationCondition)
        self.currentState = .date
        self.calendarView = CalendarView.init()
        self.tableViewDataSource = FindingAccommodationTableViewDataSource.init(condition: self.findingAccommdationCondition)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "숙소찾기"
        self.beforeButton.setTitle("", for: .normal)
        self.afterButton.setTitle("다음", for: .normal)
        initCalendarView()
        self.conditionTableView.dataSource = tableViewDataSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(conditionDataUpdate), name: Notification.conditionDataUpdate, object: findingAccommdationCondition)
        costGraphView.update(minCost: "0원", maxCost: "1,000,000원", averageCost: "")
        self.conditionTableView.dataSource = tableViewDataSource
        
        self.costGraphView.rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        guard let NextViewController = segue.destination as? RoomInformationViewController else {
            return
        }
        requestAccommdation(nextViewController: NextViewController)
    }
    
    private func requestAccommdation(nextViewController: RoomInformationViewController) {
        let requestURL = SearchResultAPIEndPoint.init(path: "/search", httpMethod: .get)
        
        Network.requestQueryString(with: requestURL, dataType: SearchResult.self, queryParameter: self.findingAccommdationCondition) { result in
            switch result {
            case .success(let data):
                nextViewController.insert(searchResult: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func takelocationBeforeController(location: String) {
        self.findingAccommdationCondition.insert(location: location)
    }
    
    private func scrollPage(currentState: CurrentState) {
        let totalWidth = CGFloat(findingAccommdationConditionView.contentSize.width)
        let viewCount = CGFloat(self.content.subviews.count)
        
        self.findingAccommdationConditionView.setContentOffset(CGPoint(x: totalWidth / viewCount * CGFloat(currentState.rawValue), y: 0), animated: true)
    }
    
    func mappingGraphValue() -> [(Int, Int)] {
        var array: [(Int, Int)] = []
        for index in 0..<costGraph.numberOfRooms.count {
            array.append((index*5, costGraph.numberOfRooms[index]))
        }
        return array
    }
    
    @IBAction func pressedPreButton(_ sender: Any) {
        if self.currentState == .date {
            return
        }
        self.currentState = currentState.previousState
        self.setButtonTitle()
        scrollPage(currentState: self.currentState)
    }
    
    @IBAction func pressedNextButton(_ sender: Any) {
        if currentState == .people {
            performSegue(withIdentifier: "RoomInformationViewController", sender: nil)
            return
        }
        self.currentState = currentState.nextState
        self.setButtonTitle()
        scrollPage(currentState: self.currentState)
    }
    
    @objc func conditionDataUpdate() {
        self.conditionTableView.reloadData()
        self.adultCountLabel.text = findingAccommdationCondition.peopleCount
        self.costGraphView.update(minCost: findingAccommdationCondition.minCostDescription, maxCost: findingAccommdationCondition.maxCostDescription, averageCost: "")
    }
    
    @IBAction func pressedPeopleMinus(_ sender: Any) {
        self.findingAccommdationCondition.update(people: 1, isAdd: false)
    }
    
    @IBAction func pressedPeoplePlus(_ sender: Any) {
        self.findingAccommdationCondition.update(people: 1, isAdd: true)
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let minCost = Int(rangeSlider.lowerValue*1000000)
        let maxCost = Int(rangeSlider.upperValue*1000000)
        findingAccommdationCondition.update(minCost: minCost)
        findingAccommdationCondition.update(maxCost: maxCost)
    }
}

extension FindingAccommdationViewController {
    
    enum CurrentState: Int {
        case date = 0
        case cost = 1
        case people = 2
        
        var nextState: Self {
            switch self {
            case .date:
                return .cost
            case .cost:
                return .people
            default:
                return .date
            }
        }
        
        var previousState: Self {
            switch self {
            case .cost:
                return .date
            case .people:
                return .cost
            default:
                return .people
            }
        }
    }
    
    func setButtonTitle() {
        switch self.currentState {
        case .date:
            self.beforeButton.setTitle("", for: .normal)
            self.afterButton.setTitle("다음", for: .normal)
        case .cost:
            self.beforeButton.setTitle("이전", for: .normal)
            self.afterButton.setTitle("다음", for: .normal)
            fetchCostGraph()
        case .people:
            self.beforeButton.setTitle("이전", for: .normal)
            self.afterButton.setTitle("검색", for: .normal)
        default:
            break
        }
    }
    
    func fetchCostGraph() {
        let endPoint = MainAPIEndPoint(path: "/search/1", httpMethod: .get)
        network.request(with: endPoint, dataType: CostGraph.self) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.costGraph = data
                self.costGraphView.chartInit(data: self.mappingGraphValue())
            }
        }
    }
}

extension FindingAccommdationViewController {
    func initCalendarView() {
        guard let contentFirst = content.subviews.first else {
            return
        }
        self.calendarView.frame = CGRect(origin: .zero, size: CGSize(width: contentFirst.frame.width * 0.9, height: contentFirst.frame.height * 0.9))
        contentFirst.addSubview(self.calendarView)
        //self.calendarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.calendarView.delegate = calendarDelegate
    }
}
