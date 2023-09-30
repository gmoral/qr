//
//  TyCViewController.swift
//
//
//  Created by Guillermo Moral on 27/09/2023.
//

import UIKit
import Combine

class TyCViewController: UIViewController {

    // MARK: PROPERTY
    private let viewModel: TyCViewModel
    private var cancellable = Set<AnyCancellable>()

    // MARK: CUSTOM VIEW
    lazy var tycText : UITextView = {
        let t = UITextView()
        t.text = "Por la presente solicito el acceso al servicio de Online"
        return t
    }()

    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        return cancel
    }()

    lazy var aceptButton: UIButton = {
        let acept = UIButton()
        acept.setTitle("Acept", for: .normal)
        return acept
    }()


    // MARK: CONSTRUCTOR
    init(viewModel: TyCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: VIEW CIRCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        stateController()
        viewModel.viewDidLoad()
    }

    // MARK: CONTROLLER MACHINE STATES
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                //self.hideSpinner()
                switch state {

                case .start:

                    self.setupView()

                case .loadingTyC:

                    print(">>>loading TyC")

                case .loadingError:

                    print(">>>loadingError")

                case .waitingToSign:

                    print(">>>waitingToSign")

                case .signing:

                    print(">>>signing")

                case .signingError:

                    print(">>>signingError")

                case .end:

                    navigationController?.popViewController(animated: true)

                }

            }.store(in: &cancellable)

    }

    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
        setupTouchEvents()
    }

    private func buildViewHierarchy() {
        view.addSubview(tycText)
        view.addSubview(cancelButton)
        view.addSubview(aceptButton)
    }


    private func setupConstraints() {
        tycText.setConstraints(top: view.topAnchor,
                               right: view.rightAnchor,
                               bottom: view.bottomAnchor,
                               left: view.leftAnchor,
                               pBottom: 44
        )

        cancelButton.setConstraints(bottom: view.bottomAnchor,

                                    left: view.leftAnchor,

                                    pLeft: 1

        )

        cancelButton.setWidthConstraint(width: 80)

        cancelButton.setHeightConstraint(height: 44)



        aceptButton.setConstraints(right: view.rightAnchor,

                                   bottom: view.bottomAnchor,

                                   pRight: 1

        )

        aceptButton.setWidthConstraint(width: 80)

        aceptButton.setHeightConstraint(height: 44)

    }



    private func configureView() {

    }


    private func setupTouchEvents() {

        let tapGestureOnAceptButton = UITapGestureRecognizer(target: self, action: #selector(aceptButtonOnTap))
        aceptButton.addGestureRecognizer(tapGestureOnAceptButton)
        aceptButton.isUserInteractionEnabled = true


        let tapGestureOnCancelButton = UITapGestureRecognizer(target: self, action: #selector(cancelButtonOnTap))
        cancelButton.addGestureRecognizer(tapGestureOnCancelButton)
        cancelButton.isUserInteractionEnabled = true

    }



    @objc func aceptButtonOnTap() {

        viewModel.aceptTermsAndConditions()

    }



    @objc func cancelButtonOnTap() {

        viewModel.cancelTermsAndConditions()

    }

}
