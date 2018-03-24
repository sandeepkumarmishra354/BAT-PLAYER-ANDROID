import QtQuick 2.0
import VPlayApps 1.0

Page
{
    id: songplayerpage
    title: "song name"
    property string artist: ""
    property int remTime: 0
    property int totalTime: 0
    signal playpausebtnClicked()
    signal nextTrack()
    signal prevTrack()

    Rectangle
    {
        id: playerimageRect
        width: parent.width
        height: parent.height/2 + parent.height/4
        Image
        {
            id: playerimagebg
            anchors.fill: parent
            source: "../assets/cyan-music.jpg"
        }
    }
    Rectangle
    {
        id: playercontrolar
        width: parent.width
        anchors.top: playerimageRect.bottom
        anchors.bottom: parent.bottom
        Rectangle
        {
            id: playerprogress
            width: parent.width
            height: parent.height/3
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#00b3b3"}
                GradientStop {position: 1.0; color: "#b3ffff"}
            }

            AppText
            {
                id: remtime
                text: remTime
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }
            AppText
            {
                id: totaltime
                text: totalTime
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
            }

            AppSlider
            {
                id: songslider
                width: parent.width - (remtime.width+totaltime.width+20)
                anchors.centerIn: parent
            }
        }
        Rectangle
        {
            id: control
            width: parent.width
            anchors.top: playerprogress.bottom
            anchors.bottom: parent.bottom
            gradient: Gradient {
                GradientStop {position: 1.0; color: "#00b3b3"}
                GradientStop {position: 0.0; color: "#b3ffff"}
            }

            Row
            {
                id: controlRow
                anchors.centerIn: parent
                spacing: dp(30)
                IconButton
                {
                    id: prevbtn
                    color: "#009999"
                    selectedColor: "#00e6e6"
                    size: dp(50)
                    icon: IconType.backward
                    onClicked: songplayerpage.prevTrack()
                }
                IconButton
                {
                    id: playpauebtn
                    color: "#009999"
                    selectedColor: "#00e6e6"
                    size: dp(50)
                    icon: IconType.play
                    onClicked:
                    {
                        playpauebtn.icon = (icon == IconType.play ? IconType.pause : IconType.play)
                        playpausebtnClicked()
                    }
                }
                IconButton
                {
                    id: nextbtn
                    color: "#009999"
                    selectedColor: "#00e6e6"
                    size: dp(50)
                    icon: IconType.forward
                    onClicked: songplayerpage.nextTrack()
                }
            }
        }
    }
}