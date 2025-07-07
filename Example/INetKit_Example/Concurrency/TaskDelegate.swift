//
//  TaskDelegate.swift
//  INetKit_Example
//
//  Created by Taiyou on 2025/7/1.
//

import Foundation
import INetKit
class TaskDelegate: NSObject,PTaskDelegate{
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        print(metrics, "Metrics")
    }
}
