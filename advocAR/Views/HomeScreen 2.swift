//  HomeScreen.swift//


import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


// Convert variable to hashable, because whenever a for loop executes it needs to be able to specify an unique id for the actual elementa\ and when you make something hashable it makes itbasically uniquein the sense of every single element with the different valeus for the name post and image name are goinf to be unique are goinf to be unique and you are going to compute rather swift ui is going to compute unique hash just some string value to represent it.
struct PostModel: Hashable {
    // variables of every post
    let name: String
    let post: String
    let imageName: String
}

struct HomeScreen: View {
    
    @State private var imageURL = URL(string: "")

    @ObservedObject var model = NewPostService()

    @State var sortedPosts = NewPostService()

//    @Binding var text: String
    //These are offers, shown on the home screen.
    let stories = ["story1", "story2", "story3", "story1", "story2", "story3"]
    
    @ObservedObject var modelStory = StoryService()
    
//    let posts: [NewPostModel] = [
//        NewPostModel(id: "1111", name: "Ashkan Goharfar", post: "Hello, welcome to Smart Online Shopping application :)", imageName: "person1"),
//        NewPostModel(id: "1112", name: "Margo Robby", post: "I like this shop's products and also the Augmented Reality feature of the app which is awsome!!", imageName: "person2"),
//        NewPostModel(id: "1113", name: "Brad Pit", post: "I like this application very much. I hope I can see other version of this application very soon.", imageName: "person3")]
    
    // grabbed facebook rgb color value
    let orangeColor = UIColor(red: 255/255.0,
                               green: 145/255.0,
                               blue: 0/255.0,
                               alpha: 1)
    
    var body: some View {
        // Vertical stack
        VStack {
            // Horizontal stack
            HStack {
                // Assigne for grround color of text
                // Assign Font size

                Text("Smart Online Shopping")
                    .foregroundColor(Color(orangeColor))
                    .font(.system(size: 28, weight: .bold, design: .default))

                // make a spacer to seprate text and sf symbol
                Spacer()
                
                // make SF Symbols which is Apple's very own assets symbols
                // change its size ,assign color, and get background color
                // use resizable to size up image and filll the frane completely
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .foregroundColor(Color(.secondaryLabel))
                    //  .background(Color.red)
                
            }
            .padding()
            
            // First parameter is placeholder
            // $ is for update the UI based on the text in real time
//            TextField("Search...", text: $text)
//                .padding(7)
//                .background(Color(.systemGray5))
//                .cornerRadius(13)
//                .padding(.horizontal, 15)

            // everything are going to stacked up of each other
            // Added scrolling stories horizontally
            ZStack {
                Color(.secondarySystemBackground)
                
                ScrollView(.vertical) {
                    VStack {
                        
//                        StoriesView(stories: stories)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                
                                ForEach(modelStory.list) { story in
                                    WebImage(url: URL(string: story.image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                        .frame(width: 140, height: 200, alignment: .center)
                                        .background(Color.red)
                                    
                                        // fianly clipped it here
                                        .clipped()
                                }
                            }
                            .onAppear(perform: modelStory.getData)
                            .padding()
                        }
                        
                        
                        ForEach (model.list.sorted {$0.time < $1.time}.reversed()) { item in
                            
                            HStack {
                                PostView(model: item)
                                Spacer()

                            }
                        }

                    }
                }
            }
            Spacer()
        }
        .onAppear(perform: model.getData)
            }
    
    func sortPosts(){
        self.sortedPosts.list = model.list.sorted {
            $0.time < $1.time
        }
    }

}
