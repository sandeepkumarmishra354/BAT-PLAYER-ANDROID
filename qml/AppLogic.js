function playThis(index, row)
{
    setPlayingIcon()
    songRow = row
    mainplaylist.currentIndex = index
    batplayer.play()
}

function setPlayingIcon()
{
    if(songRow !== undefined)
    {
        songRow.iconSource = IconType.music
    }
}

function playPrevTrack()
{
    mainplaylist.previous()
}

function playNextTrack()
{
    mainplaylist.next()
}

function playOrPause()
{
    if(batplayer.playbackState === Audio.PlayingState)
        batplayer.pause()
    else
        batplayer.play()
}

function calculateRemTime(position)
{
    var totalDurSec = Math.floor(position / 1000)
    var min = Math.floor(totalDurSec/60)
    if(min < 10)
        min = "0"+min
    var sec = Math.floor(totalDurSec%60)
    if(sec < 10)
        sec = "0"+sec
    var time = min + ":" + sec
    playingpage.remTime = time
    if(playingpage.remTime === playingpage.totalTime)
    {
        console.log("Song finished")
        playingpage.totalTime = "0:0"
        playingpage.remTime = "0:0"
        LOGIC.playNextTrack()
        playingpage.title = currentSongName
        batplayer.play()
    }
}

function calculateTotalTime(duration)
{
    var totalDurSec = Math.floor(duration / 1000)
    var min = Math.floor(totalDurSec/60)
    if(min < 10)
        min = "0"+min
    var sec = Math.floor(totalDurSec%60)
    if(sec < 10)
        sec = "0"+sec
    var time = min + ":" + sec
    playingpage.totalTime = time
}

function songChanged(src)
{
    var srcstr = src.toString()
    var li = srcstr.lastIndexOf("/")
    var mp3 = srcstr.slice(++li);
    currentSongName = mp3
    playingpage.songtitle = mp3
}
