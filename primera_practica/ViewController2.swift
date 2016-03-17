//
//  ViewController2.swift
//  primera_practica
//
//  Created by Marina León on 16/2/16.
//  Copyright © 2016 Marina León. All rights reserved.
//

import UIKit

class ViewController2: UIViewController,UIPopoverPresentationControllerDelegate {
    var cara = 0
    @IBOutlet var jugador_actual: UILabel!
    @IBOutlet var acumulado_turno: UILabel!
    @IBOutlet var cara_imagen: UIImageView!
    
    @IBOutlet var barJ1: UIProgressView!
    @IBOutlet var barJ2: UIProgressView!
    
    @IBOutlet var totalJ1: UILabel!
    @IBOutlet var totalJ2: UILabel!
    
    @IBOutlet var tirar: UIButton!
    @IBOutlet var recoger: UIButton!
    
    var acumulado = 0
    var jugador = 1
    var otra_vez = false;
    
    @IBAction func tirarDado(sender: AnyObject) {
        cara = 1 + Int(arc4random_uniform(UInt32(6 - 1 + 1)))
        switch(cara){
        case 1:
            cara_imagen.image = UIImage(named:"1.png")
            break;
            
        case 2:
            cara_imagen.image = UIImage(named:"2.png")
            break;
            
        case 3:
            cara_imagen.image =  UIImage(named:"3.png")!

            break;
            
        case 4:
            cara_imagen.image = UIImage(named:"4.png")!
            break;
            
        case 5:
            cara_imagen.image = UIImage(named:"5.png")!
            break;
            
        case 6:
            cara_imagen.image = UIImage(named:"6.png")!
            break;
            
        default:
            break;
        }
        
        
        if(cara == 1){
            cara = 0
            pierdeTurno(jugador);
        }else{
            recoger.enabled = true
            
            SumaAcumulado(cara);
        }
        
        
        
    }
    
    
    @IBAction func recoger(sender: AnyObject) {
        var total = 0
        cara_imagen.image = UIImage()
        if(jugador_actual.text == "J1"){
            total = acumulado + Int(totalJ1.text!)!
            totalJ1.text = String(total)
            barJ1.progress = Float(total)/100.0
            
        }else if(jugador_actual.text == "J2"){
            total = acumulado + Int(totalJ2.text!)!
            totalJ2.text = String(total)
            barJ2.progress = Float(total)/100.0
        }
        
        if(total >= 100){
            finPartida(jugador)
        }else{
            pierdeTurno(jugador)
        }
    }
    
    func finPartida(var jugador:Int){
        
        let msg = "Gana el jugador J\(jugador) \n ¿Jugar de nuevo?"
        let alertFin = UIAlertController(title: "", message: msg, preferredStyle: .Alert)
        
        let si = UIAlertAction(title: "Si", style: .Default, handler: { (UIAlertAction) -> Void in
            if(jugador == 1){
                jugador = 2
            }else{
                jugador = 1
            }
            self.otra_vez = true
            self.nuevoTurno(jugador)
        })
        let no = UIAlertAction(title: "No", style: .Default, handler: { (UIAlertAction) -> Void in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("VistaUno") as! ViewController

            vc.modalPresentationStyle = .FormSheet
            vc.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(vc, animated: true, completion: nil )
        })
        
        alertFin.addAction(si)
        alertFin.addAction(no)
        self.presentViewController(alertFin, animated: true, completion: nil)
     
    }
   
    
    func SumaAcumulado(cara:Int){
       acumulado = acumulado + cara
       acumulado_turno.text = String(acumulado)
    }
    
    func pierdeTurno(var jugador:Int){
       // cara_imagen.image = UIImage()
        if(jugador_actual.text == "J1"){
            jugador = 2
        }else if(jugador_actual.text == "J2"){
            jugador = 1
        }
        nuevoTurno(jugador)
    }
    
    func nuevoTurno(jugador:Int){
        
        acumulado_turno.text =  "0"
        jugador_actual.text = "J\(jugador)"
        acumulado = 0
        
        if(otra_vez){
            cara_imagen.image = UIImage()
            jugador_actual.text = "J\(jugador)"
            acumulado_turno.text =  "0"
            totalJ1.text = "0"
            totalJ2.text = "0"
            barJ1.progress = 0
            barJ2.progress = 0
        }
        
        if(jugador == 1){
            jugador_actual.textColor = UIColor.blueColor()
            acumulado_turno.textColor = UIColor.blueColor()
            tirar.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
            recoger.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        }else{
            jugador_actual.textColor = UIColor.redColor()
            acumulado_turno.textColor = UIColor.redColor()
            tirar.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal )
            recoger.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal )
        }
        recoger.enabled = false
      
        let msg = "Comienza el turno del jugador J\(jugador)"
        let alertNew = UIAlertController(title: "", message: msg, preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Comenzar", style: .Cancel, handler: nil)
        alertNew.addAction(cancel)
        self.presentViewController(alertNew, animated: true, completion: nil)
       /* let alert = UIAlertView(title: "", message: msg, delegate: self, cancelButtonTitle: "Comenzar")
        alert.show() */
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        nuevoTurno(jugador)
      
       /*let alert = UIAlertController(title: "", message: "Comienza el turno del jugador J\(jugador)", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Comenzar", style: .Cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)*/

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
      /*  let alert = UIAlertView(title: "", message: "Comienza el turno del jugador J1", delegate: self, cancelButtonTitle: "Comenzar")
       
        alert.show() */
 
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - popoverPresentationController
    
    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.sourceView = self.view
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
