pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- all aboard
-- thoughtless labs

function _init()
	cls()
	mode="start"
	part={}
	train()
end

function _update60()
	updatepart()
	if mode=="start" then
		updatestart()
	elseif mode=="game" then
		updategame()
	elseif mode=="gameover" then
		updategameover()
	end
end

function _draw()
	cls()
	if mode=="start" then
		drawstart()
	elseif mode=="game" then
		drawgame()
	elseif mode=="gameover" then
		drawgameover()
	end
end
-->8
-- update functions

-- update start menu
function updatestart()
	if btnp(4) then
		mode="game"
	end
end

-- update games
function updategame()
	movetrain()
	if btnp(4) then
		mode="gameover"
	end
end

-- update gameover screen
function updategameover()
	if btnp(4) then
		mode="start"
	end
end

-->8
-- draw functions

-- draw start menu
function drawstart()
	print("let's play a game")
end

-- main game draw
function drawgame()
	print("game",0,0,10)
	drawpart()
	drawtrain()
end

-- draw gameover screen
function drawgameover()
	print("gameover")
end


-->8
-- characters

-- add train to game
function train()
	t={}
	t.x=30
	t.y=60
	t.oy=60
	t.dx=0
	t.dy=0
	t.m=false
	t.f=false
	t.d=8
end

-- draw train
function drawtrain()
	spr(0,t.x+t.d,t.y,1,1,t.f)
	spr(16,t.x,t.y,1,1,t.f)
end

-- move train
function movetrain()
	if btn(0) then
		t.dx=-2
		t.f=true
		t.d=-8
		t.m=true
	end
	if btn(1) then
		t.dx=2
		t.f=false
		t.d=8
		t.m=true
	end
	if btnp(2) then
		jump()
	end
	t.m=false
	if t.m==false then
		t.dx=t.dx/1.2
	end
	t.y+=t.dy
	t.x+=t.dx
	t.x=mid(5,t.x,115)
	smoke(t.x,t.y,t.d)
end

function jump()
	t.dy=-2
	if t.y > t.oy then
		t.dy+=2
	end
	
end
-->8
-- freshly squeezed

-- particle generator
function particles(_x,_y,_dx,_dy,_maxa,_col,_s)
	local p={}
	p.x=_x
	p.y=_y
	p.dx=_dx
	p.dy=_dy
	p.col=0
	p.colarr=_col
	p.a=0
	p.maxa=_maxa
	p.s=_s
	p.os=_s
	add(part,p)
end

-- smoke
function smoke(_x,_y,_d)
	for i=0,5 do
		local _ang = rnd()
		local _dx = sin(_ang)*1.5
		local _dy = cos(_ang)*1.5
		local _smoke = 20+rnd(15)
		if t.d<0 then
			particles(_x,_y,_dx,_dy,_smoke,{5,6,7},rnd(2))
		else
			particles(_x+_d,_y,_dx,_dy,_smoke,{5,6,7},rnd(2))		
		end
	end
end

function updatepart()
	local _p
	for i=#part,1,-1 do
		_p=part[i]
		_p.a+=1
		if _p.a > _p.maxa then
			del(part,part[i])
		else
			local _ci=_p.a/_p.maxa
			_ci=1+flr(_ci*#_p.colarr)
			_p.col=_p.colarr[_ci]
		end
	
	-- gravity
--	if 
	_p.dy-=0.8
	
	--	shrink
	local _ci=1-_p.a/_p.maxa
	_p.s=_ci*_p.os
	
	--	friction
	_p.dx=_p.dx/5
	_p.dy=_p.dy/5

	-- moving particle
	_p.x+=_p.dx
	_p.y+=_p.dy
	end
end

-- draw particles
function drawpart()
	for i=1,#part do
		_p=part[i]
		-- draw smoke
		circfill(_p.x,_p.y,_p.s,_p.col)
	end
end
__gfx__
10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09999011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09009011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09009001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11911119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00900009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001020300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011121300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021222300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000705009050000000b050080500c050080501c050080500d0501f0500d050080501d0500d050190500d0500c05012050190501d0502105023050200501f05002050030500405004050000000605005050
