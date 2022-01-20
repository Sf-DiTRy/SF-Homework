//
//  ViewController.swift
//  IOS15-21.5_Module.UIGestureRecognizer
//
//  Created by DiTRy on 15.01.2022.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var indigoView: UIView!
    @IBOutlet weak var purpleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mixingGesture = MixGesture(target: self, action: #selector(handleMixing))
        let purpleMixingGesture = MixGesture(target: self, action: #selector(handleMixing))
        mixingGesture.delegate = self
        purpleMixingGesture.delegate = self
        indigoView.addGestureRecognizer(mixingGesture)
        purpleView.addGestureRecognizer(purpleMixingGesture)
        self.view?.addGestureRecognizer(mixingGesture)
    }

    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {   //  В методе panAction у нас будет три основных шага, ориентированных на возможность распознавание жестов у конкретного view. Обратите внимание — мы можем не создавать аутлеты для наших view, потому что бОльший приоритет отдаётся жесту как экшену. И в этом экшене мы пойдём через guard let для дальнейшего обращения к view и переиспользования.
                
        let orangeViewFrame = orangeView.frame
        let indigoViewFrame = indigoView.frame
        
        
        //  Нам нужно интерпретировать жест. В методе создаём переменную gestureTranslation
        let gestureTranslation = gesture.translation(in: view)
        
        //  Так как мы без аутлета, у нас не объявлен вью. В то же время у него два развития событий для жеста — он либо есть, либо его нет. Поэтому привет, guard let. При этом мы находим наш переиспользуемый вью через знакомую переменную gesture
        guard let gestureView = gesture.view else {
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
        
        for value in Int(orangeViewFrame.minY)...Int(orangeViewFrame.maxY) {
            if Int(indigoViewFrame.origin.y) == value {
                indigoView.isHidden = true
            }
        }
    }
    
    @IBAction func purplePanAction(_ gesture: UIPanGestureRecognizer) {
        let orangeViewFrame = orangeView.frame
        let purpleViewFrame = purpleView.frame
        
        
        let gestureTranslation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.center = CGPoint (x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
            return
        }
        
        for value in Int(orangeViewFrame.minY)...Int(orangeViewFrame.maxY) {
            if Int(purpleViewFrame.origin.y) == value {
                purpleView.isHidden = true
            }
        }
        
    }
    
    @objc func handleMixing (_ gesture: MixGesture) {   //  Теперь пропишем в функции, что мы хотели бы от неё. А именно изменение ширины оранжевого вью-элемента. Мы хотим, чтобы при каждой такой встряске наш оранжевый вью уменьшался в ширину на 10 единиц. Сделаем четыре локальные константы для нашего оранжевого вью и зададим параметр для фрейма — ширина (orangeViewWidth) должна терять 30 единиц каждый раз, когда мы трясём синий вью
        print("starting handleMixing")
        print(orangeView.frame.width)
        
        let orangeViewX = orangeView.frame.minX
        let orangeViewY = orangeView.frame.minY
        let orangeViewWidth = orangeView.frame.width
        let orangeViewHeight = orangeView.frame.height
        
        orangeView.frame = CGRect(x: orangeViewX,
                                  y: orangeViewY,
                                  width: orangeViewWidth - 30,
                                  height: orangeViewHeight)
        
        print(orangeView.frame.width)
        //orangeView.backgroundColor = .blue
    }
    
}

