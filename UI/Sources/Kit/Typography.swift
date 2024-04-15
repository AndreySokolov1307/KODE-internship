import UIKit

public enum Typography {

    public static let title = TextStyle(
        name: "title",
        size: 34,
        weight: .bold,
        lineHeight: 41
    )

    public static let largetitle = TextStyle(
        name: "largeTitle",
        size: 28,
        weight: .medium,
        lineHeight: 34
    )

    public static let subtitle = TextStyle(
        name: "subtitle",
        size: 20,
        weight: .semibold,
        lineHeight: 25
    )

    public static let subtitle2 = TextStyle(
        name: "subtitle2",
        size: 17,
        weight: .semibold,
        lineHeight: 22
    )

    public static let body = TextStyle(
        name: "body",
        size: 20,
        weight: .regular,
        lineHeight: 25
    )

    public static let body1 = TextStyle(
        name: "body1",
        size: 17,
        weight: .regular,
        lineHeight: 22
    )

    public static let body2 = TextStyle(
        name: "body2",
        size: 15,
        weight: .regular,
        lineHeight: 20
    )

    public static let body3 = TextStyle(
        name: "body2",
        size: 15,
        weight: .semibold,
        lineHeight: 20
    )

    public static let caption1 = TextStyle(
        name: "caption1",
        size: 13,
        weight: .regular,
        lineHeight: 15
    )

    public static let caption2 = TextStyle(
        name: "caption2",
        size: 11,
        weight: .regular,
        lineHeight: 13
    )

    public static let button = TextStyle(
        name: "button",
        size: 15,
        weight: .semibold,
        lineHeight: 18
    )
}
