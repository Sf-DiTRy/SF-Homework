//
//  ViewController.swift
//  IOS15-21.7_Module.MiniGame
//
//  Created by DiTRy on 10.01.2022.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let systemBlueColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 0.4)  //  Цвет соответствующий "System blue color" с alpha 0.4
    
    @IBOutlet weak var circleViewOne: CustomCircleView!
    @IBOutlet weak var circleViewTwo: CustomCircleView!
    @IBOutlet weak var circleViewThree: CustomCircleView!
        
    var circleViewFour: CustomCircleView = CustomCircleView(frame: CGRect(x: 4, y: 4, width: 64, height: 64))
    var circleViewFive: CustomCircleView = CustomCircleView(frame: CGRect(x: 5, y: 5, width: 64, height: 64))
    var circleViewSix: CustomCircleView = CustomCircleView(frame: CGRect(x: 6, y: 6, width: 64, height: 64))
    var circleViewSeven: CustomCircleView = CustomCircleView(frame: CGRect(x: 7, y: 7, width: 64, height: 64))
    
    let circles: [String] = ["circleViewOne", "circleViewTwo", "circleViewThree", "circleViewFour", "circleViewFive", "circleViewSix", "circleViewSeven"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleViewOne.frame = randomPosition()
        circleViewOne.accessibilityIdentifier = circles[0]
        
        circleViewTwo.frame = randomPosition()
        circleViewTwo.accessibilityIdentifier = circles[1]

        circleViewThree.frame = randomPosition()
        circleViewThree.accessibilityIdentifier = circles[2]
        
        self.circleViewFour.frame = randomPosition()
        circleViewFour.customCircleSubView.backgroundColor = systemBlueColor
        circleViewFour.accessibilityIdentifier = circles[3]

        self.circleViewFive.frame = randomPosition()
        circleViewFive.customCircleSubView.backgroundColor = systemBlueColor
        circleViewFive.accessibilityIdentifier = circles[4]

        self.circleViewSix.frame = randomPosition()
        circleViewSix.customCircleSubView.backgroundColor = systemBlueColor
        circleViewSix.accessibilityIdentifier = circles[5]


        self.circleViewSeven.frame = randomPosition()
        circleViewSeven.customCircleSubView.backgroundColor = systemBlueColor
        circleViewSeven.accessibilityIdentifier = circles[6]


        view.addSubview(circleViewFour)
        view.addSubview(circleViewFive)
        view.addSubview(circleViewSix)
        view.addSubview(circleViewSeven)
        
        let panActionCircleViewFour = UIPanGestureRecognizer(target: self, action: #selector(panActionCircleView))
        panActionCircleViewFour.delegate = self
        circleViewFour.addGestureRecognizer(panActionCircleViewFour)
        
        let panActionCircleViewFive = UIPanGestureRecognizer(target: self, action: #selector(panActionCircleView))
        panActionCircleViewFive.delegate = self
        circleViewFive.addGestureRecognizer(panActionCircleViewFive)
        
        let panActionCircleViewSix = UIPanGestureRecognizer(target: self, action: #selector(panActionCircleView))
        panActionCircleViewSix.delegate = self
        circleViewSix.addGestureRecognizer(panActionCircleViewSix)
        
        let panActionCircleViewSeven = UIPanGestureRecognizer(target: self, action: #selector(panActionCircleView))
        panActionCircleViewSeven.delegate = self
        circleViewSeven.addGestureRecognizer(panActionCircleViewSeven)

    }

    func randomPosition() -> CGRect {   //  Функция возвращает рандомную позицию на экране
        let randomPosition = CGRect(x: .random(in: 32...Int(self.view.frame.maxX-32)), y: .random(in: 32...Int(self.view.frame.maxY-32)), width: 64, height: 64)
        return randomPosition
    }
        
    @IBAction func panActionCircleViewOne(_ gesture: UIPanGestureRecognizer) {

        let gestureTranslation = gesture.translation(in: view)  //  Нам нужно интерпретировать жест. В методе создаём переменную gestureTranslation
        
        guard let gestureView = gesture.view else { //  Так как мы без аутлета, у нас не объявлен вью. В то же время у него два развития событий для жеста — он либо есть, либо его нет. Поэтому привет, guard let. При этом мы находим наш переиспользуемый вью через знакомую переменную gesture
            return
        }
        
        gestureView.center = CGPoint (  //  зададим центр нашему view-элементу
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        //  Наш интерпретатор должен обнуляться, когда всё закончится, иначе с каждым разом наш блок будет улетать за пределы экрана. Обнулим интерпретатор через setTranslation для нашего view и сделаем unwrap для gesture.state через guard let. Нас интересует только законченная фаза .ended
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
            return
        }
        
        let geasureCustomCircleView = gestureViewIdentifier(gesture: gestureView)   // определим с каким CustomCircleView имеем дело
        
        circleIntersects(сustomCircleView: geasureCustomCircleView) // определим с кем он пересекается и выполним необходимые действия
        
    }
    
    @IBAction func panActionCircleViewTwo(_ gesture: UIPanGestureRecognizer) {
        
        let gestureTranslation = gesture.translation(in: view)  //  Нам нужно интерпретировать жест. В методе создаём переменную gestureTranslation
        
        guard let gestureView = gesture.view else { //  Так как мы без аутлета, у нас не объявлен вью. В то же время у него два развития событий для жеста — он либо есть, либо его нет. Поэтому привет, guard let. При этом мы находим наш переиспользуемый вью через знакомую переменную gesture
            return
        }
        
        gestureView.center = CGPoint (  //  зададим центр нашему view-элементу
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        //  Наш интерпретатор должен обнуляться, когда всё закончится, иначе с каждым разом наш блок будет улетать за пределы экрана. Обнулим интерпретатор через setTranslation для нашего view и сделаем unwrap для gesture.state через guard let. Нас интересует только законченная фаза .ended
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
            return
        }
        
        let geasureCustomCircleView = gestureViewIdentifier(gesture: gestureView)   // определим с каким CustomCircleView имеем дело
        
        circleIntersects(сustomCircleView: geasureCustomCircleView) // определим с кем он пересекается и выполним необходимые действия
        
    }
    
    @IBAction func panActionCircleViewThree(_ gesture: UIPanGestureRecognizer) {
        
        let gestureTranslation = gesture.translation(in: view)  //  Нам нужно интерпретировать жест. В методе создаём переменную gestureTranslation
        
        guard let gestureView = gesture.view else { //  Так как мы без аутлета, у нас не объявлен вью. В то же время у него два развития событий для жеста — он либо есть, либо его нет. Поэтому привет, guard let. При этом мы находим наш переиспользуемый вью через знакомую переменную gesture
            return
        }
        
        gestureView.center = CGPoint (  //  зададим центр нашему view-элементу
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        //  Наш интерпретатор должен обнуляться, когда всё закончится, иначе с каждым разом наш блок будет улетать за пределы экрана. Обнулим интерпретатор через setTranslation для нашего view и сделаем unwrap для gesture.state через guard let. Нас интересует только законченная фаза .ended
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
            return
        }
        
        let geasureCustomCircleView = gestureViewIdentifier(gesture: gestureView)   // определим с каким CustomCircleView имеем дело
        
        circleIntersects(сustomCircleView: geasureCustomCircleView) // определим с кем он пересекается и выполним необходимые действия

    }
    
    @objc func panActionCircleView(_ gesture: UIPanGestureRecognizer) {
        
        let gestureTranslation = gesture.translation(in: view)  //  Нам нужно интерпретировать жест. В методе создаём переменную gestureTranslation
        
        guard let gestureView = gesture.view else { //  Так как мы без аутлета, у нас не объявлен вью. В то же время у него два развития событий для жеста — он либо есть, либо его нет. Поэтому привет, guard let. При этом мы находим наш переиспользуемый вью через знакомую переменную gesture
            return
        }
        
        gestureView.center = CGPoint (  //  зададим центр нашему view-элементу
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        //  Наш интерпретатор должен обнуляться, когда всё закончится, иначе с каждым разом наш блок будет улетать за пределы экрана. Обнулим интерпретатор через setTranslation для нашего view и сделаем unwrap для gesture.state через guard let. Нас интересует только законченная фаза .ended
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
            return
        }
        
        let geasureCustomCircleView = gestureViewIdentifier(gesture: gestureView)   // определим с каким CustomCircleView имеем дело
        
        circleIntersects(сustomCircleView: geasureCustomCircleView) // определим с кем он пересекается и выполним необходимые действия

    }

    func gestureViewIdentifier(gesture: UIView) -> CustomCircleView {
                
        switch gesture.accessibilityIdentifier {
        case circleViewOne.accessibilityIdentifier:
            print("circleViewOneFrame")
            return circleViewOne
            
        case circleViewTwo.accessibilityIdentifier:
            print("circleViewTwoFrame")
            return circleViewTwo

        case circleViewThree.accessibilityIdentifier:
            print("circleViewThreeFrame")
            return circleViewThree

        case circleViewFour.accessibilityIdentifier:
            print("circleViewFourFrame")
            return circleViewFour

        case circleViewFive.accessibilityIdentifier:
            print("circleViewFiveFrame")
            return circleViewFive

        case circleViewSix.accessibilityIdentifier:
            print("circleViewSixFrame")
            return circleViewSix

        case circleViewSeven.accessibilityIdentifier:
            print("circleViewSevenFrame")
            return circleViewSeven

        default:
            return CustomCircleView()
        }
    }
    
    func circleIntersects(сustomCircleView: CustomCircleView) {
        let circle = сustomCircleView
        if circle != circleViewOne, circle.frame.intersects(circleViewOne.frame) {
            circleViewOne.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewTwo, circle.frame.intersects(circleViewTwo.frame) {
            circleViewTwo.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewThree, circle.frame.intersects(circleViewThree.frame) {
            circleViewThree.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewFour, circle.frame.intersects(circleViewFour.frame) {
            circleViewFour.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewFive, circle.frame.intersects(circleViewFive.frame) {
            circleViewFive.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewSix, circle.frame.intersects(circleViewSix.frame) {
            circleViewSix.isHidden = true
            circleTransform(gestureView: circle)
        } else if circle != circleViewSeven, circle.frame.intersects(circleViewSeven.frame) {
            circleViewSeven.isHidden = true
            circleTransform(gestureView: circle)
        } else {
            print("no circleIntersects")
        }
    }
    
    func circleTransform(gestureView: CustomCircleView) {
        gestureView.customCircleSubView.backgroundColor = .random()
        
        let width = gestureView.customCircleSubView.frame.width
        let height = gestureView.customCircleSubView.frame.height

        gestureView.customCircleSubView.frame.size = CGSize(width: width + 2, height: height + 2)
        gestureView.customCircleSubView.autoresizingMask = [.flexibleWidth, .flexibleHeight]    //  Определяем размещение в пределах заданных границ — autoresizingMask нам в помощь
        gestureView.customCircleSubView.layer.cornerRadius = width / 2   //  Выставляем радиус границ равный половине ширины, чтобы получить круг
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(),
           green: .random(),
           blue: .random(),
           alpha: 1.0
        )
    }
}

//  Вьюшки сравниваются с исчезнувшими вью, как полностью удалять вью из представления?
//  Не получается менять прозрачность alpha
//  Не получилось организовать массив [CustomCircleView]. В каком месте это надо делать?

