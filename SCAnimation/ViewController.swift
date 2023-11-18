//
//  ViewController.swift
//  SCAnimation
//
//  Created by Юрий Степанчук on 18.11.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var squareView: UIView = {
        let squareView = UIView()
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = UIColor.blue
        return squareView
    }()

    private var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        addTapGesture()
        view.addSubview(squareView)
        NSLayoutConstraint.activate([
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        animator?.stopAnimation(true)

        let tapPoint = gesture.location(in: view)
        let distance = sqrt(pow(tapPoint.x - self.squareView.center.x, 2) + pow(tapPoint.y - self.squareView.center.y, 2))
        let duration = TimeInterval(min(distance / 200.0, 2.0))

        animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.5, animations: {
            self.squareView.center = tapPoint
            self.squareView.transform = self.squareView.transform.rotated(by: .pi / 6.0)
            })

        animator?.addAnimations({
            self.squareView.transform = .identity
        }, delayFactor: 0.2)

        animator?.startAnimation()
    }
}
