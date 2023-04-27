//
//  HomeViewController.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit
import Combine

protocol HomeViewControllerCoordinator {
    func redirectScannQR()
}

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private var cancellable = Set<AnyCancellable>()
    private var coordinator: HomeViewControllerCoordinator

    // MARK: VIEW
    
    lazy var qrView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "QR"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var qrButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: CONSTRUCTOR
    
    init(viewModel: HomeViewModel,
         coordinator: HomeViewControllerCoordinator
    ) {
       
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: VIEW CICLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViewHierarchy()
        setupConstraints()
        configureView()
        setupTouchEvents()
        
        stateController()
        viewModel.viewDidLoad()
    }
    
    // MARK: CUSTOM
    
    private func buildViewHierarchy() {
        view.addSubview(qrView)
        view.addSubview(qrButton)
    }
    
    private func setupConstraints() {
        
        qrView.centerXY()
        qrView.setHeightConstraint(height: 100)
        qrView.setWidthConstraint(width: 100)
        
        qrButton.centerXY()
        qrButton.setHeightConstraint(height: 100)
        qrButton.setWidthConstraint(width: 100)
        
    }
    
    private func configureView() {
        self.view.backgroundColor = .orange
    }
    
    private func setupTouchEvents() {
        qrButton.addTarget(self, action: #selector(redirectQR), for: .touchUpInside)
    }
    
    // MARK: STATE MACHINE
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                    case .start:
                        print(">> Start <<")
                    case .end:
                        print("end")
                }
        }.store(in: &cancellable)
    }
    
    // MARK: EVENT
    @objc func redirectQR() {
        coordinator.redirectScannQR()
    }
}

extension HomeViewController : SpinnerDisplayable { }

extension HomeViewController : MessageDisplayable { }
