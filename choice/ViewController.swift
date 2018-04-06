//
//  ViewController.swift
//  choice
//
//  Created by Simon on 2018/4/5.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    struct Qna {
        var problem:String
        var choose:[String] = []
        var answer:Int
        var explanation:String
        
    }
    //題數
    var number = 0
    //回答數字
    var answerNumber = 0
    //題數
    var numberQuestions = 0
    //分數
    var fraction = 0

    var qna = [
    Qna(problem: "誰最缺水？", choose: ["江蕙","周杰倫","彼得潘","蔡依林"], answer: 1, explanation:"因為江蕙 有首歌：「我沒醉我沒醉沒醉（我沒水我沒水沒水）」"),
    Qna(problem: "請問...糖果是公的還是母的? ", choose: ["公的","不男不女","不是人","母的"], answer: 4,             explanation: " 母的,因為..糖果放在桌上會螞蟻"),
    Qna(problem: "請問哪一種花沒有孩子? ", choose: ["茉莉花","五月花","菊花","太陽花"], answer: 2, explanation: "五月花, 因為五月花衛生紙（未生子）"),
    Qna(problem: " 誰殺了便當?", choose: ["值日生","同學","老師","爸爸"], answer: 1, explanation: "值日生, 因為值日生抬便當"),
    Qna(problem: " 道明寺有幾個兄弟?", choose: ["1","2","3","4"], answer: 3, explanation: " 到台視 到中視 到華視 跟道明寺(到民視)"),
    Qna(problem: "氧和二氧化碳哪個比較美? ", choose: ["氧氣","二氧化碳","兩個都美","都不美"], answer: 1, explanation: " 氧，因為自然（助燃）就是美"),
    Qna(problem: "酷酷哥.酷帥哥.帥酷哥.請問哪一個人ㄉ老婆身體最虛弱? 酷酷哥，因為他的老婆叫酷酷", choose: ["酷酷哥","酷帥哥","帥酷哥","都不虛弱"], answer: 1, explanation: "酷酷哥，因為他的老婆叫酷酷"),
    Qna(problem: "猴子最討厭什麼線？", choose: ["黑線","白線","針線","地平線"], answer: 4, explanation: " 平行線，因為沒有相交（香蕉)"),
    Qna(problem: "象皮、老虎皮、獅子皮哪一個比較差？", choose: ["象皮","老虎皮","獅子皮","都不差"], answer: 1, explanation: "象皮，因為橡皮擦（象皮差）"),
    Qna(problem: "哪一位藝人講的笑話最冷? ", choose: ["周杰倫","彼得潘","蔡依林","江蕙"], answer: 3, explanation: "蔡依琳，因為Jolin(就冷)"),
    Qna(problem: "狼、老虎和獅子誰玩遊戲一定會被淘汰? ", choose: ["老虎","狼","獅子","大象"], answer: 2, explanation: "狼，因為：桃太郎（淘汰狼）"),
    Qna(problem: "20歲~30歲之間在第幾歲會發瘋?", choose: ["24","23","26","29"], answer: 1, explanation: "24歲，因為24孝（24肖）"),
    Qna(problem: "孔子有三位徒弟子貢.子路.和子游,請問哪一位不是人？", choose: ["子路","子貢","子游","孔子"], answer: 1, explanation: "子路，因為指鹿為馬（子路為馬)"),
    Qna(problem: "有一隻蚊子牠只叮[鼠牛虎兔龍蛇馬羊猴雞豬]，請問這隻蚊子叫什麼名字?", choose: ["小白","小黑","小黃","布丁狗"], answer: 4, explanation: "布丁狗（不叮狗）"),
    Qna(problem: " 什麼情況下2大於5，5大於0，0大於2呢？", choose: ["算數","玩遊戲","猜拳的時候","被騙"], answer: 3, explanation: "猜拳ㄉ時候"),
    Qna(problem: "誰賣忘情水？", choose: ["阿白","阿王","阿霞","阿陽"], answer: 3, explanation: "啊哈（阿霞）給我一杯忘情水"),
    Qna(problem: "電風.雲火.暴雨哪一匹馬最瘦?", choose: ["電火","電風","電雨","電水"], answer: 2, explanation: "電風扇（扇與台語的瘦同音）"),
    Qna(problem: "哪個歷史人物游泳必定沉下去?", choose: ["劉備","阿斗","孫堅","關羽"],answer: 2, explanation:"阿斗，因為：扶（浮）不起的阿斗"),
    Qna(problem: "牛奶,羊奶,那....大象的奶叫什麼? ", choose: ["抽筋","一條筋","橡皮筋","腳筋"], answer: 3, explanation: "橡皮筋,台語(象奶)"),
    Qna(problem: "和誰交往最辛苦？ ", choose: ["花花","莉莉","草草","媽媽"], answer: 2, explanation: "莉莉，因為粒粒（莉莉）皆辛苦")]
    //加入警告控制器
    func warning () {
        var score = ""
        if  fraction < 60{
            score = "不及格，這樣不行喔"
        }else if fraction > 60{
            score = "不錯喔"
        }
        let alert =  UIAlertController(title: score, message: "\(fraction)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "重新開始", style: .default, handler:{ UIAlertAction in  self.renew()})
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
      
    }

    @IBAction func nextButton(_ sender: UIButton) {
       let random = GKShuffledDistribution(lowestValue: 0, highestValue: qna.count - 1)
        var numbers = random.nextInt()
        let topic = numbers
        problemLabel.text = qna[topic].problem
        answerNumber = qna[topic].answer
        explanationLabel.text = qna[topic].explanation

        for i in 0 ..< selectValueButton.count{
            selectValueButton[i].setTitle(qna[topic].choose[i], for:.normal)
        }
        number += 1
        numberQuestions += 1
        numberOfQuestionsLabel.text = "\(numberQuestions + 1)"
        nextValueButton.isHidden = true
        explanationLabel.isHidden = true
        if number == 10{
            number = 0
            warning()
        }
        
    }

    @IBAction func selectAnswerButton(_ sender: UIButton) {
        if answerNumber == 1{
            fraction += 10
            fractionLabel.text = "\(fraction)"
        }
    explanationLabel.isHidden = false
    nextValueButton.isHidden = false
    }
    
    @IBAction func select1AnswerButton(_ sender: UIButton) {
        if answerNumber == 2{
            fraction += 10
            fractionLabel.text = "\(fraction)"
        }
        explanationLabel.isHidden = false
        nextValueButton.isHidden = false
    }
    
    @IBAction func select2AnswerButton(_ sender: UIButton) {
        if answerNumber == 3{
            fraction += 10
            fractionLabel.text = "\(fraction)"
        }
        explanationLabel.isHidden = false
        nextValueButton.isHidden = false
    }
    
    @IBAction func select3AnswerButton(_ sender: UIButton) {
        if answerNumber == 4{
            fraction += 10
            fractionLabel.text = "\(fraction)"
        }
        explanationLabel.isHidden = false
        nextValueButton.isHidden = false
    }
    @IBAction func renewButton(_ sender: UIButton) {
        renew()
    }
    func renew(){
        let random = GKShuffledDistribution(lowestValue: 0, highestValue: qna.count - 1)
        var numbers = random.nextInt()
        let topic = numbers
        problemLabel.text = qna[topic].problem
        answerNumber = qna[topic].answer
        explanationLabel.text = qna[topic].explanation

        for i in 0 ..< selectValueButton.count{
            selectValueButton[i].setTitle(qna[topic].choose[i], for:.normal)
        }
        fraction = 0
        fractionLabel.text = "\(fraction)"
        numberQuestions = 0
        numberOfQuestionsLabel.text = "\(numberQuestions + 1)"
        nextValueButton.isHidden = true
        explanationLabel.isHidden = true
    }
    @IBOutlet weak var fractionLabel: UILabel!
    @IBOutlet var selectValueButton: [UIButton]!
    @IBOutlet weak var nextValueButton: UIButton!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var numberOfQuestionsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       renew()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

