//
//  MoreInfoViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-07.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    let swipeGestureRecognizer = UIPanGestureRecognizer()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var exerciseImages = [UIImageView]()
    
    var urls: [URL]? {
        didSet {
            setupViews()
        }
    }
    
    var exercise: Exercises.Exercise? {
        didSet {
            headerLabel.text = exercise?.name
            let htmlDescription = exercise?.description
            if let description = htmlDescription?.html2Attributed?.string {
                exerciseInfoTextView.text = description
            }
//            setupViews()
        }
    }
    
    let headerLabel = AddRecordLabel()
    
    let visualEffectView = UIVisualEffectView(effect: nil)
    
    let backgroundView = ActionSheetStyleBackgroundView()
    
    let exerciseInfoTextView: UITextView = {
        let view = UITextView()
        if let myFont = UIFont(name: "SFCompactDisplay-Regular", size: 14) {
            view.font = UIFontMetrics.default.scaledFont(for: myFont)
        }
        view.textColor = ThemeManager.currentTheme().textColor
        view.backgroundColor = UIColor.clear
        view.textAlignment = .left
        view.isEditable = false
        view.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 6)
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateView(visualEffectView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        reverseAnimateView(visualEffectView)
    }
    
    
    
    private func animateView(_ view: UIView) {
        UIView.animate(withDuration: 1) {
            self.visualEffectView.transform = CGAffineTransform(scaleX: 1, y: 1)
            view.alpha = 0.95
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    private func reverseAnimateView(_ view: UIView) {
        UIView.animate(withDuration: 1) {
            self.visualEffectView.transform = CGAffineTransform(scaleX: 2, y: 2)
            view.alpha = 0
        }
    }
    
    var imageViewHeightAnchor: NSLayoutConstraint?
    
    func setupViews() {
        headerLabel.textColor = ThemeManager.currentTheme().tintColor
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
        
        exerciseImages.forEach { (image) in
            image.removeFromSuperview()
        }
        exerciseImages.removeAll()
        
        let padding: CGFloat = 20
        
        if urls?.count == 2 {
            if let urls = urls {
                for url in urls {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    imageView.backgroundColor = UIColor.white
                    imageView.layer.cornerRadius = Constants.halfCornerRadius
                    imageView.layer.masksToBounds = true
                    imageView.clipsToBounds = true
                    imageView.load(url: url)
                    exerciseImages.append(imageView)
                }
            }
            imageViewHeightAnchor?.constant = urls!.count == 2 ? 44 : 0
            imageViewHeightAnchor?.isActive = true
        }
        
        let imageStackView = UIStackView(arrangedSubviews: exerciseImages)
        imageStackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        imageStackView.alignment = .center
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fillEqually
        imageStackView.spacing = 8
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let myBoldHeading = UIFont(name: "SFCompactDisplay-Bold", size: 18) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.subheadline).scaledFont(for: myBoldHeading)
            headerLabel.font = myBoldHeading
        }
        let blurEffect = UIBlurEffect(style: .dark)
        visualEffectView.effect = blurEffect
        visualEffectView.frame = view.frame
        
        view.addSubview(visualEffectView)
        view.addSubview(backgroundView)
        backgroundView.addSubview(headerLabel)
        backgroundView.addSubview(exerciseInfoTextView)
        backgroundView.addSubview(imageStackView)
        
        backgroundView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 16).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -32).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -16).isActive = true
        
        headerLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, constant: -16).isActive = true
        
        exerciseInfoTextView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        exerciseInfoTextView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
        exerciseInfoTextView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: -8).isActive = true
        
        imageStackView.topAnchor.constraint(equalTo: exerciseInfoTextView.bottomAnchor, constant: 8).isActive = true
        imageStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
        imageStackView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor).isActive = true
        imageStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16).isActive = true
        
        imageViewHeightAnchor = imageStackView.heightAnchor.constraint(equalTo: headerLabel.widthAnchor, multiplier: 5/10)
        imageViewHeightAnchor?.isActive = false
        
        exerciseInfoTextView.delegate = self
        textViewDidChange(exerciseInfoTextView)
    }
    
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            reverseAnimateView(visualEffectView)
            if touchPoint.y - initialTouchPoint.y > 0 {
                
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            animateView(visualEffectView)
            if touchPoint.y - initialTouchPoint.y > 100 {
                
                self.dismiss(animated: false, completion: nil)
            } else {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        }
    }
}

extension MoreInfoViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: headerLabel.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    
}




//let exerciseImageCache = NSCache<NSString, ExerciseImageModel>()
//var exerciseImageModel: ExerciseImageModel!
//
//
//func setupExerciseImageData() {
//
//    if let cachedVersion = exerciseImageCache.object(forKey: exerciseImageUrl as NSString) {
//        self.exerciseImageModel = cachedVersion
//    } else {
//        ExerciseAPIServices.fetchGenericData(urlString: exerciseImageUrl) { (exercisImage: ExerciseImageModel) in
//            self.exerciseImageModel = exercisImage
//            self.exerciseImageCache.setObject(self.exerciseImageModel, forKey: self.exerciseImageModel as NSString)
//        }
//    }
//}
