function onCreate()
	makeLuaSprite('flash', 'flash', 0, 0);
	setLuaSpriteScrollFactor('flash', 0, 0);
	defaultCamZoom = getProperty('defaultCamZoom') - 0.01;
	setProperty('flash.scale.x', 1 / defaultCamZoom);
	setProperty('flash.scale.y', 1 / defaultCamZoom);
	setProperty('flash.alpha', 0.0000);
	addLuaSprite('flash', true);
end

-- Event notes hooks
function onEvent(name, value1, value2)
	if name == "Flash New" then
		setProperty('flash.alpha', 1);
		doTweenAlpha('tweenCutOffAlpha', 'flash', 0, 0.5, 'linear');
	end
end