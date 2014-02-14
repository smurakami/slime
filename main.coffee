global = this
M = Math
ctx = null

# bezier curve with vector
CanvasRenderingContext2D.prototype.vBezierCurveTo = (v1, v2, v3) ->
  @bezierCurveTo(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y)

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
  mul : (k) -> new _Vector(@x * k, @y * k)
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
    v = Vector(0, @r) # begin point
    a = M.sqrt(3)/2
    dv = v.rotate(M.PI/2).mul(a) # begin tangent
    ctx.moveTo(v.x, v.y)
    for i in [0...3]
      w = v.rotate(M.PI*2/3) # next point
      dw = w.rotate(M.PI/2).mul(a) # next tangent
      ctx.vBezierCurveTo(v.add(dv), w.sub(dw), w)
      v = w # next point
      dv = dw # next tangent
    ctx.fill()
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