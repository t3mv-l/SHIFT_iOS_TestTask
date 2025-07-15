//
//  MainViewController.swift
//  SHIFT_iOS_TestTask
//
//  Created by Артём on 15.07.2025.
//

import UIKit

struct StoreElement: Codable {
    let id: Int
    let title: String
    let price: Double
}

class MainViewController: UIViewController {
    
    var storeElements: [StoreElement] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        fetchApi()
        super.viewDidLoad()
    }
    
    func fetchApi() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode([StoreElement].self, from: data)
                self.processStoreElements(decodedResponse)
            } catch {
                print("Не удалось открыть json")
            }
        }
        task.resume()
    }
    
    func processStoreElements(_ storeElements: [StoreElement]) {
        DispatchQueue.main.async {
            self.storeElements = storeElements
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = storeElements[indexPath.row].title
        config.secondaryText = "\(storeElements[indexPath.row].price)"
        cell.contentConfiguration = config
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
