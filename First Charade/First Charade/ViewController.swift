//
//  ViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

enum rundestatuser {
    case velgOrd
    case igang
    case vunne
    case tapt
}

class ViewController: UIViewController {

    let rundeTid:Int = 5 // sekunder
    // TODO: fyll oppgaveord fra ordbok
    var oppgaveord = ["ord 1", "ord 2", "ord 3", "ord 4", "ord 5"]
    
    // MARK: runde skal refaktoreres til egen runde-klasse
    var rundeTimer = NSTimer()
    var rundeStatus = rundeStatuser.velgOrd
    var rundeord = ""
    var gjenstaendeRundeTid: Int = 0
    
    // MARK: Outlets
    @IBOutlet var valgtOppgaveord:UILabel!
    
    // MARK: Constructor / Destructor
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Timer
    
    // MARK: Actions
    @IBAction func testknapp(sender:UIButton) {
        velgOrd(sender)
        startRunde()
    }

//TODO: Lag funksjonalitet for å bestemme antall sekunder i rundetiden
    
    @IBAction func velgOrd(sender:UIButton) {
        nesteOrd(sender)
    }
    
    @IBAction func startRunde() {
        // TODO: reset timer, må være disablet til stoppet
        view.backgroundColor = UIColor.blueColor()
        gjenstaendeRundeTid = rundeTid
        startTimer()
    }
    
    func startTimer() {
        rundeStatus = rundeStatuser.igang
        rundeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        gjenstaendeRundeTid--
        if (gjenstaendeRundeTid < 0) {
            gjenstaendeRundeTid = 0
        }
        valgtOppgaveord.text = String(gjenstaendeRundeTid)
        if (gjenstaendeRundeTid == 0) {
            gameOver()
        }
    }
    
    @IBAction func nesteOrd(sender:UIButton) {
        let tilfeldigIndeks = Int(arc4random_uniform(UInt32(oppgaveord.count)))
        rundeOrd = oppgaveord[tilfeldigIndeks]
        visOrd()
    }
    
    @IBAction func stoppRunde() {
        rundeTimer.invalidate()
        view.backgroundColor = UIColor.greenColor()
        visOrd()
    }
    
    @IBAction func gameOver() {
        rundeTimer.invalidate()
        view.backgroundColor = UIColor.redColor()
        visOrd()
        // spill sørgemars
    }
    
    func visOrd() {
        valgtOppgaveord.text = rundeOrd
    }

}

