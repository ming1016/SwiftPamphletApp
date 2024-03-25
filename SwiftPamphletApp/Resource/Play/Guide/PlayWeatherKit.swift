//
//  PlayWeatherKit.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/6/21.
//
//
import Foundation
import SwiftUI
import WeatherKit
import CoreLocation

struct PlayWeatherView: View {
    var locationManager = PLocationManager()
    var weatherServiceHelper = PWeatherData.shared
    @State var attribution: WeatherAttribution?
    @State var isLoading = true
    @State var currentLocation: CLLocation?
    @State var stateText: String = "读取中..."
    
    @State var currentWeather: CurrentWeather?
    @State var dailyForecast: Forecast<DayWeather>?
    @State var hourlyForecast: Forecast<HourWeather>?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView()
                }
                if let current = currentWeather, !isLoading {
                    VStack(alignment: .leading) {
                        Image(systemName: current.symbolName)
                            .font(.system(size: 40, weight: .bold))
                        Text(current.condition.description)
                        Text("\(Int(current.temperature.value))°")
                        Text("湿度：\(Int(current.humidity * 100))%")
                        Text("风速：\(Int(current.wind.speed.value))")
                        Text("\(current.wind.compassDirection.description)")
                        Text("紫外线：\(current.uvIndex.value)")
                        Spacer()
                    }
                } else {
                    Text(stateText)
                }
                
                if let hourly = hourlyForecast {
                    Text("小时天气情况")
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(hourly, id: \.date) { hour in
                                PHourDetailsView(hourWeather: hour)
                            }
                        }
                    }
                }
                
                if let daily = dailyForecast {
                    Text("10天天气情况")
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(daily, id: \.date) { day in
                                PDayDetailsCell(dayWeather: day)
                            }
                        }
                    }
                }
                    
                
                
                PDataAttributionView(weatherAttrib: attribution)
            }
        }
        .padding(20)
        .task {
            isLoading = true
            self.locationManager.updateLocation(handler: locationUpdated)
        }
        
    }
    
    func locationUpdated(location: CLLocation?, error: Error?) {
        if let currentLocation: CLLocation = location, error == nil {
            Task.detached {
                currentWeather = await weatherServiceHelper.currentWeather(for: currentLocation)
                dailyForecast = await weatherServiceHelper.dailyForecast(for: currentLocation)
                hourlyForecast = await weatherServiceHelper.hourlyForcast(for: currentLocation)
                
                // 商标
                attribution = await weatherServiceHelper.weatherAttribution()
                stateText = ""
                isLoading = false
            }
        } else {
            stateText = "无法获取你的定位.\n \(error?.localizedDescription ?? "")"
            isLoading = false
        }
    }
}

// MARK: 小时 Cell
struct PHourDetailsView: View {
    var hourWeather: HourWeather?
    var body: some View {
        if let hour = hourWeather {
            VStack {
                Text(hour.date.formatted(.dateTime.hour()))
                Divider()
                Image(systemName: hour.symbolName)
                Text("\(Int(hour.temperature.value))°")
            }
        }
    }
}

// MARK: 天 Cell
struct PDayDetailsCell: View {
    var dayWeather: DayWeather?
    var body: some View {
        if let day = dayWeather {
            VStack {
                Text(day.date.formatted(.dateTime.day().month()))
                Divider()
                Image(systemName: day.symbolName)
                HStack {
                    Text("\(Int(day.lowTemperature.value))")
                        .foregroundColor(light: .secondary, dark: .secondary)
                    Text("\(Int(day.highTemperature.value))°")
                        .bold()
                }
                
                HStack {
                    VStack {
                        Image(systemName: "sunrise")
                        Text(day.sun.sunrise?.formatted(.dateTime.hour().minute()) ?? "?")
                    }
                    VStack {
                        Image(systemName: "sunset")
                        Text(day.sun.sunset?.formatted(.dateTime.hour().minute()) ?? "?")
                    }
                }
                Divider()
                HStack {
                    VStack {
                        Image(systemName: "moon.circle")
                        Text(day.moon.moonrise?.formatted(.dateTime.hour().minute()) ?? "?")
                    }
                    VStack {
                        Image(systemName: "moon.haze.circle")
                        Text(day.moon.moonset?.formatted(.dateTime.hour().minute()) ?? "?")
                    }
                }
            }
        }
    }
}

// MARK: 商标视图
struct PDataAttributionView: View {
    var weatherAttrib: WeatherAttribution?
    var body: some View {
        if let attrib = weatherAttrib {
            HStack {
                AsyncImage(
                    url: attrib.squareMarkURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30, maxHeight: 30)
                    },
                    placeholder: {
                        ProgressView()
                    })
                
                Link(destination: attrib.legalPageURL) {
                    Text("Weather Data Attribution")
                        .font(Font.footnote)
                }
            }
        }
    }
}

// MARK: 数据部分
@Observable
final class PWeatherData {
    static let shared = PWeatherData()
    private let service = WeatherService.shared
    
    func currentWeather(for location: CLLocation) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(for: location, including: .current)
            return forcast
        }.value
        return currentWeather
    }
    
    func dailyForecast(for location: CLLocation) async -> Forecast<DayWeather>? {
        let dayWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(for: location, including: .daily)
            return forcast
        }.value
        return dayWeather
    }
    
    func hourlyForcast(for location: CLLocation) async -> Forecast<HourWeather>? {
        let hourWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(for: location, including: .hourly)
            return forcast
        }.value
        return hourWeather
    }
    
    func weatherAttribution() async -> WeatherAttribution? {
        let attrib = await Task.detached(priority: .userInitiated) {
            return try? await self.service.attribution
        }.value
        return attrib
    }
}

class PLocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    typealias LocationUpdateHandler = ((CLLocation?, Error?) -> Void)
    private var didUpdateLocation: LocationUpdateHandler?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
    }
    
    public func updateLocation(handler: @escaping LocationUpdateHandler) {
        self.didUpdateLocation = handler
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let handler = didUpdateLocation {
            handler(locations.last, nil)
        }
        manager.stopUpdatingLocation()
    }
    
    func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let handler = didUpdateLocation {
            handler(nil, error)
        }
    }
}

struct PLocation: Identifiable {
    var id: Int
    
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
}

extension PLocation {
    static var previewLocations: [PLocation] {
        return [
            PLocation(id: 1, city: "London", country: "United Kingdom", latitude: 51.509865, longitude: -0.118092),
            PLocation(id: 2, city: "Madrid", country: "Spain", latitude: 40.4168, longitude: 3.7038),
            PLocation(id: 3, city: "Berlin", country: "Germany", latitude: 52.5200, longitude: 13.4050),
            PLocation(id: 4, city: "Rome", country: "Italy", latitude: 41.902782, longitude: 12.496366)
        ]
    }
}
