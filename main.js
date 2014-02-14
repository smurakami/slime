// Generated by CoffeeScript 1.6.3
(function() {
  var M, Slime, ctx, global;

  global = this;

  M = Math;

  ctx = null;

  Slime = (function() {
    function Slime(x, y, r) {
      this.x = x;
      this.y = y;
      this.r = r != null ? r : 50;
      this.color = 'rgba(0, 210, 255, 0.7)';
    }

    Slime.prototype.draw = function() {
      ctx.beginPath();
      ctx.setTransform(1, 0, 0, 1, this.x, this.y);
      ctx.fillStyle = this.color;
      ctx.arc(0, 0, this.r, 0, M.PI * 2, true);
      return ctx.fill();
    };

    Slime.prototype.update = function() {};

    return Slime;

  })();

  window.onload = function() {
    var canvas, fps, height, mainLoop, slime, width;
    canvas = document.getElementById('canvas');
    width = canvas.width;
    height = canvas.height;
    ctx = canvas.getContext('2d');
    fps = 30;
    global.slime = slime = new Slime(width / 2, height / 2);
    mainLoop = function() {
      ctx.clearRect(-width, -height, width * 2, height * 2);
      slime.draw();
      slime.update();
      return setTimeout(mainLoop, 1 / fps);
    };
    return mainLoop();
  };

}).call(this);
