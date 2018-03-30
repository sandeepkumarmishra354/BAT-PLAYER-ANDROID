function playThis(index, row)
{
    setPlayingIcon()
    songRow = row
    mainplaylist.currentIndex = index
    batplayer.play()
    console.log("pt= "+index)
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
    console.log("prev song...")
}

function playNextTrack()
{
    mainplaylist.next()
    console.log("Next song...")
}

function playOrPause()
{
    if(batplayer.playbackState === Audio.PlayingState)
    {
        batplayer.pause()
    }
    else
    {
        batplayer.play()
    }
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
    remTime = time
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
    totalTime = time
    totalDuration = totalDurSec
}

function updateSongSlider(pos)
{
    pos = pos/1000
    playingpage.sliderValue = pos/totalDuration
}

function setSongPosition(pos)
{
    var offset = totalDuration*1000*pos
    batplayer.seek(offset)
}

function songChanged(src)
{
    var srcstr = src.toString()
    var li = srcstr.lastIndexOf("/")
    var mp3 = srcstr.slice(++li);
    currentSongName = mp3
    playingpage.title = mp3
}

function setShuffle()
{
    if(mainplaylist.playbackMode !== sequentialMode)
    {
        mainplaylist.playbackMode = sequentialMode
        shuffleIcon = shuffleOffIcon
    }
    else
    {
        mainplaylist.playbackMode = randomMode
        shuffleIcon = shuffleOnIcon
    }
}

function setRepeat()
{
    if(mainplaylist.playbackMode !== repeatAllMode)
        mainplaylist.playbackMode = repeatAllMode
    else
        mainplaylist.playbackMode = repeatCurrentMode
}

function setPlayPauseIcon(flag)
{
    if(flag) // playing
        pIcon = pauseIcon
    else // paused
        pIcon = playIcon
}

function check()
{
    var status = database.getValue("firstTime")
    if(status === undefined)
    {
        database.setValue("firstTime", false)
    }
    else
    {
        isFirstTime = false
        restorePrevious()
    }
}

function restorePrevious()
{
    if( ! isFirstTime )
    {
        mainplaylist.currentIndex = database.getValue("index")
        batplayer.seek(database.getValue("position"))
    }
}

function saveData()
{
    database.setValue("index", currentSongIndex)
    database.setValue("position", batplayer.position)
}
