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
    let greetingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setGreetingButton()
        setTableView()
        setConstraints()
        
        fetchApi()
    }
    
    func setGreetingButton() {
        greetingButton.setTitle("Приветствие", for: .normal)
        greetingButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        greetingButton.backgroundColor = .systemBlue
        greetingButton.setTitleColor(.white, for: .normal)
        greetingButton.layer.cornerRadius = 10
        greetingButton.addTarget(self, action: #selector(greetingButtonTapped), for: .touchUpInside)
        greetingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingButton)
    }
    
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            greetingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            greetingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingButton.widthAnchor.constraint(equalToConstant: 180),
            greetingButton.heightAnchor.constraint(equalToConstant: 44),
                        
            tableView.topAnchor.constraint(equalTo: greetingButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func greetingButtonTapped() {
        let readUserName = UserDefaults.standard.string(forKey: "userName") ?? "пользователь"
        let alert = UIAlertController(title: "Приветствие", message: "Здравствуйте, \(readUserName)! Добро пожаловать!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
