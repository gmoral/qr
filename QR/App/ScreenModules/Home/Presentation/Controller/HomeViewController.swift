//
//  HomeViewController.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit
import Combine

protocol HomeViewControllerCoordinator : AnyObject {
    func goToQR()
}

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private var cancellable = Set<AnyCancellable>()
    private weak var coordinator: HomeViewControllerCoordinator?
    
    lazy var qrView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "QR"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var qrButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViewHierarchy()
        setupConstraints()
        configureView()
        setupTouchEvents()
        
        stateController()
        viewModel.viewDidLoad()
    }
    
    func buildViewHierarchy() {
        view.addSubview(qrView)
        view.addSubview(qrButton)
    }
    
    func setupConstraints() {
        qrView.centerXY()
        qrView.setHeightConstraint(height: 100)
        qrView.setWidthConstraint(width: 100)
        
        qrButton.centerXY()
        qrButton.setHeightConstraint(height: 100)
        qrButton.setWidthConstraint(width: 100)
        
    }
    
    func configureView() {
        self.view.backgroundColor = .orange
    }
    
    func setupTouchEvents() {
        qrButton.addTarget(self, action: #selector(redirectQR), for: .touchUpInside)
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                    case .start:
                        print(">> Start <<")
                    case .success:
                        print("Success")
                    case .loading:
                        self?.showSpinner()
                    case .fail(error: let error):
                        self?.presentAlert(message: error, title: "Error")
                    case .authorized:
                        print("authorized")
                    case .denied:
                        print("denid")
                    case .notDetermined:
                        print("notDetermined")
                    case .restricted:
                        print("restricted")
                    case .end:
                        print("end")
                }
        }.store(in: &cancellable)
    }
    
    @objc func redirectQR() {
        viewModel.requestCameraAccess()
    }
}

extension HomeViewController : SpinnerDisplayable { }

extension HomeViewController : MessageDisplayable { }
