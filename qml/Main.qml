import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtMultimedia 5.8
import QtQuick.Window 2.3
import QtQml 2.2
import QtSensors 5.9
import RemoveFile 1.0
import "AppLogic.js" as LOGIC

App {
    // All fixed properties
    id: root
    readonly property int sequentialMode: Playlist.Sequential
    readonly property int randomMode: Playlist.Random
    readonly property int repeatAllMode: Playlist.Loop
    readonly property int repeatCurrentMode: Playlist.CurrentItemInLoop
    readonly property string playIcon: IconType.play
    readonly property string pauseIcon: IconType.pause
    readonly property string controlColor: "#262673"
    readonly property string shuffleOnIcon: "../assets/icons/shuffle.png"
    readonly property string shuffleOffIcon: "../assets/icons/shuffle-off.png"
    // All changable properties
    property string pIcon: IconType.play
    property var songRow: undefined
    property int totalDuration: 0
    property bool isFirstTime: true
    property int currentSongIndex: 0
    property string bgimage: "../assets/navbar-bg.jpeg"
    property string remTime: "00:00"
    property string totalTime: "00:00"
    property string currentSongName: ""
    property bool shuffleOn: false
    property bool allOff: true
    property bool repeatAll: false
    property bool repeatOne: false
    property string selectedSongPath: ""
    property string selectedSongName: ""
    property int selectedSongIndex: -1
    property var tempModel: []
    readonly property string licenseKeyString: "AF83995C2734BB4BD8ACD38745DB92A5690BA06E724E5
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

    licenseKey: licenseKeyString

    ListModel { id: allSongModel } // model of main song list
    ListModel { id: playlistModel } // model of playlist names
    ListModel { id: playlistSongModel } // model of playlist songs
    Storage { id: database; clearAllAtStartup: true } // settings storage
    RemoveFile { id: removeId } // delete song by this c++ type
    SongPlayerPage { id: playingpage } // main playing page
    PlaylistSongPage { id: playlistsongpage} // playlist song container page

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
        Theme.navigationAppDrawer.dividerColor = "#212121"
        Theme.colors.scrollbarColor = "#EEEEEE"
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
                id: navigationStack
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

    Playlist
    {
        id: mainplaylist
        playbackMode: Playlist.Loop
        onCurrentIndexChanged:
        {
            LOGIC.songChanged(currentItemSource)
            currentSongIndex = currentIndex
        }
        onPlaybackModeChanged:
        {
            LOGIC.setRepeatShuffle(playbackMode)
        }
    }

    MediaPlayer
    {
        id: batplayer
        playlist: mainplaylist
        onPositionChanged:
        {
            LOGIC.calculateRemTime(position)
        }
        onDurationChanged:
        {
            LOGIC.calculateTotalTime(duration)
        }
        onPaused:
        {
            LOGIC.setPlayPauseIcon(false)
        }
        onPlaying:
        {
            LOGIC.setPlayPauseIcon(true)
        }
        onSourceChanged: {console.log(source)}
        onPlaybackStateChanged:
        {
            // starts rotation of Music C.D
            if(batplayer.playbackState === Audio.PlayingState)
                playingpage.startAnimation = true
            // stops rotation of Music C.D
            if(batplayer.playbackState === Audio.PausedState)
                playingpage.startAnimation = false
        }
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

    onSplashScreenFinished:
    {
        LOGIC.check()
    }
    onClosing:
    {
        LOGIC.saveData()
    }
}
