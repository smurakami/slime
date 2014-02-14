global = this
M = Math
ctx = null

# vector class
# @*_ : destructive method
# @*  : not destructive method
class _Vector
  constructor: (@x, @y) ->
  add : (v) -> new _Vector(@x + v.x, @y + v.y)
  add_: (v) ->
    @x += v.x
    @y += v.y
    return
  sub : (v) -> new _Vector(@x - v.x, @y - v.y)
  sub_: (v) ->
    @x -= v.x
    @y -= v.y
    return
  rotate : (rad) ->
    x = M.cos(rad) * @x - M.sin(rad) * @y
    y = M.sin(rad) * @x + M.cos(rad) * @y
    return new _Vector(x, y)

  rotate_: (rad) ->
    x = M.cos(rad) * @x - M.sin(rad) * @y
    y = M.sin(rad) * @x + M.cos(rad) * @y
    @x = x
    @y = y
    return

# wrapper
Vector = (x, y) -> new _Vector(x, y)
global.V = Vector

# slime class
class Slime
  constructor: (@x, @y, @r=50) ->
    @color = 'rgba(0, 210, 255, 0.7)'
  draw: ->
    ctx.beginPath();
    ctx.setTransform(1, 0, 0, 1, @x, @y)
    ctx.fillStyle = @color
    v = Vector(0, @r)
    ctx.moveTo(v.x, v.y)
    for i in [0...3]
      v.rotate_(M.PI*2/3)
      ctx.lineTo(v.x, v.y)
    ctx.stroke()
    # ctx.fill()
  update: ->

window.onload = ->
  canvas = document.getElementById('canvas')
  width = canvas.width
  height = canvas.height
  ctx = canvas.getContext('2d')

  fps = 30

  global.slime = slime = new Slime(width/2, height/2)

  mainLoop = ->
    ctx.clearRect(-width, -height, width*2, height*2)
    slime.draw()
    slime.update()
    setTimeout(mainLoop, 1/fps)

  mainLoop()