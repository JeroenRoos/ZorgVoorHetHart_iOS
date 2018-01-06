//
//  MyBloodPressureInformationViewController.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 01/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

class MyBloodPressureInformationViewController: UIViewController
{
    @IBOutlet weak var imgView01: UIImageView!
    @IBOutlet weak var imgView02: UIImageView!
    @IBOutlet weak var imgView03: UIImageView!
    @IBOutlet weak var imgView04: UIImageView!
    @IBOutlet weak var txtTitle01: UILabel!
    @IBOutlet weak var txtTitle02: UILabel!
    @IBOutlet weak var txtTitle03: UILabel!
    @IBOutlet weak var txtTitle04: UILabel!
    @IBOutlet weak var txtAnwser01: UITextView!
    @IBOutlet weak var txtAnwser02: UITextView!
    @IBOutlet weak var txtAnwser03: UITextView!
    @IBOutlet weak var txtAnwser04: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Bloeddruk informatie"
        
        // Link voor de tekst
        // www.bloeddruk.net/bloeddruk-meten.html
        imgView01.backgroundColor = UIColor(rgb: 0xEEEEEE)
        txtTitle01.text = "Hoe moet ik mijn bloeddruk meten?"
        txtTitle01.font = txtTitle01.font?.withSize(12)
        txtAnwser01.text = "Het meten van de bloeddruk kan op verschillende manieren. De meest gangbare methode is het meten met een bloeddrukmeter. De klassieke bloeddrukmeter is met een rubberen slang verbonden aan een dikke band. Die band moet aan de bovenarm verbonden worden. De band wordt dan met een pompje opgepompt waardoor de slagaders afgesloten worden. Daardoor is ook de polsslag niet meer voelbaar. Als het bloedvat volledig afgesloten is wordt het pompen gestopt. De band loopt dan weer langzaam leeg. Op het moment dat het bloed weer door de aderen loopt (en de polsslag weer gevoeld kan worden) wordt de bovendruk gemeten. De band loopt verder leeg en als het bloed weer vrij kan stromen, wordt de onderdruk gemeten. Het bloeddruk meten levert dus altijd twee getallen/waarden op. Gebruikelijk is dat deze waarden met een streepje ertussen genoteerd worden, eerst de bovendruk en dan de onderdruk. Bijvoorbeeld 120-90 of 120/90."
        txtAnwser01.font = txtAnwser01.font?.withSize(12)
        
        imgView02.backgroundColor = UIColor(rgb: 0xEEEEEE)
        txtTitle02.text = "Hoe vaak moet ik mijn bloeddruk meten?"
        txtTitle02.font = txtTitle02.font?.withSize(12)
        txtAnwser02.text = "Nadat één keer vastgesteld is dat de bloeddruk te hoog is, is naar medische begrippen nog geen sprake van verhoogde bloeddruk (hypertensie). Daarvoor zijn meer metingen nodig. In de regel wordt pas gesproken van verhoogde bloeddruk als 3 tot 5 metingen een te hoge bloeddruk uitwijzen. Daarbij wordt ook beoordeeld of die metingen onder vergelijkbare omstandigheden uitgevoerd zijn. Als de patient nerveus is en niet uitgerust, kan dat de bloeddrukmeting minder betrouwbaar maken."
        txtAnwser02.font = txtAnwser02.font?.withSize(12)
        
        imgView03.backgroundColor = UIColor(rgb: 0xEEEEEE)
        txtTitle03.text = "Wat is een 24-uurs bloeddrukmeting?"
        txtTitle03.font = txtTitle03.font?.withSize(12)
        txtAnwser03.text = "Een methode die regelmatig bij patienten wordt gehanteerd is de 24-uurs bloeddrukmeting. In korte tijd kan een arts dan zien hoe de ontwikkeling van de bloeddruk is. De meting van de bloeddruk op deze manier wordt gedaan met een apparaat dat vrijwel identiek is aan een gewone bloeddrukmeter. Aan dit apparaat is alleen een regelaar toegevoegd die periodiek (bijvoorbeeld elke 10 minuten) de bloeddruk opmeet en deze registreert. Daarnaast heeft een 24-uurs bloeddrukmeter uiteraard een pompje op batterijen zodat de meting volledig automatisch verloopt. De huisarts heeft met deze metingen een nauwkeurig beeld van de bloeddruk en het verloop."
        txtAnwser03.font = txtAnwser03.font?.withSize(12)
        
        imgView04.backgroundColor = UIColor(rgb: 0xEEEEEE)
        txtTitle04.text = "Moet ik mijn bloeddruk links of rechts meten?"
        txtTitle04.font = txtTitle04.font?.withSize(12)
        txtAnwser04.text = "De bloeddrukmeting kan zowel bij de rechter als de linkerarm gedaan worden. Er kan sprake zijn van klein verschil, maar dit zal normaalgesproken nooit meer dan 10 punten zijn. Een hoger verschil kan wijzen op een afwijking, bijvoorbeeld het bestaan van vernauwingen in de bloedvaten. In geval van twijfel is het altijd goed een arts te consulteren. De bloeddruk kan ook in de benen gemeten worden. Daarvoor is dan vaak wel een speciale band nodig die dikker is dan de ‘normale ‘ band."
        txtAnwser04.font = txtAnwser04.font?.withSize(12)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
