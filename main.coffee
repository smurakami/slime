global = this
M = Math
ctx = null

class Slime
  constructor: (@x, @y, @r=50) ->
    @color = 'rgba(0, 210, 255, 0.7)'
  draw: ->
    ctx.beginPath();
    ctx.fillStyle = @color
    ctx.arc(@x, @y, @r, 0, M.PI*2, true)
    ctx.fill()

window.onload = ->
  canvas = document.getElementById('canvas')
  width = canvas.width
  height = canvas.height
  ctx = canvas.getContext('2d')

  fps = 30

  global.slime = slime = new Slime(width/2, height/2)

  mainLoop = ->
    ctx.clearRect(0, 0, width, height)
    slime.draw()
    setTimeout(mainLoop, 1/fps)

  mainLoop()