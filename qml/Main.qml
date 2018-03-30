import VPlayApps 1.0
import VPlay 1.0
import VPlay 2.0
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtMultimedia 5.8
import QtQuick.Window 2.3
import QtQml 2.2
import QtSensors 5.9
import "AppLogic.js" as LOGIC

App {
    id: root
    property var songRow: undefined
    property int sequentialMode: Playlist.Sequential
    property int randomMode: Playlist.Random
    property int repeatAllMode: Playlist.Loop
    property int repeatCurrentMode: Playlist.CurrentItemInLoop
    property int totalDuration: 0
    property bool isFirstTime: true
    property int currentSongIndex: 0
    readonly property string playIcon: IconType.play
    property string pIcon: IconType.play
    readonly property string pauseIcon: IconType.pause
    readonly property string controlColor: "#262673"
    readonly property string shuffleOnIcon: "../assets/icons/shuffle.png"
    readonly property string shuffleOffIcon: "../assets/icons/shuffle-off.png"
    property string shuffleIcon: shuffleOffIcon
    property string remTime: "00:00"
    property string totalTime: "00:00"
    property string currentSongName: ""
    property string bgimage: "../assets/navbar-bg.jpeg"
    readonly property string keyString: "AF83995C2734BB4BD8ACD38745DB92A5690BA06E724E5
                                3A8CA86DEA8D70D7D15C07934C78DEC3DEDA6BECC0A69
                                E1F459A2E505BCCCC03BFE17D923BC0F475F8D8695A87
                                66C234491D8D66B8078E9D1F3E25F8B3ADE396DB04CC0
                                1C9A6C20CCD729E6090CC7BAEB658D4AFD4A4970EE250
                                B3682FD1D147FC44F49E763F9C876D5DF163CF3FE0FCF
                                702985631000F791BA83E89803991D52F7F07BCB51DD1
                                A22C12054DA9C8A951276C592BAB5E07F7BD81280E4F3
                                9F3E4227A728FCDCAFAAF489B0A39F0A74FE0BA5842E2
                                480A1832E410063114C0A4761ADA79CEFAB506B3D5F77
                                09B7E0473DB408D7E654D537392E8724F7CCC1CA458C3
                                744CDAF97ADD653672CB9165AEAD8A9EE6B8E6D23AA0F
                                FDAB3A6D6E5ECB64BCBCD64CC434734B00A015546B4C6
                                13246ECA3BE90B893F8815D"

    licenseKey: keyString

    onInitTheme:
    {
        Theme.navigationBar.backgroundColor = "#212121"
        Theme.tabBar.backgroundColor = "#212121"
        Theme.tabBar.titleOffColor = "#9E9E9E"
        Theme.colors.textColor = "white"
        Theme.navigationAppDrawer.textColor = "#E1BEE7"
        Theme.navigationAppDrawer.activeTextColor = "#E91E63"
        Theme.navigationAppDrawer.backgroundColor = "#212121"
        Theme.navigationAppDrawer.itemBackgroundColor = "#212121"
        Theme.navigationAppDrawer.dividerColor = "#7B1FA2"
        Theme.colors.scrollbarColor = "#EEEEEE"
    }

    SongPlayerPage
    {
        id: playingpage
    }

    Navigation
    {
        id: mainNav
        NavigationItem
        {
            id: songsItem
            title: "Songs"
            icon: IconType.music
            NavigationStack
            {
                id: songsStack
                SongPage { id: mainPage }
            }
        }

        NavigationItem
        {
            id: aboutNavItem
            icon: IconType.info
            title: "Info"
            NavigationStack
            {
                id: aboutNavStack
                AboutPage { id: aboutpage }
            }
        }

        NavigationItem
        {
            id: settingsNavItem
            icon: IconType.cogs
            title: "Settings"
            NavigationStack
            {
                id: settingsNavStack
                SettingPage { id: settngpage }
            }
        }
    }

    MediaPlayer
    {
        id: batplayer
        playlist: mainplaylist
        onPositionChanged:
        {
            LOGIC.calculateRemTime(position)
            LOGIC.updateSongSlider(position)
        }
        onDurationChanged:
        {
            LOGIC.calculateTotalTime(duration)
        }
        onPaused:
        {
            playingpage.startAnimation = false
            LOGIC.setPlayPauseIcon(false)
        }
        onPlaying:
        {
            if(playingpage.startAnimation == false)
                playingpage.startAnimation = true
            LOGIC.setPlayPauseIcon(true)
        }
    }
    Playlist
    {
        id: mainplaylist
        playbackMode: Playlist.Loop
        onCurrentIndexChanged:
        {
            LOGIC.songChanged(currentItemSource)
            currentSongIndex = currentIndex
        }
        onPlaybackModeChanged: { LOGIC.setShuffleIcon(playbackMode) }
    }

    SensorGesture
    {
        id: gestureSensor
        enabled: (Qt.platform.os == "android" ? true : false)
        gestures: ["QtSensors.shake2"]
        onDetected:
        {
            if(gesture === "shakeLeft")
                LOGIC.playPrevTrack()
            if(gesture === "shakeRight")
                LOGIC.playNextTrack()
            if(gesture === "shakeDown")
                LOGIC.playOrPause()
        }
    }

    Storage
    {
        id: database
    }

    onSplashScreenFinished:
    {
        LOGIC.check()
    }

    onClosing:
    {
        console.log("onClosingEvent")
        LOGIC.saveData()
    }
}
