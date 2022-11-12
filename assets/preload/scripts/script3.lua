

ratingFCActivate = false
scaleNum = 1

function createText(tag, text, width, x, y, size, align)
    makeLuaText(tag, text, width, x, y)
    setTextSize(tag, size)
    setTextAlignment(tag, align)
    addLuaText(tag)
end

function onCreatePost()
    msX = 800
    msY = 400
    --hiding stuffs
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)

    --customizing the timebar
    setProperty('timeBar.y', getProperty('timeBar.y') + 50 )
    setProperty('timeBarBG.y', getProperty('timeBarBG.y') + 50)
    setProperty('timeBar.scale.x', 0.44)
    setProperty('timeBarBG.scale.x', 0.45)

    --creating properties
    createText('scoreTxt', '', 1000, getProperty('healthBar.x') - 205, getProperty('healthBar.y') + 35, 18, 'center')
    createText('timeTxt', '', 500, 385, 100, 28, 'center')
    createText('ratings', '', 600, 330, 20, 18, 'center')
    createText('songTitle', songName, 1000, getProperty('healthBar.x') - 205, getProperty('healthBar.y') - 40, 24, 'center')
    createText('msTiming', 'bruh', 500, msX, msY, 24, 'center')

    --for da song start tween
    setProperty('timeTxt.alpha', 0)
    setProperty('ratings.alpha', 0)

    --msTiming alpha
    setProperty('msTiming.alpha', 0)

    --DOWNSCROLL IS COOL BUT MAKING ELSEIF STATEMENTS ARE NOT
    if downscroll then
        setProperty('timeTxt.y', 600)
        setProperty('ratings.y', 685)
        setProperty('timeBar.y', getProperty('timeBar.y') - 100 )
        setProperty('timeBarBG.y', getProperty('timeBarBG.y') - 100)
    end

    if (middlescroll) then
        setProperty('timeTxt.x', getProperty('healthBar.x') + 60)
        setProperty('timeTxt.y', getProperty('healthBar.y') - 32)
        setTextSize('timeTxt', 20)
        setTextAlignment('timeTxt', 'left')
        
        setProperty('songTitle.x', getProperty('healthBar.x') + 375)
        setTextAlignment('songTitle', right)

        setProperty('timeBar.visible', false); setProperty('timeBarBG.visible', false)
    end
end

function onSongStart()
    doTweenAlpha('timeFadeIn', 'timeTxt', 1, 0.25, circIn)
    doTweenAlpha('ratingFadeIn', 'ratings', 1, 0.25, circIn)
end

function onUpdatePost()
    --timer variables
    --getting song length in seconds
    local  timeElapsed = math.floor(getProperty('songTime')/1000)
    local  timeTotal = math.floor(getProperty('songLength')/1000)

    --timerTxt updates (string.format puts it into mm:ss format)
    setTextString('timeTxt', string.format("%.2d:%.2d", timeElapsed/60%60, timeElapsed%60) .. '/' .. string.format("%.2d:%.2d", timeTotal/60%60, timeTotal%60))

    --scoreTxt updates
    if ratingFCActivate == false then
        setTextString('scoreTxt', 'Score: ' .. score .. ' | ' .. 'Misses: ' .. getProperty('songMisses') .. ' | ' .. 'Accuracy: ' .. string.format("%.2f%%", rating * 100) .. ' ' .. '(?)')
    else
        setTextString('scoreTxt', 'Score: ' .. score .. ' | ' .. 'Misses: ' .. getProperty('songMisses') .. ' | ' .. 'Accuracy: ' .. string.format("%.2f%%", rating * 100) .. ' ' .. '(' .. getProperty('ratingFC') .. ')')
    end

    --rating updates
    setTextString('ratings', 'Sicks: ' .. getProperty('sicks') .. ' | ' .. 'Goods: ' .. getProperty('goods') .. ' | ' .. 'Bads: ' .. getProperty('bads') .. ' | ' .. 'Shits: ' .. getProperty('shits'))

    --icons
    setProperty('iconP1.x', getProperty('healthBar.x') + 525)
	setProperty('iconP2.x', getProperty('healthBar.x') - 75)

    if (botPlay and downscroll) then
        setProperty('scoreTxt.visible', false)
        setProperty('ratings.visible', false)
        setProperty('botplayTxt.y', getProperty('timeTxt.y') + 60)
    elseif (botPlay) then
        setProperty('scoreTxt.visible', false)
        setProperty('ratings.visible', false)
        setProperty('botplayTxt.y', getProperty('timeTxt.y') - 60)
    else
        setProperty('scoreTxt.visible', true)
        setProperty('ratings.visible', true)
    end

    --text bump
    while scaleNum >= 1 do
        setProperty('scoreTxt.scale.y', scaleNum)
        setProperty('scoreTxt.scale.x', scaleNum)
        setProperty('msTiming.scale.y', scaleNum)
        setProperty('msTiming.scale.x', scaleNum)
        scaleNum = scaleNum - 0.005
        wait(0.1)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    ratingFCActivate = true

    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local songPos = getPropertyFromClass('Conductor', 'songPosition')
    local rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')
    
    local diff = strumTime - songPos + rOffset;
    local msDiffStr = string.format("%.3fms", -diff)
    
    if isSustainNote == false then
        setProperty('msTiming.y', msY)

        setTextString('msTiming', msDiffStr)
        setProperty('msTiming.alpha', 1)
        doTweenAlpha('msAlpha', 'msTiming', 0, 0.5, "quintIn")

        doTweenY('msYTween', 'msTiming', msY + 50, 0.6, 'quintIn')

        if botPlay then
            setProperty('msTiming.alpha', 0)
        end
    end

    if isSustainNote == false then
        scaleNum = 1.15
    end

end

function noteMiss(id, direction, noteType, isSustainNote)
    ratingFCActivate = true

    setProperty('iconP1.color', getColorFromHex('690fad'))
    doTweenColor('iconP1', 'iconP1', 'FFFFFF', 0.5, 'linear')
end