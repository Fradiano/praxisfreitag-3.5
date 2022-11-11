//
//  ViewController.swift
//  praxisfreitag 3.5
//
//  Created by Fradiano Hasani on 11.11.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var TVReiseZiele: UITableView!
    
    var zuBesuchen: [String] = ["käse"]
    var besucht: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVReiseZiele.dataSource = self
        TVReiseZiele.delegate = self
    }
    
// gib anzahl an sections an
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
// zählt wie lang die liste sein soll
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return zuBesuchen.count
        }else{
            return besucht.count
        }
    }
    
//bennent die zellen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zieleCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            content.text = zuBesuchen[indexPath.row]
            cell.contentConfiguration = content
        }else{
            content.text = besucht[indexPath.row]
            cell.contentConfiguration = content
        }
        return cell
    }
    
//bennent die section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "du musst unbedingt nach:"
        }else{
            return "war eine erfahrung wert!"
        }
    }
    
//löscht
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == .delete){
            let delete = zuBesuchen[indexPath.row]
            zuBesuchen.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
//verschiebt elemente in anderes Array
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
            if indexPath.section == 0{
                let data = zuBesuchen[indexPath.row]
                besucht.append(data)
                zuBesuchen.remove(at: indexPath.row)
            }else if indexPath.section == 1{
                let data = besucht[indexPath.row]
                zuBesuchen.append(data)
                besucht.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
    
    
    
    @IBAction func hinzufuegen(_ sender: Any) {
        
        let alert = UIAlertController(title: "Neues Reiseziel", message: "wo soll es hingehen", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "auf gehts!", style: .default, handler: {(_) in
            let text = alert.textFields?.first?.text
            self.zuBesuchen.append(text!)
            self.TVReiseZiele.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true, completion: nil)
        
    }

}

