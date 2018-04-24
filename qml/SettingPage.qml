import QtQuick 2.0
import VPlayApps 1.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0
import "ThemeLogic.js" as THEMELOGIC

Page
{
    property bool defaultActive: true
    property bool yellowActive: false
    property bool blueActive: false
    property bool mainBg: false
    property bool playingBg: false
    readonly property string defaultTh: "default"
    readonly property string yellowTh: "yellow"
    readonly property string blueTh: "blue"
    id: settingpage
    title: "Setting"
    Rectangle
    {
        anchors.fill: parent
        gradient: propertycontainer.settingBgGradient
    }

    Rectangle
    {
        id: themeRect
        width: parent.width
        height: parent.height/2.3
        anchors.top: parent.top
        color: propertycontainer.fullTransparent
        AppText
        {
            id: themeText
            text: "Themes"
            color: propertycontainer.textColor
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
        }
        Row
        {
            id: clrRect
            spacing: 5
            width: parent.width
            anchors.top: themeText.bottom
            height: themeRect.height/2.3
            Rectangle
            {
                id: defaultTheme
                width: themeRect.width/4.3
                height: width
                radius: width/2
                border.color: propertycontainer.lightGrey
                color: "#212121"
                anchors.right: yellowTheme.left
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                Icon
                {
                    anchors.fill: parent
                    icon: IconType.check
                    color: "#E91E63"
                    opacity: (defaultActive ? 1.0 : 0.0)
                    Behavior on opacity {
                        NumberAnimation { duration: 500 }
                    }
                }
                RippleMouseArea
                {
                    anchors.fill: parent
                    visible: !defaultActive
                    centerAnimation: true
                    onClicked:
                    {
                        defaultActive = true; yellowActive = blueActive = false
                        THEMELOGIC.applyTheme(defaultTh)
                    }
                }
            }
            Rectangle
            {
                id: yellowTheme
                width: themeRect.width/4.3
                height: width
                radius: width/2
                border.color: propertycontainer.lightGrey
                color: "yellow"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Icon
                {
                    anchors.fill: parent
                    icon: IconType.check
                    color: "#E91E63"
                    opacity: (yellowActive ? 1.0 : 0.0)
                    Behavior on opacity {
                        NumberAnimation { duration: 500 }
                    }
                }
                RippleMouseArea
                {
                    anchors.fill: parent
                    visible: !yellowActive
                    centerAnimation: true
                    onClicked:
                    {
                        yellowActive = true; defaultActive = blueActive = false
                        THEMELOGIC.applyTheme(yellowTh)
                    }
                }
            }
            Rectangle
            {
                id: blueTheme
                width: themeRect.width/4.3
                height: width
                radius: width/2
                border.color: propertycontainer.lightGrey
                color: "blue"
                anchors.left: yellowTheme.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                Icon
                {
                    anchors.fill: parent
                    icon: IconType.check
                    color: "#E91E63"
                    opacity: (blueActive ? 1.0 : 0.0)
                    Behavior on opacity {
                        NumberAnimation { duration: 500 }
                    }
                }
                RippleMouseArea
                {
                    anchors.fill: parent
                    visible: !blueActive
                    centerAnimation: true
                    onClicked:
                    {
                        blueActive = true; yellowActive = defaultActive = false
                        THEMELOGIC.applyTheme(blueTh)
                    }
                }
            }
        }
        Rectangle
        {
            width: parent.width
            anchors.top: clrRect.bottom
            anchors.bottom: parent.bottom
            color: propertycontainer.fullTransparent
            //border.color: "white"
            Rectangle
            {
                id: customRect
                anchors.fill: parent
                color: propertycontainer.fullTransparent
                AppText
                {
                    id: customColorText
                    text: "Choose custom color"
                    color: propertycontainer.textColor
                    font.bold: true
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                }
                Rectangle
                {
                    id: circleRect
                    width: parent.width/4 - 10
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: width/2
                    anchors.top: customColorText.bottom
                    anchors.topMargin: 5
                    color: colorDialog.color
                    border.color: "white"
                    z: 1
                    RippleMouseArea
                    {
                        anchors.fill: parent
                        onClicked: colorDialog.open()
                    }
                }
                RectangularGlow
                {
                    anchors.fill: circleRect
                    glowRadius: 2
                    spread: 0.1
                    color: "white"
                    cornerRadius: circleRect.radius+glowRadius
                    z: 0
                }
            }
        }
    }
    Rectangle
    {
        id: otherRect
        width: parent.width
        height: parent.height/3
        anchors.top: themeRect.bottom
        color: propertycontainer.fullTransparent
        AppText
        {
            id: bgimageText
            text: "Change background image"
            color: propertycontainer.textColor
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
        }
        GridLayout
        {
            id: bgimagegridlayout
            anchors.centerIn: parent
            columns: 2
            rows: 3
            AppText {text: "main background"; color: propertycontainer.textColor}
            AppButton
            {
                text: "browse..."
                backgroundColor: propertycontainer.darkColor
                backgroundColorPressed: propertycontainer.lightPink
                onClicked:
                {
                    mainBg = true
                    playingBg = false
                    nativeUtils.displayImagePicker("Choose image")
                }
            }

            AppText {text: "playing background"; color: propertycontainer.textColor}
            AppButton
            {
                text: "browse..."
                backgroundColor: propertycontainer.darkColor
                backgroundColorPressed: propertycontainer.lightPink
                onClicked:
                {
                    playingBg = true
                    mainBg = false
                    nativeUtils.displayImagePicker("Choose image")
                }
            }
            AppText {text: "main background visiblity"; color: propertycontainer.textColor}
            AppButton
            {
                text: (propertycontainer.ifMainImageOn ? "turn off" : "turn on")
                backgroundColor: propertycontainer.darkColor
                backgroundColorPressed: propertycontainer.lightPink
                onClicked: propertycontainer.ifMainImageOn = !propertycontainer.ifMainImageOn
            }
        }
        Connections
        {
            target: nativeUtils
            onImagePickerFinished:
            {
                if(accepted)
                {
                    if(mainBg)
                        propertycontainer.mainBgImage = path
                    if(playingBg)
                        propertycontainer.defaultCoverArt = path
                }
            }
        }
    }

    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            console.log("You chose: " + colorDialog.color)
            propertycontainer.darkColor = color
            propertycontainer.settingGradientUp = color
            propertycontainer.lightPink = color
            THEMELOGIC.initTheme()
            close()
        }
        onRejected: {
            console.log("Canceled")
            close()
        }
        Component.onCompleted: visible = false
    }
}
