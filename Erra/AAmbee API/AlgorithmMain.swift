//
//  AlgorithmMain.swift
//  Erra
//
//  Created by Heidi Schultz on 9/19/23.
//

import Foundation
import PythonKit

func fetchRealTimeFireData(latitude: Double, longitude: Double) -> PythonObject {
    let Ambee_Forest_Fire_API = Python.import("Ambee_Forest_Fire_API")
    return Ambee_Forest_Fire_API.get_real_time_fire_data(latitude, longitude)
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
    let pd = Python.import("pandas")
    let train_test_split = Python.import("sklearn.model_selection")
    let time = Python.import("time")
    let RandomForestClassifier = Python.import("sklearn.ensemble").RandomForestClassifier
    let accuracy_score = Python.import("sklearn.metrics").accuracy_score
    let precision_score = Python.import("sklearn.metrics").precision_score
    let recall_score = Python.import("sklearn.metrics").recall_score
    let f1_score = Python.import("sklearn.metrics").f1_score
    let roc_auc_score = Python.import("sklearn.metrics").roc_auc_score
    
    while true {
        // Fetch real-time fire data
        let latitude = 123.456 // Replace with your latitude
        let longitude = 789.012 // Replace with your longitude
        let realTimeFireData = fetchRealTimeFireData(latitude: latitude, longitude: longitude)
        
        // Convert real-time data to a DataFrame (assuming it's provided in a structured format)
        let realTimeDf = pd.DataFrame(realTimeFireData)
        
        // Preprocess historical data (same as before)
        let historicalFireData = fetchRealTimeFireData(latitude: latitude, longitude: longitude)
        let historicalDf = pd.DataFrame(historicalFireData)
        let (X, y) = preprocessHistoricalData(df: historicalDf)
        
        // Combine real-time and historical data for analysis
        let combinedDf = pd.concat([historicalDf, realTimeDf])
    
        // Split the data into training and testing sets
        let result = train_test_split(combinedDf, y, test_size: 0.2, random_state: 42)

        // Unpack the result using Python's tuple unpacking
        let X_train = result.get(0)
        let X_test = result.get(1)
        let y_train = result.get(2)
        let y_test = result.get(3)

        // Create and train a Random Forest Classifier (you can choose other models as well)
        let clf = RandomForestClassifier(n_estimators: 100, max_depth: 10, random_state: 42)
        clf.fit(X_train, y_train)

        // Make predictions on the test set
        let y_pred = clf.predict(X_test)

        // Calculate accuracy and other metrics
        let accuracy = accuracy_score(y_test, y_pred)
        let precision = precision_score(y_test, y_pred)
        let recall = recall_score(y_test, y_pred)
        let f1 = f1_score(y_test, y_pred)
        let roc_auc = roc_auc_score(y_test, clf.predict_proba(X_test).get(0))

        // Print evaluation metrics
        print("Accuracy: \(accuracy)")
        print("Precision: \(precision)")
        print("Recall: \(recall)")
        print("F1 Score: \(f1)")
        print("ROC-AUC Score: \(roc_auc)")

        // Sleep for a specified interval before fetching real-time data again
        time.sleep(600)  // Sleep for 10 minutes (adjust as needed)
    }
}






