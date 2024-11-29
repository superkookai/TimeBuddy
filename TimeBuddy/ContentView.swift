//
//  ContentView.swift
//  TimeBuddy
//
//  Created by Weerawut Chaiyasomboon on 29/11/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var timeZones = [String]()
    @State private var newTimeZone = "GMT"
    @State private var selectedTimeZones: Set<String> = []
    @State private var id = UUID()
    @State private var isInTheList = false
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button("Quit", systemImage: "xmark.circle.fill", action: quit)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            
            if timeZones.isEmpty {
//                Text("Please add your time zones below.")
//                    .frame(maxHeight: .infinity)
                ContentUnavailableView("Please add your first time zone below.", systemImage: "questionmark.circle")
            }else{
                List(selection: $selectedTimeZones){
                    ForEach(timeZones, id: \.self) { timeZone in
                        let time = timeData(for: timeZone)
                        HStack {
                            Button("Copy", systemImage: "doc.on.doc") {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(time, forType: .string)
                            }
                            .buttonStyle(.borderless)
                            .labelStyle(.iconOnly)
                            
                            Text(time)
                        }
                    }
                    .onMove(perform: moveItems)
                }
                .onDeleteCommand(perform: deleteItems)
            }
            
            HStack{
                Picker("Add time zone", selection: $newTimeZone) {
                    ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { timeZone in
                        Text(timeZone)
                    }
                }
                
                Button("Add") {
                    if !timeZones.contains(newTimeZone){
                        timeZones.append(newTimeZone)
                        save()
                    }else{
                        isInTheList.toggle()
                    }
                }
                .id(id)
                .sheet(isPresented: $isInTheList) {
                    ExistingAlertView(showAlert: $isInTheList)
                }
//                .alert("Selected time zone already in the list!", isPresented: $isInTheList) {
//
//                }
            }
        }
        .padding()
        .frame(height: 300)
        .onAppear(perform: load)
        .onReceive(timer) { _ in
            if !isInTheList{
                if NSApp.keyWindow?.isVisible == true{
                    id = UUID()
                }
            }
        }
    }
    
    func timeData(for zoneName: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(identifier: zoneName)
        return "\(zoneName): \(dateFormatter.string(from: .now))"
    }
    
    func load(){
        timeZones = UserDefaults.standard.stringArray(forKey: "TimeZones") ?? []
    }
    
    func save(){
        UserDefaults.standard.set(timeZones, forKey: "TimeZones")
    }
    
    func deleteItems() {
        withAnimation {
            timeZones.removeAll(where: selectedTimeZones.contains)
        }
        save()
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        timeZones.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    func quit(){
        NSApp.terminate(nil)
    }
}

#Preview {
    ContentView()
}
