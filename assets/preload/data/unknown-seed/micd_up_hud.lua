--options

local songPositionBar = true --whether or not the song position/time bar will be active
local psychRating = false --whether or not the extra psych engine rating will appear, turn this off for accuracy i guess

function onCreatePost()
    setProperty('camHUD.alpha', 0)

    setProperty('scoreTxt.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)

    makeLuaText('newScoreTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('healthBarBG.y') + 26)
    setTextSize('newScoreTxt', 29)
    setTextBorder('newScoreTxt', 3, '000000')
    addLuaText('newScoreTxt')
    setObjectCamera('newScoreTxt', 'hud')

    makeLuaText('missTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('newScoreTxt.y') - 26)
    setTextSize('missTxt', 29)
    setTextBorder('missTxt', 3, '000000')
    addLuaText('missTxt')
    setObjectCamera('missTxt', 'hud')

    makeLuaText('accuracyTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('missTxt.y') - 26)
    setTextSize('accuracyTxt', 29)
    setTextBorder('accuracyTxt', 3, '000000')
    addLuaText('accuracyTxt')
    setObjectCamera('accuracyTxt', 'hud')
     
    makeLuaText('ratingTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('accuracyTxt.y') - 26)
    setTextSize('ratingTxt', 29)
    setTextBorder('ratingTxt', 3, '000000')
    addLuaText('ratingTxt')
    setObjectCamera('ratingTxt', 'hud')

    if psychRating then
        makeLuaText('ratingTxt', '', 0, getProperty('healthBarBG.x') - getProperty('healthBarBG.width') / 2, getProperty('accuracyTxt.y') - 26)
        setTextSize('ratingTxt', 29)
        setTextBorder('ratingTxt', 3, '000000')
        addLuaText('ratingTxt')
        setObjectCamera('ratingTxt', 'hud')
    end

    if songPositionBar then
        makeLuaSprite('songPosBG', 'healthBar', screenWidth / 2 - 300, 10)
        addLuaSprite('songPosBG', true)
        setObjectCamera('songPosBG', 'hud')

        makeLuaSprite('songPosBar1', null, screenWidth / 2 - 296, 14)
        makeGraphic('songPosBar1', getProperty('songPosBG.width') - 8, getProperty('songPosBG.height') - 8, '969696')
        addLuaSprite('songPosBar1', true)
        setObjectCamera('songPosBar1', 'hud')

        makeLuaSprite('songPosBar2', null, screenWidth / 2 - 296, 14)
        makeGraphic('songPosBar2', getProperty('songPosBG.width') - 8, getProperty('songPosBG.height') - 8, '00FF00')
        addLuaSprite('songPosBar2', true)
        setObjectCamera('songPosBar2', 'hud')
        setProperty('songPosBar2.alpha', 0)

        makeLuaText('songName', songName, 601, screenWidth / 2 - 300, getProperty('songPosBG.y'))
        setTextAlignment('songName', 'center')
        setTextSize('songName', 16)
        setTextBorder('songName', 1, '000000')
        addLuaText('songName')
        setObjectCamera('songName', 'hud')
    end

    --downscroll positions
    if downscroll then
        setProperty('newScoreTxt.y', getProperty('healthBarBG.y') - 18)
        setProperty('missTxt.y', getProperty('newScoreTxt.y') + 26)
        setProperty('accuracyTxt.y', getProperty('missTxt.y') + 26)
        setProperty('ratingTxt.y', getProperty('accuracyTxt.y') + 26)

        if songPositionBar then
            setProperty('songPosBG.y', screenHeight * 0.9 + 45)
            setProperty('songPosBar1.y', screenHeight * 0.9 + 49.5)
            setProperty('songPosBar2.y', screenHeight * 0.9 + 49.5)
            setProperty('songName.y', screenHeight * 0.9 + 45)
        end
    end
end

function onUpdate()
    if hits < 1 and misses < 1 then
        setTextString('newScoreTxt', 'Score: 0')
        setTextString('missTxt', 'Misses: 0')
        setTextString('accuracyTxt', 'Accuracy: 0%')
        setTextString('ratingTxt', 'Rating: ?')

        if psychRating then
            setTextString('ratingTxt', 'Rating: ?')
        end
    else
        setTextString('newScoreTxt', 'Score: ' .. score)
        setTextString('missTxt', 'Misses: ' .. misses)
        setTextString('accuracyTxt', 'Accuracy: ' .. round(rating * 100, 2) .. '%')
        setTextString('ratingTxt', 'Rating: ' .. ratingName .. ' - ' .. ratingFC)

        if psychRating then
            setTextString('ratingTxt', 'Rating: ' .. ratingName .. ' - ' .. ratingFC)
        end
    end
end

function onSongStart()
    if songPositionBar then
        daSongLength = getProperty('songLength') / 1000

        --i have zero clue if using lua tweens for this is the right idea but for now this is what i'm doing
        doTweenX('timeStart', 'songPosBar2.scale', 0.001, 0.001, 'linear')
    end
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

--icons
function onUpdatePost()
    setProperty('iconP1.y', getProperty('healthBar.y') + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26 - 50)
    setProperty('iconP2.y', getProperty('healthBar.y') + (150 * getProperty('iconP2.scale.x') - 150) / 2 - 26 - 50)
end

function onBeatHit()
    setProperty('iconP1.scale.x', 1.3)
    setProperty('iconP1.scale.y', 1.3)
    setProperty('iconP2.scale.x', 1.3)
    setProperty('iconP2.scale.y', 1.3)
end

function onTweenCompleted(tag)
    if songPositionBar then
        if tag == 'timeStart' then
            setProperty('songPosBar2.origin.x', 0)
            doTweenX('timeFill', 'songPosBar2.scale', 1, daSongLength, 'linear')
            setProperty('songPosBar2.alpha', 1)
        end
    end
end

function onStartCountdown()
    doTweenAlpha('hudFadeIn', 'camHUD', 1, 0.5, 'linear'); 
end