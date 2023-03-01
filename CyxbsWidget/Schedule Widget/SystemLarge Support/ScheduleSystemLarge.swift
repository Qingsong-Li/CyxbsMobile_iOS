//
//  ScheduleSystemLarge.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2022/12/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ScheduleSystemLarge: View {
    var entry: ScheduleProvider.Entry
    var data: ScheduleFetchData
    
    init(entry: ScheduleProvider.Entry) {
        self.entry = entry
        let hour = Calendar(identifier: .republicOfChina).dateComponents(in: TimeZone(identifier: "Asia/Chongqing")!, from: entry.date).hour!
        let range: Range<Int>!
        if hour < 10 {
            range = 1..<7
        } else if hour < 12 {
            range = 3..<9
        } else if hour < 16 {
            range = 5..<11
        } else {
            range = 7..<13
        }
        data = ScheduleFetchData(range: range, section: entry.section)
        data.sno = entry.mainKey?.sno
        for item in entry.combineItems {
            data.combineItem(item)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScheduleSectionTopView(title: title())
                .padding(.vertical, 5)
                .padding(.leading, 5)
            Divider()
                .padding(.horizontal, 8)
                .padding(.bottom, 2)
            
            GeometryReader { allEntry in
                VStack(spacing: 2) {
                    ScheduleTopView(anyDate: topDate(), width: 23)
                        .frame(height: allEntry.size.width / 7)
                    
                    HStack(spacing: 5) {
                        ScheduleLeadingView(range: data.range)
                            .padding(.leading, 5)
                            .frame(width: 20)
                        GeometryReader { entryB in
                            if entry.combineItems.count != 0 {
                                if data.data.count != 0 {
                                    ForEach(data.data) { item in
                                        Link(destination: url(in: item.indexPath)) {
                                            ContentView(item: item, size: entryB.size)
                                        }
                                    }
                                } else {
                                    Text("这个时间段暂时没有课")
                                        .font(.system(size: 13))
                                        .padding()
                                }
                            } else {
                                VStack (alignment: .leading) {
                                    Text("小组件请求错误，打开App并检查网络或设置学号")
                                    Text("\(entry.date)")
                                    if entry.errorKeys.count >= 1 {
                                        Text("信息: \(entry.errorKeys[0])")
                                    } else {
                                        Text("信息: 未确定主学号")
                                    }
                                }
                                .font(.system(size: 13))
                            }
                        }
                        .clipped()
                    }
                }
            }
        }
    }
}

extension ScheduleSystemLarge {
    
    func url(in indexPath: NSIndexPath) -> URL {
        URL(string: "https://redrock.team/schedule/detail?section=\(indexPath.section)&week=\(indexPath.week)&location=\(indexPath.location)")!
    }
    
    func ContentView(item: ScheduleFetchData.PartItem, size: CGSize) -> some View {
        let itemHeight = (size.height - 2.0 * 7) / CGFloat(data.range.count)
        let itemWidth = (size.width - 2.0 * 6) / 7
        
        let vm = item.viewModel
        let idx = item.indexPath as NSIndexPath
        
        return ScheduleContentView(title: vm.title,
                                   content: vm.content,
                                   draw: draw(vm.kind, locate: idx.location),
                                   muti: vm.hadMuti)
        .frame(width: itemWidth, height: itemHeight * CGFloat(vm.lenth) + 2.0 * CGFloat(vm.lenth - 1))
        .padding(.top, (itemHeight + 2) * CGFloat(idx.location - data.range.lowerBound))
        .padding(.leading, (itemWidth + 2.0) * CGFloat(idx.week - 1))
        
        func draw(_ kind: ScheduleBelongKind = .fistSystem, locate: Int) -> ScheduleContentView.DrawType {
            switch kind {
            case .fistSystem:
                if locate <= 4 {
                    return .morning
                } else if locate <= 8 {
                    return .afternoon
                } else {
                    return .night
                }
            case .fistCustom:
                return .custem
            case .secondSystem:
                return .other
            @unknown default:
               return .empty
            }
        }
    }
    
    func topDate() -> Date? {
        if self.data.section <= 0 {
            return nil
        } else {
            return data.start?.addingTimeInterval(TimeInterval((self.data.section - 1) * 7 * 24 * 60 * 60))
        }
    }
    
    func title() -> String {
        if data.section <= 0 {
            return "整学期"
        } else {
            return "第\(data.section)周"
        }
    }
    
    func month() -> String {
        if let start = data.start {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "Asia/Chongqing")!
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "M月"
            return formatter.string(from: start)
        } else {
            return "学期"
        }
    }
}




struct ScheduleSystemLarge_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleSystemLarge(entry: ScheduleTimelineEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
