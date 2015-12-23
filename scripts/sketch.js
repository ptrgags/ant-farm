// Generated by CoffeeScript 1.10.0
(function() {
  var CELL_SIZE, COLS, HEIGHT, ROWS, SPEED, WIDTH, ants, col, custom_color, grid, row, type;

  WIDTH = 640;

  HEIGHT = 480;

  SPEED = 8;

  CELL_SIZE = 4;

  ROWS = Math.floor(HEIGHT / CELL_SIZE);

  COLS = Math.floor(WIDTH / CELL_SIZE);

  type = 'langton';

  this.LANGTON = {
    BLACK: ["LEFT", "WHITE", "MOVE"],
    WHITE: ["RIGHT", "BLACK", "MOVE"],
    RED: [],
    GREEN: [],
    BLUE: [],
    CYAN: [],
    YELLOW: [],
    MAGENTA: []
  };

  this.FAST = {
    BLACK: ["LEFT", "WHITE", "MOVE", "WHITE", "MOVE"],
    WHITE: ["RIGHT", "BLACK", "MOVE", "BLACK", "MOVE"],
    RED: ["LEFT", "BLACK", "MOVE", "RED", "MOVE"],
    GREEN: [],
    BLUE: [],
    CYAN: [],
    YELLOW: [],
    MAGENTA: []
  };

  this.FIRE = {
    BLACK: ["LEFT", "RED", "MOVE"],
    WHITE: ["RIGHT", "RED", "MOVE"],
    RED: ["LEFT", "RED", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE"],
    GREEN: [],
    BLUE: [],
    CYAN: [],
    YELLOW: [],
    MAGENTA: []
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
    BLACK: ["MOVE"],
    RED: [],
    GREEN: [],
    BLUE: [],
    CYAN: ["MOVE", "BLACK", "RIGHT", "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK"],
    MAGENTA: [],
    YELLOW: []
  };

  this.BEE = {
    WHITE: ["LEFT", "BLACK", "MOVE"],
    BLACK: ["RIGHT", "YELLOW", "MOVE"],
    RED: [],
    GREEN: [],
    BLUE: [],
    YELLOW: ["LEFT", "WHITE", "MOVE"],
    CYAN: [],
    MAGENTA: []
  };

  this.GREEN = {
    WHITE: ["LEFT", "GREEN", "MOVE"],
    BLACK: [],
    RED: [],
    GREEN: [],
    GREEN: ["RIGHT", "WHITE", "MOVE"],
    BLUE: [],
    MAGENTA: ["GREEN", "MOVE"],
    YELLOW: []
  };

  this.ANTI_GREEN = {
    WHITE: ["LEFT", "MAGENTA", "MOVE"],
    BLACK: [],
    RED: [],
    GREEN: ["MAGENTA", "MOVE"],
    BLUE: [],
    MAGENTA: ["RIGHT", "WHITE", "MOVE"],
    YELLOW: [],
    CYAN: []
  };

  this.LINE = {
    WHITE: ["GREEN"],
    BLACK: ["RIGHT", "MOVE", "MOVE"],
    RED: [],
    GREEN: ["MOVE"],
    BLUE: [],
    YELLOW: ["LEFT", "MOVE", "MOVE"],
    MAGENTA: ["LEFT", "LEFT", "MOVE"],
    CYAN: ["RIGHT", "RIGHT", "MOVE"]
  };

  this.custom_rules = {};

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
    line: LINE,
    custom: custom_rules
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

  custom_color = "WHITE";

  this.update_rules = function(type) {
    var ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7;
    $('td[id|=action]').html("");
    $('#action-white').html((ref = RULES[type].WHITE) != null ? ref.join(",") : void 0);
    $('#action-black').html((ref1 = RULES[type].BLACK) != null ? ref1.join(",") : void 0);
    $('#action-red').html((ref2 = RULES[type].RED) != null ? ref2.join(",") : void 0);
    $('#action-green').html((ref3 = RULES[type].GREEN) != null ? ref3.join(",") : void 0);
    $('#action-blue').html((ref4 = RULES[type].BLUE) != null ? ref4.join(",") : void 0);
    $('#action-yellow').html((ref5 = RULES[type].YELLOW) != null ? ref5.join(",") : void 0);
    $('#action-cyan').html((ref6 = RULES[type].CYAN) != null ? ref6.join(",") : void 0);
    $('#action-magenta').html((ref7 = RULES[type].MAGENTA) != null ? ref7.join(",") : void 0);
    return $('#action-default').html(DEFAULT_RULES.join(","));
  };

  this.onload = function() {
    update_rules(type);
    $('input[name=anttype]').change(function(e) {
      type = e.target.value;
      return update_rules(type);
    });
    $('input[name=input-color]').change(function(e) {
      return custom_color = e.target.value;
    });
    $('#clear').click(function() {
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
    $('#command-white').click(function() {
      RULES[type][custom_color].push("WHITE");
      return update_rules(type);
    });
    $('#command-black').click(function() {
      RULES[type][custom_color].push("BLACK");
      return update_rules(type);
    });
    $('#command-red').click(function() {
      RULES[type][custom_color].push("RED");
      return update_rules(type);
    });
    $('#command-green').click(function() {
      RULES[type][custom_color].push("GREEN");
      return update_rules(type);
    });
    $('#command-blue').click(function() {
      RULES[type][custom_color].push("BLUE");
      return update_rules(type);
    });
    $('#command-yellow').click(function() {
      RULES[type][custom_color].push("YELLOW");
      return update_rules(type);
    });
    $('#command-cyan').click(function() {
      RULES[type][custom_color].push("CYAN");
      return update_rules(type);
    });
    $('#command-magenta').click(function() {
      RULES[type][custom_color].push("MAGENTA");
      return update_rules(type);
    });
    $('#command-forward').click(function() {
      RULES[type][custom_color].push("MOVE");
      return update_rules(type);
    });
    $('#command-left').click(function() {
      RULES[type][custom_color].push("LEFT");
      return update_rules(type);
    });
    $('#command-right').click(function() {
      RULES[type][custom_color].push("RIGHT");
      return update_rules(type);
    });
    $('#command-clear').click(function() {
      RULES[type][custom_color].length = 0;
      return update_rules(type);
    });
    return $('#command-clear-last').click(function() {
      RULES[type][custom_color].pop();
      return update_rules(type);
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
