//
//  AllLeaguesViewController.swift
//  SportApp
//
//  Created by Menna Setait on 03/02/2024.
//

import UIKit

class AllLeaguesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - Variables Declaration
    @IBOutlet weak var leaguesTableView: UITableView!
    var bindResultToViewController: (() -> Void)?
    var modelView : AllLeague?
    var array: [League]?
    var indicator : UIActivityIndicatorView?
    var networking : NetworkServiceDelegate?
    var sportType : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        setIndicator()
        print("2")
        configureLeagueTableView()
        print("3")
        configureLoadingData()
        

    }
    
    
    //MARK: - Indicator initializing
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    
    }
    
    //MARK: - Configure data loading
    func configureLoadingData(){
        print("load.1")
        
        networking = NetworkServices(setUrl: HandelURL(sportType: (self.sportType)!))
        print("load.2")
        modelView = AllLeague(networkHandler: networking)
        print("load.3")
        modelView?.getDataFromApiForLeagues()
        print("load.4")
        modelView?.bindResultToViewController = { [weak self] in
            print("load.5")
            DispatchQueue.main.async {
                self?.array = self?.modelView?.getLeaguesArray()
                print("dispatchQueue")
                self?.indicator?.stopAnimating()
                self?.leaguesTableView.reloadData()
            }
            
        }
       
    }
    
    //MARK: - Configure the TableView (source,delegate,nib cell)
    func configureLeagueTableView(){
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        self.navigationController?.navigationBar.topItem?.title = "Sport Leagues"
        leaguesTableView.register(UINib(nibName: K.customNibNameLeagues, bundle: nil), forCellReuseIdentifier: K.customNibNameIdentfier)
        
    }
    
    
    //MARK: - Configure Cell in Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.customNibNameIdentfier, for: indexPath) as! LeaguesTableViewCell
        cell.configureCell(league: array![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: K.leaguesDetailsId) as! LeagueDeatilsVC
        nextVC.sportType = self.sportType
        print(nextVC.sportType)
        nextVC.sportId = array?[indexPath.row].league_key
        print( nextVC.sportId)
        self.present(nextVC, animated: true)
    }
    

    
}
