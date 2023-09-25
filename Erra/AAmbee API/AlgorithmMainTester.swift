//
//  AlgorithmMainTester.swift
//  Erra
//
//  Created by Heidi Schultz on 9/25/23.
//

import PythonKit
import Foundation

let pd = Python.import("pandas")
let time = Python.import("time")
let requests = Python.import("requests")

let sklearn = Python.import("sklearn")
let RandomForestClassifier = sklearn.ensemble.RandomForestClassifier
let train_test_split = sklearn.model_selection.train_test_split
let accuracy_score = sklearn.metrics.accuracy_score
let precision_score = sklearn.metrics.precision_score
let recall_score = sklearn.metrics.recall_score
let f1_score = sklearn.metrics.f1_score
let roc_auc_score = sklearn.metrics.roc_auc_score

func fetchRealTimeFireData(latitude: Double, longitude: Double, dayRange: Int = 1) -> [(Double, Double)] {
    let apiURL = "https://api.example.com/api/area/csv/[MAP_KEY]/[SOURCE]/\(latitude),\(longitude)/\(dayRange)"
    
    do {
        let response = try requests.get(apiURL)
        response.raise_for_status()
        let data = response.text?.split(separator: "\n") ?? []
        
        var fireCoordinates: [(Double, Double)] = []
        for line in data {
            let parts = line.split(separator: ",")
            if parts.count >= 2 {
                let lat = Double(parts[0])!
                let lon = Double(parts[1])!
                fireCoordinates.append((lat, lon))
            }
        }
        
        return fireCoordinates
    } catch {
        print("API request failed: \(error)")
        return []
    }
}

func preprocessHistoricalData(df: PythonObject) -> (PythonObject, PythonObject) {
    df.dropna(inplace: true)
    df["date"] = df["date"].str.to_datetime(format: "%Y-%m-%d %H:%M:%S")
    df["day_of_week"] = df["date"].dt.dayofweek
    df["month"] = df["date"].dt.month
    let features = ["temperature", "humidity", "wind_speed", "day_of_week", "month"]
    let X = df[features]
    let y = df["fire_occurrence"]
    return (X, y)
}

func main() {
    while true {
        let latitude = 123.456  // Replace with your latitude
        let longitude = 789.012  // Replace with your longitude
        let realTimeFireCoordinates = fetchRealTimeFireData(latitude: latitude, longitude: longitude)

        // Create a DataFrame for real-time fire coordinates
        let realTimeFireDataFrame = pd.DataFrame(realTimeFireCoordinates, columns: ["latitude", "longitude"])

        // Fetch historical fire data and preprocess it
        let historicalFireData = fetchRealTimeFireData(latitude: latitude, longitude: longitude)
        let historicalFireDataFrame = pd.DataFrame(historicalFireData)
        let (X, y) = preprocessHistoricalData(df: historicalFireDataFrame)

        // Combine real-time and historical data
        let combinedDf = pd.concat([historicalFireDataFrame, realTimeFireDataFrame])

        // Split the data into training and testing sets
        let result = train_test_split(combinedDf, y, test_size: 0.2, random_state: 42)
        let XTrain = result[0]
        let XTest = result[1]
        let yTrain = result[2]
        let yTest = result[3]

        // Create and train a Random Forest Classifier
        let clf = RandomForestClassifier(n_estimators: 100, max_depth: 10, random_state: 42)
        clf.fit(XTrain, yTrain)

        // Make predictions on the test set
        let yPred = clf.predict(XTest)

        // Calculate evaluation metrics
        let accuracy = accuracy_score(yTest, yPred)
        let precision = precision_score(yTest, yPred)
        let recall = recall_score(yTest, yPred)
        let f1 = f1_score(yTest, yPred)
        let rocAuc = roc_auc_score(yTest, clf.predict_proba(XTest)[0])

        // Print evaluation metrics
        print("Accuracy:", accuracy)
        print("Precision:", precision)
        print("Recall:", recall)
        print("F1 Score:", f1)
        print("ROC-AUC Score:", rocAuc)

        // Sleep for a specified interval before fetching real-time data again
        time.sleep(600)  // Sleep for 10 minutes (adjust as needed)
    }
}


