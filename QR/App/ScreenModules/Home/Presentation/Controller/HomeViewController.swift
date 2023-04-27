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
    
    // MARK: CUSTOM VIEW
    
    let videoView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var toggleFlashlightButton: UIButton = {
        let view = UIButton()
        view.contentHorizontalAlignment = .center
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIText-Bold", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Mantené el código QR dentro del recuadro, se escaneará automáticamente."
        return label
    }()
    
    var flashLightButtonImageOn: UIImage? {
        return UIImage(named: "btnLinternaOnEminent")
    }
    
    var flashLightButtonImageOff: UIImage? {
        return UIImage(named: "btnLinternaOffEminent")
    }
    
    private func viewFinderFrame (frame: CGRect) -> CGRect {
        let lateral = frame.size.width - 96
        let xOffset: CGFloat = frame.midX - lateral * 0.5
        let yOffset: CGFloat = frame.midY - lateral * 0.5

        let navbarHeight = 0.0

        let rect = CGRect(x: xOffset, y: yOffset - navbarHeight, width: lateral, height: lateral)
        return rect
    }
    
    private func createOverlay(frame: CGRect) -> UIView {
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        let path = CGMutablePath()

        let rect = self.viewFinderFrame(frame: frame)
        let roundRect = UIBezierPath(roundedRect: rect, cornerRadius: 20.0).cgPath

        path.addPath(roundRect)
        path.addRect(CGRect(origin: .zero, size: frame.size))
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd

        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        return overlayView
    }
    
    private func viewFinderLayer(frame: CGRect) -> CAShapeLayer {
        let finderLayer = CAShapeLayer()

        finderLayer.frame = frame
        finderLayer.lineWidth = 4.0
        let halfLineWidth = finderLayer.lineWidth * 0.5
        finderLayer.strokeColor = UIColor.white.cgColor
        finderLayer.fillColor = nil

        let leftTopLayerPath = UIBezierPath()
        leftTopLayerPath.lineJoinStyle = .round
        leftTopLayerPath.lineCapStyle = .round
        leftTopLayerPath.move(to: CGPoint(x: halfLineWidth, y: (frame.height * 0.5) - 30 ))

        leftTopLayerPath.addLine(to: CGPoint(x: halfLineWidth, y: 20.0 + halfLineWidth))

        leftTopLayerPath.addQuadCurve(to: CGPoint(x: 20 + halfLineWidth, y: halfLineWidth), controlPoint: CGPoint(x: halfLineWidth, y: halfLineWidth))
        leftTopLayerPath.addLine(to: CGPoint(x: (frame.width * 0.5) - 30, y: halfLineWidth))

        var pathTransform = CGAffineTransform.identity
        pathTransform = pathTransform.translatedBy(x: frame.height, y: 0.0)
        pathTransform = pathTransform.rotated(by: .pi * 0.5)

        let rightTopLayerPath = UIBezierPath(cgPath: leftTopLayerPath.cgPath)
        rightTopLayerPath.apply(pathTransform)

        let rightBottonLayerPath = UIBezierPath(cgPath: rightTopLayerPath.cgPath)
        rightBottonLayerPath.apply(pathTransform)

        let leftBottonLayerPath = UIBezierPath(cgPath: rightBottonLayerPath.cgPath)
        rightBottonLayerPath.apply(pathTransform)

        let viewFinderPath = UIBezierPath()
        viewFinderPath.append(leftTopLayerPath)
        viewFinderPath.append(rightTopLayerPath)
        viewFinderPath.append(rightBottonLayerPath)
        viewFinderPath.append(leftBottonLayerPath)

        finderLayer.path = viewFinderPath.cgPath

        return finderLayer
    }
    
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
        
        let overlay = createOverlay(frame: view.frame)
        let viewFinder = viewFinderLayer(frame: viewFinderFrame(frame: view.frame))
        
        videoView.layer.addSublayer(viewFinder)
        videoView.addSubview(overlay)
        
        view.addSubview(videoView)
        view.addSubview(infoLabel)
        view.addSubview(toggleFlashlightButton)
        
        view.addSubview(qrView)
        view.addSubview(qrButton)
    }
    
    private func setupConstraints() {
        
        videoView.setConstraints(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)
        infoLabel.setConstraints(top: view.topAnchor, right: view.rightAnchor , left:view.leftAnchor, pTop: 90, pRight: 25, pLeft: 25)
        toggleFlashlightButton.centerX()
        toggleFlashlightButton.setConstraints(bottom: view.bottomAnchor, pBottom: -30)
        
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
    
    // MARK: EVENT
    @objc func redirectQR() {
        viewModel.requestCameraAccess()
    }
}

extension HomeViewController : SpinnerDisplayable { }

extension HomeViewController : MessageDisplayable { }
