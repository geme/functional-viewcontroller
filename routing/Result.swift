//
//  Result.swift
//  hmmhKit
//
//  Created by Carsten Könemann on 16/02/16.
//  Copyright © 2016 hmmh. All rights reserved.
//

public enum Result<T, E> {

    case Value(T)
    case Error(E)

    public init(_ e: E) {
        self = .Error(e)
    }

    public init(_ t: T) {
        self = .Value(t)
    }

    public func then<U>(_ f: (T) -> Result<U, E>) -> Result<U, E> {
        switch self {
            case let .Value(value):
                return f(value)
            case let .Error(error):
                return .Error(error)
        }
    }

    public func onValue(_ f: (T) -> Void) -> Result<T, E> {

        switch self {
            case let .Value(value):
                f(value)
            default:
                break
        }

        return self
    }

    public func onError(_ f: (E) -> Void) -> Result<T, E> {

        switch self {
            case let .Error(error):
                f(error)
            default:
                break
        }

        return self
    }

}

public extension Result {

    public var isSuccess: Bool {
        switch self {
            case .Value:
                return true
            case .Error:
                return false
        }
    }

    public var isError: Bool {
        switch self {
            case .Value:
                return false
            case .Error:
                return true
        }
    }

}

public extension Result {

    public var peek: T? {
        switch self {
            case let .Value(value):
                return value
            default:
                return nil
        }
    }

}
