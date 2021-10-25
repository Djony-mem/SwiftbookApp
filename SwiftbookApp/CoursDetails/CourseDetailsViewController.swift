//
//  CourseDetailsViewController.swift
//  SwiftbookApp
//
//  Created by Alexey Efimov on 04/08/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UIKit

protocol CourseDetailsViewInputProtocol: AnyObject {
    
}

protocol CourseDetailsViewOutputProtocol: AnyObject {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
}

class CourseDetailsViewController: UIViewController {
    
    @IBOutlet private weak var courseNameLabel: UILabel!
    @IBOutlet private weak var numberOfLessonsLabel: UILabel!
    @IBOutlet private weak var numberOfTestsLabel: UILabel!
    @IBOutlet private weak var courseImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var course: Course!
    var presenter: CourseDetailsViewOutputProtocol!
    
    private var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
        loadFavoriteStatus()
        setupUI()
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }
    
    private func setupUI() {
        courseNameLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTestsLabel.text = "Number of tests: \(course.numberOfTests)"
        
        if let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) {
            courseImage.image = UIImage(data: imageData)
        }
              
        setStatusForFavoriteButton()
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
}

// MARK: - CourseDetailsViewController
extension CourseListViewController: CourseDetailsViewInputProtocol {
    
}
