function onCreate()
	-- background shit
	makeLuaSprite('background', 'background', -600, -300);
	setScrollFactor('background', 0.9, 0.9);

	makeLuaSprite('light and shadow','light and shadow',-700,-200)
	addLuaSprite('light and shadow',true)
	setLuaSpriteScrollFactor('light and shadow', 1, 1);

      makeAnimatedLuaSprite('pear','pear',870,200)addAnimationByPrefix('pear','dance','hgfj',24,true)
      objectPlayAnimation('pear','dance',false)
      setScrollFactor('pear', 0.9, 0.9);

      makeAnimatedLuaSprite('fruit','fruit',-222,584)addAnimationByPrefix('fruit','dance','fruit',24,true)
      objectPlayAnimation('fruit','dance',false)
      setScrollFactor('fruit', 0.9, 0.9);

 
	
	addLuaSprite('background', false);
	addLuaSprite('background', false);
	addLuaSprite('background', false);
	addLuaSprite('background', false);
      addLuaSprite('pear', true);
      addLuaSprite('fruit', true);

	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
