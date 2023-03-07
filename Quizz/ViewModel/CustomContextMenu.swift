//
//  CustomContextMenu.swift
//  Quizz
//
//  Created by matteo on 04/07/2021.
//

import SwiftUI

struct CustomContextMenu<Content: View, Preview: View>: View {
    
    var content: Content
    var preview: Preview
    // List of actions...
    var menu: UIMenu
    
    init(@ViewBuilder content: @escaping ()->Content, @ViewBuilder preview: @escaping ()->Preview, actions: @escaping()->UIMenu){
        
        self.content = content()
        self.preview = preview()
        self.menu = actions()
    }
    var body: some View {
        ZStack{
            content
                .hidden()
                .overlay(
                    ContextMenuHelper(content: content, preview: preview, actions: menu)
                )
        }
    }
}

struct ContextMenuHelper<Content: View, Preview: View>: UIViewRepresentable{
    
    var content: Content
    var preview: Preview
    var actions: UIMenu
    
    init(content: Content, preview: Preview, actions: UIMenu){
        self.content = content
        self.preview = preview
        self.actions = actions
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        //setting our content view as main interaction view...
        let hostView = UIHostingController(rootView: content)
        
        // setting constrains...
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints...
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor)
        ]
        view.addSubview(hostView.view)
        view.addConstraints(constraints)
        
        // setting interaction...
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(interaction)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate{
        var parent: ContextMenuHelper
        init(parent: ContextMenuHelper) {
            self.parent = parent
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(identifier: nil) {
                // your view ...
                let previewController = UIHostingController(rootView: self.parent.preview)
                previewController.view.backgroundColor = .clear
                
                return previewController
                
            } actionProvider: { items in
                // your actions ...
                return self.parent.actions
            }
        }
    }
}


struct badgeview: View {
    
    @State var badges: [Badge]
    @State var index: Int
    
    @Binding var refreshed: Bool
    
    var body: some View {
        
        CustomContextMenu{
            //Content...
            Label{
                ZStack{
                    
                    Image(badges[index].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .frame(width: 75, height: 75)
                        .background(Color("lightgrey"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("white"), lineWidth: 4).shadow(radius: 10))
                        .opacity(badges[index].unlocked ? 1 : 0)
                    
                    Circle()
                        .fill(Color("badgedisable"))
                        .frame(width: 75, height: 75)
                        .mask(
                            Image(badges[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .frame(width: 75, height: 75))
                        .blur(radius: 1)
                        .background(Color("lightgrey"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("white"), lineWidth: 4).shadow(radius: 10))
                        .opacity(badges[index].unlocked ? 0 : 1)
                    
                }
            } icon: {}
        } preview : {
            // Preview...
            VStack{
                ZStack{
                    
                    Color("white")
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                    
                    Image(badges[index].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .frame(width: 150, height: 150)
                        .background(Color("lightgrey"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("white"), lineWidth: 6).shadow(radius: 10))
                        .opacity(badges[index].unlocked ? 1 : 0)
                    
                    Circle()
                        .fill(Color("badgedisable"))
                        .frame(width: 150, height: 150)
                        .mask(
                            Image(badges[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .frame(width: 150, height: 150))
                        .blur(radius: 1)
                        .background(Color("lightgrey"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("white"), lineWidth: 6).shadow(radius: 10))
                        .opacity(badges[index].unlocked ? 0 : 1)
                    
                }
                
                Text(badges[index].title)
                    .font(.title)
                    .foregroundColor(Color("black").opacity(0.8))
                    .fontWeight(.heavy)
                    .padding(.top)
                    .multilineTextAlignment(.center)
                Text(badges[index].description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
                HStack{
                    Text("Récompense :")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(String(badges[index].reward)) XP")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                .padding(.vertical, 10)
                .background(Color("orange").opacity(0.7))
                .overlay(Color("orange").frame(width: UIScreen.main.bounds.width, height: 5).offset(y:-5).opacity(0.7).shadow(color: Color("black").opacity(0.5), radius: 10, x: 0, y: -5), alignment: .top)
                .overlay(Color("orange").frame(width: UIScreen.main.bounds.width, height: 5).offset(y:5).opacity(0.7).shadow(color: Color("black").opacity(0.5), radius: 10, x: 0, y: 5), alignment: .bottom)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color("lightgrey"))
            
            
        } actions : {
            if badges[index].unlocked {
                if badges[index].claimed {
                    let reclamer = UIAction(title: "Réclamée.", attributes: .disabled){ _ in}
                    return UIMenu(title: "Recevoir ce badge ?", children: [reclamer])
                } else {
                    let reclamer = UIAction(title: "Réclamer"){ _ in
                        DB_Manager().claimBadge(idValue: badges[index].id); refreshed.toggle()}
                    return UIMenu(title: "Recevoir ce badge ?", children: [reclamer])
                }
            } else{
                let reclamer = UIAction(title: "Réclamer", attributes: .disabled){ _ in
                    print("réclamer")}
                return UIMenu(title: "Recevoir ce badge ?", children: [reclamer])
            }
        }
        .background(Color("lightgrey"))
    }
}

//struct Badge_Previews: PreviewProvider {
//    static var previews: some View {
//        HStack{
//            badgeview(badges: badgesclass.badgesmp, index: 1)
//        }
//    }
//}
