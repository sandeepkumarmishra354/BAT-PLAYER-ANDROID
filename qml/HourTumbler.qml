import QtQuick 2.9
import QtQuick.Controls 2.3
import VPlayApps 1.0

Item
{
    id: main
    function resetCurrentIndex()
    {
        control.currentIndex = 0
    }

    function getCurrentIndex()
    {
        return control.currentIndex
    }
    Tumbler
    {
        id: control
        anchors.fill: parent
        model: 13
        clip: false
        wheelEnabled: true
        smooth: true
        delegate: AppText
        {
            text: index
            font: control.font
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
        }
        Rectangle {
                anchors.horizontalCenter: control.horizontalCenter
                y: control.height * 0.4
                width: 40
                height: 1
                color: propertycontainer.lightPink
            }

            Rectangle {
                anchors.horizontalCenter: control.horizontalCenter
                y: control.height * 0.6
                width: 40
                height: 1
                color: propertycontainer.lightPink
            }
    }
}
