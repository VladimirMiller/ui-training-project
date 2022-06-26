//
//  RatingViewController.swift
//  ui-training-project
//
//  Created by Vladimir Miller on 13.06.2022.
//

import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updatePaths()
    }
    
    private func startAnimation() {
        // mock
        let strokeEnd = 1.0
        let strokeStart = 0
        
        progressLineLayer.strokeEnd = strokeEnd
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = strokeStart
        animation.toValue = strokeEnd
        animation.duration = 3
        
        progressLineLayer.add(animation, forKey: "strokeEndAnimation")
    }
    
    private func resetAnimation() {
        progressLineLayer.strokeEnd = 0
        progressLineLayer.removeAllAnimations()
    }
    
    @objc func onPlayButtonTap() {
        resetAnimation()
        startAnimation()
    }
    
    private func updatePaths() {
        let path = UIBezierPath(arcCenter: CGPoint(x: progressView.bounds.midX, y: progressView.bounds.midY),
                                radius: 100,
                                startAngle: 3 * CGFloat.pi / 4,
                                endAngle: CGFloat.pi / 4,
                                clockwise: true
                    ).cgPath
        
        progressBackgroundLayer.path = path
        progressLineLayer.path = path
    }
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 200),
            progressView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        progressView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        startButton.addTarget(self, action: #selector(onPlayButtonTap), for: .touchUpInside)
    }
    
    private func setupLayers() {
        progressView.layer.addSublayer(progressBackgroundLayer)
        progressView.layer.addSublayer(progressLineLayer)
    }
    
    // MARK: Views
    fileprivate lazy var progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .red
        label.text = "0"
        return label
    }()
    
    fileprivate lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
        return button
    }()
    
    // MARK: Layers
    fileprivate lazy var progressBackgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = nil
        return layer
    }()
    
    fileprivate lazy var progressLineLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = nil
        layer.lineCap = .round
        layer.strokeEnd = 0
        return layer
    }()
}

