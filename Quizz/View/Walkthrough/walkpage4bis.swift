//
//  walkpage4bis.swift
//  Quizz
//
//  Created by matteo on 01/08/2021.
//

import SwiftUI

struct prepaselection: View {
    
    @AppStorage("userprepa") var userprepa: String = "Aucune"
    
    @Binding var showprepa: Bool
    
    @State private var searchString = ""
    
    init(showprepa: Binding<Bool>){
        self._showprepa = showprepa
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Button(action: {withAnimation(.spring()){showprepa = false}}, label: {
                    Image("thinarrowleft")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                })
                
                Spacer()
            }
            searchbar(searchText: $searchString)
            
            List(){
                ForEach(searchString == "" ? prepaliste: prepaliste.filter { $0.lowercased().contains(searchString.lowercased())}, id: \.self){ prepa in
                    Button(action: {self.userprepa = prepa; withAnimation(.spring()){showprepa = false}}, label: {
                        Text(prepa)
                            .foregroundColor(.black)
                    })
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .background(Color("lightgrey"))
        
    }
}

struct searchbar: View{
    
    @Binding var searchText: String
    
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(Color("lightgrey"))
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Rechercher ma prépa", text: $searchText)
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2))
        .padding(12)
    }
}

let prepaliste: [String] = ["Lycée privé Saint-Rémi", "Lycée Blaise-Pascal (Colmar)","Lycée Heinrich Nessel","Lycée Albert-Schweitzer","Lycée Lavoisier","Lycée Michel de Montaigne","Lycée Fustel-de-Coulanges","Lycée Jean-Rostand","Lycée Kléber","Lycée Louis-Couffignal","Lycée international des Pontonniers","Lycée privé ORT","Lycée René-Cassin","Lycée privé Saint-Étienne","Lycée René-Cassin","Lycée Brémontier","Lycée Camille-Jullian","Lycée Gustave-Eiffel","Lycée Michel-Montaigne","Lycée privé Sainte-Marie-Grand-Lebrun","Lycée Louis-Barthou","Lycée Saint-Cricq","Lycée Bertran-de-Born","Lycée Ambroise Brugière","Lycée Blaise-Pascal","Lycée Fénelon","Lycée privé Godefroy-de-Bouillon","Lycée La Fayette","Lycée privé Saint-Alyre","Lycée Sidoine-Apollinaire","Lycée Louis-Pasteur","Lycée Madame De Staël","Lycée Paul-Constans","Lycée Jean Zay","Lycée Charles-de-Gaulle","Lycée privé Jeanne-d'Arc","Lycée Jules-Dumont-d'Urville","Lycée Malherbe","Lycée privé Sainte-Marie","Lycée Victor-Hugo","Lycée Victor-Grignard","Lycée Salvador-Allende","Lycée Jean-François-Millet","Lycée Le Verrier","Lycée agricole Le Robillard","Lycée militaire National","Lycée Jacques-Amyot","Lycée icéphore-Niepce","Lycée Pontus de Thiard","Lycée La Prat's","Lycée Carnot (Dijon)","Lycée Gustave-Eiffel","Lycée Le Castel","Lycée privé Saint-Bénigne","Lycée Jules Renard","Lycée privé la Croix-Rouge","Lycée Jules Lesven","Lycée Kerichen","Lycée Naval","Lycée privé Sainte-Anne","Lycée Vauban","Lycée Saint Joseph Lasalle","Lycée Dupuy-de-Lôme","Lycée Brizeux","Lycée privé Assomption","Lycée Chateaubriand","Lycée Victor-et-Hélène Basch","Lycée Joliot-Curie","Lycée privé Saint-Vincent-Providence","Lycée Chaptal","Lycée Rabelais","Lycée Renan","Lycée Alain-René-Lesage","Lycée privé Saint-François-Xavier","Lycée agricole du Chesnoy","Lycée François-Philibert-Dessaignes","Lycée Alain-Fournier","Lycée Marceau","Lycée Benjamin-Franklin","Lycée Pothier","Lycée privé Saint-Charles","Lycée Voltaire","Lycée Descartes","Lycée Jacques de Vaucanson","Lycée Laetitia-Bonaparte","Lycée Giocante de Casabianca","Lycée Gustave-Courbet","Lycée Raoul-Follereau","Lycée Jules-Haag","Lycée Louis-Pasteur","Lycée Louis-Pergaud","Lycée Victor-Hugo","Lycée Viette","Lycée Charles-Coëffin","HEC CCI","Lycée Baimbridge","Lycée Gerville-Réache","Lycée Léon Gontran Damas","Lycée Félix Eboué","Lycée Aristide-Brian","Lycée Claude-Monet","Lycée François-Ier","Lycée Robert-Schuman","Lycée Blaise-Pascal (Orsay)","Lycée Corneille","Lycée Jeanne-d'Arc","Lycée Gustave-Flaubert","Lycée les Bruyères","Lycée Marcel-Sembat","Lycée Le Corbusier","Lycée Louise-Michel","Lycée de Cachan (Cachan1)","Lycée Maximilien-Sorre","Lycée La Fayette","Lycée Langevin-Wallon","Lycée Léon-Blum","Lycée Jacques-Feyder","Lycée François-Ier","Lycée François-Couperin","Lycée Pablo-Picasso","Lycée Albert-Schweitzer","Lycée André-Boulloche","Lycée Henri-Moissan","Lycée Pierre-de-Coubertin","Lycée Jacques-Amyot","Lycée Jean-Jaurès","Lycée Olympe-de-Gouges","Internat d'Excellence de Sourdun","Lycée Paul-Éluard","Lycée d'Arsonval","Lycée Marcelin-Berthelot","Lycée privé Teilhard-de-Chardin","Lycée Auguste-Blanqui","Lycée Jean Moulin","Lycée privé Blanche de Castille","Lycée Hector-Berlioz","Lycée Bessières-École nationale de commerce","Lycée privé Blomet","Lycée Buffon","Lycée Carnot","Lycée Chaptal","Lycée Charlemagne","Lycée Claude-Bernard","Lycée Claude-Monet","Lycée Condorcet","Prépa Commercia","Lycée Dorian","École supérieure des arts appliqués Duperré","École nationale de chimie physique et biologie","Lycée Fénelon","Lycée privé Fénelon Sainte-Marie","Lycée Hélène-Boucher","Lycée Henri-IV","Lycée Honoré-de-Balzac","Prépa Initiale","Prépa Intégrale","Ipécom","Ipesup","ISEP","Collège-lycée Jacques-Decour","Lycée Janson-de-Sailly","Lycée Jean-Baptiste-Say","Lycée-collège Jules-Ferry","Lycée Lavoisier","Lycée Louis-le-Grand","Lycée Montaigne","Lycée Molière","Lycée Paul-Valéry","Prépacom","Lycée Raspail","Lycée Rodin","Lycée privé Saint-Jean de Passy","Lycée Saint-Louis","Lycée Saint-Louis-de-Gonzague","Lycée Saint Michel de Picpus","Lycée privé Saint-Nicolas","Lycée privé Stanislas","Lycée Turgot","Lycée Victor-Duruy","Lycée Voltaire","Lycée privé Sainte-Marie d'Antony","Lycée Descartes (Versailles)","Lycée Jean-Jaurès","Lycée Descartes","Lycée Alfred-Kastler","Lycée Newton-ENREA","Lycée Gustave-Monod","Lycée du Parc des Loges","Lycée L'Essouriau","Lycée Saint-Exupéry","Lycée Parc de Vilgénis","Lycée Joliot Curie","Lycée Louis-Pasteur","Lycée privé Notre-Dame de Sainte-Croix","Lycée privé Sainte-Marie","Lycée Blaise-Pascal","Lycée Camille Pissarro","Centre Madeleine-Daniélou","Lycée Passy-Buzenval","Lycée Richelieu","Lycée Alexandre-Dumas","Lycée militaire de Saint-Cyr","Lycée Jeanne-d'Albret","Lycée Jean-Perrin","Lycée Jean-Jacques-Rousseau","Lycée Corot","Lycée Lakanal","Lycée Marie-Curie","Lycée Jean-Pierre-Vernant","Lycée Michelet","Lycée Hoche","Lycée Jules-Ferry","Lycée La Bruyère","Lycée Marie-Curie","Lycée privé Notre-Dame-du-Grandchamp","Lycée privé Sainte-Geneviève","Lycée Jean Baptiste Dumas","Lycée Jean-Mermoz","Lycée Joffre","Lycée Jules-Guesde","Lycée Mas de Tesse","Lycée Notre-Dame de la Merci","Lycée Alphonse-Daudet","Lycée Dhuoda","Lycée privé Emmanuel-d'Alzon","Lycée François-Arago","Lycée Notre-Dame Du Bon Secours","Lycée Georges-Cabanis","Lycée Gay-Lussac","Lycée Léonard-Limosin","Lycée Turgot","Lycée Edmond-Perrier","Lycée Claude-Gellée","Lycée Jean-Moulin","Lycée Fabert","Lycée Georges-de-La-Tour","Lycée Louis de Cormontaigne","Lycée Louis-Vincent","Lycée privé Jean-XXIII","Lycée Frédéric-Chopin","Lycée Henri-Loritz","Lycée Henri-Poincaré","Lycée Notre-Dame Saint-Sigisbert","Lycée Techno Ducos","Lycée de Bellevue","Lycée Joseph-Gaillard","Lycée Frantz Fanon","Lycée Bellevue","Lycée Lapérouse","Lycée Louis-Rascol","Lycée privé Saliège","Lycée d'enseignement général et technologique agricole","Lycée Pierre-Paul-Riquet","Lycée Jean-Dupuy","Lycée Théophile-Gautier","Lycée Bellevue","Lycée Déodat-de-Séverac","Lycée Ozenne","Lycée Rive Gauche","Lycée Pierre-de-Fermat","Lycée privé Saint-Joseph","Lycée Saint-Sernin","Lycée de La Borde Basse","Lycée Gustave-Eiffel","Lycée Gambetta","Lycée Robespierre","Lycée Sainte-Marie","Lycée Mariette","Lycée Albert-Châtelet","Institution Saint-Jean","Lycée de l'Europe","Lycée Jean-Bart","Lycée César-Baggio","Lycée Faidherbe","Lycée privé Frédéric-Ozanam","Lycée Gaston-Berger","Lycée privé Notre-Dame-de-la-Paix","Lycée privé Saint-Paul","Lycée privé Saint-Pierre","Lycée privé Notre-Dame De Grâce","Lycée Colbert","Lycée Gambetta","Lycée du Hainaut","Lycée Henri-Wallon","Lycée Watteau","Lycée d'Angers-le-Fresne","Lycée Chevrollier","Lycée Henri Bergson","Lycée Joachim-du-Bellay","Lycée privé Mongazon","Lycée privé Saint-Martin","Prytanée national militaire","Lycée Pierre-Mendès-France","Lycée privé Saint-Joseph","Lycée Gabriel-Touchard","Lycée Montesquieu","Lycée Saint Charles-Sainte Croix","Lycée Carcouët","Lycée externat des Enfants-Nantais","Lycée Georges-Clemenceau","Lycée Gabriel-Guist'hau","Lycée Eugène-Livet","Lycée privé La Perverie","Lycée privé Saint-Joseph-du-Loquidy","Lycée privé Saint-Stanislas","Lycée Vial","Lycée Aristide-Briand","Lycée privé Saint-Joseph La Joliverie","Lycée privé Saint-Aubin-La-Salle","Lycée Édouard-Branly","Lycée Édouard-Gand","Lycée la Hotoie","Lycée Louis-Thuillier","Lycée Madeleine-Michelis","Lycée Pierre-d'Ailly","Lycée Marie-Curie","Lycée Jean Calvin","Lycée Pierre de la Ramée","Lycée Henri-Martin","Lycée Guez-de-Balzac","Lycée Jean-Dautet","Lycée Léonce-Vieljeux","Lycée de la Venise Verte","Lycée Aliénor-d’Aquitaine","Lycée Camille-Guérin","Lycée Nelson-Mandela","Lycée militaire d'Aix-en-Provence","Lycée privé de la Nativité","Lycée Paul-Cézanne","Lycée Vauvenargues","Lycée Frédéric-Mistral","Lycée privé Saint-Joseph","Lycée Dominique-Villars","Lycée Antonin-Artaud","Lycée privé la Cadenelle","Lycée Jean-Perrin","Lycée Jeanne-Perrimond","Lycée privé Notre-Dame de Sion","Lycée Saint-Charles","Lycée Saint-Exupéry","Lycée Thiers","Lycée l'Empéri","Lycée Carnot","Lycée privé Stanislas","Lycée Jules Ferry","Lycée Beau Site","Lycée Les Eucalyptus","Lycée Masséna","Lycée privé Saint-Joseph","Lycée Dumont-d'Urville","Lycée Rouvière","Lycée international de Valbonne","Lycée Roland-Garros","Lycée Amiral Bouvet","Lycée de Bellepierre","Lycée Leconte-de-Lisle","Lycée Lislet Geoffroy","Lycée La Salle-Saint-Charles","Lycée Berthollet","Lycée Saint-Denis","Lycée Louis-Lachenal","Lycée Monge","Lycée Vaugelas","Lycée privé ITEC Boisfleury","Lycée Champollion","Lycée Des Eaux Claires","Lycée Vaucanson","École des Pupilles de l'Air","Lycée Camille-Vernet","Lycée Ferdinand-Buisson","Lycée privé Montplaisir","Lycée Edgar-Quinet","Lycée Lalande","Lycée Ampère","Lycée Assomption-Bellevue","Lycée privé Aux Lazaristes","Institution privée des Chartreux","Lycée Édouard-Branly","Lycée Édouard-Herriot","Lycée Jean-Perrin","Lycée Juliette-Récamier","Lycée La Martinière Duchère","Lycée La Martinière Monplaisir","Lycée La Martinière Terreaux","Lycée privé Notre-Dame des Minimes","Lycée de Saint-Just","Lycée du Parc","Lycée privé Saint-Marc","Externat privé Sainte-Marie","Lycée Français", "Lycée Claude-Fauriel","Lycée Étienne-Mimard","Lycée privé St-Louis La Salle","Lycée Condorcet","Lycée Claude-Bernard","Lycée Descartes (Tours)"]
