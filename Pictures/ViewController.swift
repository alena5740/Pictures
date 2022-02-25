//
//  ViewController.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Контроллер для отображения списка картинок
final class ViewController: UIViewController {
    
    private var page = 1
    private var assembly: AssemblyProtocol?
    
    var presenter: PresenterProtocol?
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(assembly: AssemblyProtocol) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigation()
        setupTableView()
        presenter?.getData(page: page)
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Pictures"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        makeConstraintsTableView()
    }
    
    private func makeConstraintsTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func showSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0),
                               width: tableView.bounds.width, height: CGFloat(144))
        spinner.backgroundColor = .white
        spinner.color = .systemGray
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter?.getModelArray().count
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier,
                                                 for: indexPath) as? TableViewCell
        if let model = presenter?.getModelArray()[indexPath.row] {
            cell?.configure(model: model)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let count = presenter?.getModelArray().count ?? 0
        if indexPath.row == count - 5 {
            showSpinner()
            if page != presenter?.pageCount {
                page += 1
            }
            presenter?.getData(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = presenter?.getModelArray()[indexPath.row] else { return }
        if let imageViewController = assembly?.pushToViewControllerImage(model: model) {
            self.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
}

// MARK: - ViewOutputProtocol
extension ViewController: ViewOutputProtocol {
    func updateView() {
        tableView.reloadData()
    }
}

