import QtQuick 2.0

Rectangle {
    id:root
    width: parent.width-20
    height: width
    color: "transparent"
    anchors.centerIn: parent

    property int currentHours: currentDate.getHours()
    property int currentMinutes: currentDate.getMinutes()
    property int currentSeconds: currentDate.getSeconds()
    property var currentDate: new Date()

    Timer{
        id:timer
        repeat: true
        interval: 1000
        running: true
        onTriggered: currentDate=new Date()
    }

    // clock face - 5 rectangles
    Rectangle{
        id: plate
        anchors.centerIn: parent
        height: Math.min(root.width,root.height)
        width: height
        radius: width/2
        color: "black"
        border.color: "darkblue"
        border.width: 14
    }

    Rectangle{
        id: externalCircle
        anchors.centerIn: parent
        height: plate.height
        width: height
        radius: width/2
        color: "transparent"
        border.color: "gold"
        border.width: 3
    }

    Rectangle{
        id: internalCircle
        anchors.centerIn: parent
        height:externalCircle.height-22
        width: height
        radius: width/2
        color: "transparent"
        border.color: "gold"
        border.width: 3
    }

    Rectangle{
        id: minCircle
        anchors.centerIn: parent
        height: internalCircle.height-95
        width: height
        radius: width/2
        color: "transparent"
        border.color: "gold"
        border.width: 3
    }

    Rectangle{
        id:center
        z:5
        anchors.centerIn: plate
        height: plate.height*0.1
        width: height
        radius: height/2
        color: "gold"
    }

    // clock hands
//    Rectangle {
//        id: secondHand
//        z:3
//        anchors.top:plate.top
//        anchors.bottom: plate.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//        property int partSecond: 60
//        Rectangle{
//            width: 3
//            height: plate.height*0.4
//            radius: width/2
//            color: "red"
//            anchors.horizontalCenter: secondHand.horizontalCenter
//            antialiasing: true
//            y:secondHand.height*0.1
//        }
//        rotation: 360/partSecond*(currentSeconds%partSecond)
//        antialiasing: true
//    }

    // clock hands with animation
    Rectangle{
        id:segment
        x: parent.width/2
        y: parent.height/2
        width: 3
        height: plate.height*0.4
        radius: width/2
        color: "red"
        transform: Rotation {
            origin.x:segment.width/2
            origin.y: 0
            angle: 180+360/60*(currentSeconds%60)
            Behavior on angle {
                SpringAnimation {
                    spring: 2;
                    damping: 0.2;
                    modulus: 360 }
            }
        }
    }

    Item {
        id: minuteHand
        anchors.top:plate.top
        anchors.bottom: plate.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        property int partMinute: 60
        Rectangle{
            width: 6
            height: plate.height*0.35
            radius: width/2
            color: "lightblue"
            border.width: 1
            border.color: "blue"
            anchors.horizontalCenter: minuteHand.horizontalCenter
            antialiasing: true
            y:minuteHand.height*0.15
        }
        rotation: 360/partMinute*(currentMinutes%partMinute)
        antialiasing: true
    }

    Item {
        id: hourHand
        z:2
        anchors.top:plate.top
        anchors.bottom: plate.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        property int partHour: 12
        Rectangle{
            width: 8
            height: plate.height*0.3
            radius: width/2
            color: "lightblue"
            border.width: 1
            border.color: "blue"
            anchors.horizontalCenter: hourHand.horizontalCenter
            antialiasing: true
            y:hourHand.height*0.2
        }
        rotation: 360/partHour*(currentHours%partHour)+ 360/partHour*(currentMinutes/60)
        antialiasing: true
    }


    Repeater{
        model: 12
        Item{
            id: mark
            property int hourMark: index
            height: plate.height/2
            transformOrigin: Item.Bottom
            rotation: index*30
            x: plate.width/2
            y: 0
            Rectangle{
                height: plate.height*0.1
                width: height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                Text {
                    anchors.fill: parent
                    text: hourMark===0? 12: hourMark
                    font.bold: true
                    color: "gold"
                    rotation: 360-index*30
                    font.pixelSize: 26
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit
                }
            }
        }
    }

}







