import QtQuick 2.9
import QtQuick.Controls 2.3
import VPlayApps 1.0
import QtQuick.Controls.Material 2.1
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import "JS/AppLogic.js" as LOGIC

Menu
{
    property int timerInterval: 0
    property int sliderValue: 0
    property int gaugeLastValue: 0
    property bool sliderEnable: true
    id: mainTimerMenu
    opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 400}
    }
    background: Rectangle
    {
        id: bgRect
        radius: 30
        border.width: 1
        border.color: propertycontainer.lightPink
        color: Qt.rgba(0,0,0, 0.75)

        Rectangle
        {
            id: gaugeRect
            width: parent.width
            height: parent.height/2 + parent.height/5
            color: propertycontainer.fullTransparent
        }

        CircularGauge
        {
            id: circulargauge
            anchors.fill: gaugeRect
            minimumValue: 0
            maximumValue: 60
            stepSize: 0.1
            onValueChanged:
            {
                console.log(value)
            }
        }

        NumberAnimation
        {
            id: gaugeAnime
            target: circulargauge
            property: "value"
            from: mainTimerMenu.gaugeLastValue
            to: 0
            duration: mainTimerMenu.gaugeLastValue*60*1000
        }
        NumberAnimation
        {
            id: gaugeResetAnime
            target: circulargauge
            property: "value"
            from: circulargauge.value
            to: 0
            duration: 500
        }

        Rectangle
        {
            id: controlRect
            width: parent.width
            anchors.top: gaugeRect.bottom
            anchors.bottom: parent.bottom
            color: propertycontainer.fullTransparent
            Rectangle
            {
                id: sliderRect
                width: parent.width
                height: parent.height/2.5
                color: propertycontainer.fullTransparent
                AppSlider
                {
                    id: appslider
                    anchors.centerIn: parent
                    to: 60
                    stepSize: 1.0
                    tintedTrackColor: (enabled ? propertycontainer.lightPink : propertycontainer.darkColor)
                    knobColor: propertycontainer.darkColor
                    enabled: mainTimerMenu.sliderEnable
                    onValueChanged:
                    {
                        circulargauge.value = value
                        mainTimerMenu.sliderValue = value
                    }
                }
                NumberAnimation
                {
                    id: sliderResetAnime
                    target: appslider
                    property: "value"
                    from: appslider.value
                    to: 0
                    duration: 500
                }
            }
            Rectangle
            {
                id: othercontrolRect
                width: parent.width
                anchors.top: sliderRect.bottom
                anchors.bottom: parent.bottom
                color: propertycontainer.fullTransparent
                Row
                {
                    anchors.centerIn: parent
                    AppText
                    {
                        text:
                        {
                            if(mainTimerMenu.sliderValue < 10)
                                return qsTr("TT 0%1").arg(mainTimerMenu.sliderValue)
                            else
                                return qsTr("TT %1").arg(mainTimerMenu.sliderValue)
                        }
                        font.pixelSize: sp(12)
                    }
                    IconButton
                    {
                        icon: IconType.play
                        disabledColor: propertycontainer.darkColor
                        color: propertycontainer.lightPink
                        enabled: mainTimerMenu.sliderEnable
                        onClicked:
                        {
                            if(circulargauge.value > 0)
                            {
                                mainTimerMenu.gaugeLastValue = circulargauge.value
                                gaugeAnime.start()
                                quitTimer.start()
                                mainTimerMenu.sliderEnable = false
                            }
                        }
                    }
                    IconButton
                    {
                        icon: IconType.stop
                        color: propertycontainer.lightPink
                        disabledColor: propertycontainer.darkColor
                        enabled: !mainTimerMenu.sliderEnable
                        onClicked:
                        {
                            quitTimer.stop()
                            gaugeAnime.stop()
                            gaugeResetAnime.start()
                            sliderResetAnime.start()
                            circulargauge.value = 0
                            mainTimerMenu.sliderEnable = true
                        }
                    }
                    AppText
                    {
                        text:
                        {
                            var tt = circulargauge.value
                            if(tt < 10)
                                return qsTr("RT 0%1").arg(tt)
                            else
                                return qsTr("RT %1").arg(tt)
                        }
                        font.pixelSize: sp(12)
                    }
                }
            }
        }

        Timer
        {
            id: quitTimer
            interval: mainTimerMenu.gaugeLastValue*60*1000
            onTriggered:
            {
                LOGIC.saveData()
                Qt.quit()
            }
        }
    }

    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }
}
