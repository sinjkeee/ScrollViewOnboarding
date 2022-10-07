//
//  ViewController.swift
//  PresentationApp
//
//  Created by Vladimir Sekerko on 07.10.2022.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroungImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pageControll: UIPageControl = {
       let pageControll = UIPageControl()
        pageControll.numberOfPages = 3
        pageControll.pageIndicatorTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        return pageControll
    }()
    
    private var slides = [OnboardingView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
    }
    
    private func setupViews() {
        view.backgroundColor = .gray
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        view.addSubview(pageControll)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func createSlides() -> [OnboardingView] {
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.setPageLabelText(text: "Повелитель зверей Рексар, наполовину орк и наполовину огр, путешествуя по Калимдору, попадает в город Оргриммар, недавно основанную столицу Орды. Вождь Тралл предлагает Рексару осесть в Дуротаре и помочь в решении насущных проблем его народа...")
        
        let secondOnboardingView = OnboardingView()
        secondOnboardingView.setPageLabelText(text: "Вместе с новыми напарниками — троллем Рокханом и пандареном Чэнем Буйным Портером — Рексар обнаруживает вблизи Оргриммара группу войск Альянса, которая проявляет агрессию к ордынским поселениям. Это приводит Тралла в замешательство, так как с войсками Джайны Праудмур у Орды был заключен мир...")
        
        let thirdOnboardingView = OnboardingView()
        thirdOnboardingView.setPageLabelText(text: "Как впоследствии выясняется, это были войска Кул-Тираса, возглавляемые адмиралом Даэлином Праудмуром, отцом Джайны. Адмирал, хорошо помня былые распри, не верит в мирные намерения орков. Рексару и его напарникам предстоит предотвратить масштабный конфликт и защитить союзников Орды.")
        
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }
    
    private func setupSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
}

//MARK: - setConstraints
extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            pageControll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            pageControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControll.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControll.currentPage = Int(pageIndex)
        
        let maxHorizontalOffset = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                   y: (0.5 - percentHorizontalOffset) / 0.5)
            
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransform)
        } else {
            let secondTransform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                                    y: (1 - percentHorizontalOffset) / 0.5)
            
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                   y: percentHorizontalOffset)
            
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
        }
    }
}
