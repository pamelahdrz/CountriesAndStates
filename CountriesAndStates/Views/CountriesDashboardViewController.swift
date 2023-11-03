//
//  CountriesDashboard.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 30/10/23.
//

import Foundation
import UIKit

class CountriesDashboardViewController: UIViewController {
    
    @IBOutlet var countriesTableView: UITableView!
    @IBOutlet var noCountries: UIVisualEffectView!
    
    private var viewModel = CountriesDashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCountriesView()
        self.setupView()
    }
    
    private func setupView() {
        self.viewModel.viewController = self
    }
    
    private func initCountriesView() {
        self.viewModel.fetchCountries { success, error in
            if success {
                DispatchQueue.main.async {
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                    self.countriesTableView.backgroundColor = .systemGray6
                    self.countriesTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.id)
                    self.countriesTableView.dataSource = self
                    self.countriesTableView.delegate = self
                }
            } else {
                DispatchQueue.main.async {
                    self.noCountries.isHidden = false
                    print("Error: Table not initialized")
                }
            }
        }
    }
}

extension CountriesDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.valuesResponse[section] {
        case .countries(let data) :
            self.noCountries.isHidden = true
            return data.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.valuesResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.id, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        switch self.viewModel.valuesResponse[indexPath.section] {
        case .countries(let data):
            cell.selectionStyle = .none
            cell.backgroundColor = . systemGray6
            cell.configure(with: data[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.viewModel.valuesResponse[indexPath.section] {
        case .countries(let data):
            self.viewModel.performSegue(with: data[indexPath.row])
        }
    }
}

