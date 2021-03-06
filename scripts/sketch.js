// Generated by CoffeeScript 1.10.0
(function() {
  var CELL_SIZE, COLS, HEIGHT, ROWS, SPEED, WIDTH, ants, col, grid, row, type;

  WIDTH = 640;

  HEIGHT = 480;

  SPEED = 8;

  CELL_SIZE = 4;

  ROWS = Math.floor(HEIGHT / CELL_SIZE);

  COLS = Math.floor(WIDTH / CELL_SIZE);

  type = 'langton';

  this.LANGTON = {
    BLACK: ["LEFT", "WHITE", "MOVE"],
    WHITE: ["RIGHT", "BLACK", "MOVE"]
  };

  this.FAST = {
    BLACK: ["LEFT", "WHITE", "MOVE", "WHITE", "MOVE"],
    WHITE: ["RIGHT", "BLACK", "MOVE", "BLACK", "MOVE"],
    RED: ["LEFT", "BLACK", "MOVE", "RED", "MOVE"]
  };

  this.FIRE = {
    BLACK: ["LEFT", "RED", "MOVE"],
    WHITE: ["RIGHT", "RED", "MOVE"],
    RED: ["LEFT", "RED", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE"]
  };

  this.RAINBOW = {
    BLACK: ["LEFT", "WHITE", "MOVE"],
    WHITE: ["RIGHT", "RED", "MOVE"],
    RED: ["LEFT", "GREEN", "MOVE"],
    GREEN: ["RIGHT", "BLUE", "MOVE"],
    BLUE: ["LEFT", "YELLOW", "MOVE"],
    YELLOW: ["RIGHT", "MAGENTA", "MOVE"],
    MAGENTA: ["LEFT", "CYAN", "MOVE"],
    CYAN: ["RIGHT", "BLACK", "MOVE"]
  };

  this.BLUE_GREEN = {
    BLACK: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    WHITE: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    YELLOW: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    GREEN: ["LEFT", "BLUE", "MOVE", "RIGHT", "BLUE", "MOVE"],
    BLUE: ["LEFT", "GREEN", "MOVE", "RIGHT", "GREEN", "MOVE"],
    RED: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    CYAN: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    MAGENTA: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
  };

  this.BOX = {
    WHITE: ["MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT", "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT", "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT", "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT"],
    CYAN: ["MOVE", "BLACK", "RIGHT", "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK"]
  };

  this.BEE = {
    WHITE: ["LEFT", "BLACK", "MOVE"],
    BLACK: ["RIGHT", "YELLOW", "MOVE"],
    YELLOW: ["LEFT", "WHITE", "MOVE"]
  };

  this.GREEN = {
    WHITE: ["LEFT", "GREEN", "MOVE"],
    GREEN: ["RIGHT", "WHITE", "MOVE"],
    MAGENTA: ["GREEN", "MOVE"]
  };

  this.ANTI_GREEN = {
    WHITE: ["LEFT", "MAGENTA", "MOVE"],
    MAGENTA: ["RIGHT", "WHITE", "MOVE"],
    GREEN: ["MAGENTA", "MOVE"]
  };

  this.LINE = {
    WHITE: ["GREEN"],
    GREEN: ["MOVE"],
    BLACK: ["RIGHT", "MOVE", "MOVE"],
    YELLOW: ["LEFT", "MOVE", "MOVE"],
    MAGENTA: ["LEFT", "LEFT", "MOVE"],
    CYAN: ["RIGHT", "RIGHT", "MOVE"]
  };

  this.RULES = {
    langton: LANGTON,
    blue_green: BLUE_GREEN,
    rainbow: RAINBOW,
    fire: FIRE,
    fast: FAST,
    box: BOX,
    bee: BEE,
    green: GREEN,
    anti_green: ANTI_GREEN,
    line: LINE
  };

  this.DEFAULT_RULES = ['MOVE'];

  grid = (function() {
    var k, ref, results;
    results = [];
    for (row = k = 1, ref = ROWS; 1 <= ref ? k <= ref : k >= ref; row = 1 <= ref ? ++k : --k) {
      results.push((function() {
        var l, ref1, results1;
        results1 = [];
        for (col = l = 1, ref1 = COLS; 1 <= ref1 ? l <= ref1 : l >= ref1; col = 1 <= ref1 ? ++l : --l) {
          results1.push('WHITE');
        }
        return results1;
      })());
    }
    return results;
  })();

  ants = [new Ant(50, 50, 0, grid, LANGTON, ["MOVE"])];

  this.onload = function() {
    $('#action-white').html(LANGTON.WHITE.join(", "));
    $('#action-black').html(LANGTON.BLACK.join(", "));
    $('input[name=anttype]').change(function(e) {
      return type = e.target.value;
    });
    return $('#clear').click(function() {
      ants = [];
      return grid = (function() {
        var k, ref, results;
        results = [];
        for (row = k = 1, ref = ROWS; 1 <= ref ? k <= ref : k >= ref; row = 1 <= ref ? ++k : --k) {
          results.push((function() {
            var l, ref1, results1;
            results1 = [];
            for (col = l = 1, ref1 = COLS; 1 <= ref1 ? l <= ref1 : l >= ref1; col = 1 <= ref1 ? ++l : --l) {
              results1.push('WHITE');
            }
            return results1;
          })());
        }
        return results;
      })();
    });
  };

  this.setup = function() {
    createCanvas(WIDTH, HEIGHT);
    return noStroke();
  };

  this.draw = function() {
    var ant, cell, i, j, k, l, len, len1, len2, len3, m, n, o, ref, results, x;
    background('#AAAAAA');
    for (x = k = 1, ref = SPEED; 1 <= ref ? k <= ref : k >= ref; x = 1 <= ref ? ++k : --k) {
      for (l = 0, len = ants.length; l < len; l++) {
        ant = ants[l];
        ant.step();
      }
    }
    for (i = m = 0, len1 = grid.length; m < len1; i = ++m) {
      row = grid[i];
      for (j = n = 0, len2 = row.length; n < len2; j = ++n) {
        cell = row[j];
        if (cell !== 'WHITE') {
          fill(Ant.COLOR_CODES[cell]);
          rect(j * CELL_SIZE, i * CELL_SIZE, CELL_SIZE, CELL_SIZE);
        }
      }
    }
    fill('#FFAA00');
    results = [];
    for (o = 0, len3 = ants.length; o < len3; o++) {
      ant = ants[o];
      results.push(rect(ant.col * CELL_SIZE, ant.row * CELL_SIZE, CELL_SIZE, CELL_SIZE));
    }
    return results;
  };

  this.get_modifier = function() {
    if (keyIsPressed && key === CODED) {
      if (keyCode === SHIFT) {
        return SHIFT;
      } else if (keyCode === ALT) {
        return ALT;
      } else if (keyCode === CONTROL) {
        return CONTROL;
      } else {
        return null;
      }
    } else {
      return null;
    }
  };

  this.mouseClicked = function() {
    var dir;
    if (mouseX > WIDTH) {
      return;
    }
    if (mouseY > HEIGHT) {
      return;
    }
    row = Math.floor(mouseY / CELL_SIZE);
    col = Math.floor(mouseX / CELL_SIZE);
    dir = 0;
    ants.push(new Ant(row, col, dir, grid, RULES[type], DEFAULT_RULES));
    return false;
  };

}).call(this);
