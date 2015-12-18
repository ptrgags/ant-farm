import random

WIDTH = 640
HEIGHT = 480
SPEED = 4
CELL_SIZE = 4
ROWS = HEIGHT / CELL_SIZE
COLS = WIDTH / CELL_SIZE
GRID = [['WHITE' for col in xrange(COLS)] for row in xrange(ROWS)]

COLOR_CODES = {
    "WHITE": color(255, 255, 255),
    "BLACK": color(0, 0, 0),
    "RED": color(255, 0, 0),
    "GREEN": color(0, 255, 0),
    "BLUE": color(0, 0, 255),
    "MAGENTA": color(255, 0, 255),
    "CYAN": color(0, 255, 255),
    "YELLOW": color(255, 255, 0)
}


LANGTON = {
    "BLACK": ["LEFT", "WHITE", "MOVE"],
    "WHITE": ["RIGHT", "BLACK", "MOVE"]
}

FAST = {
    "BLACK": ["LEFT", "WHITE", "MOVE", "WHITE", "MOVE"],
    "WHITE": ["RIGHT", "BLACK", "MOVE", "BLACK", "MOVE"],
    "RED": ["LEFT", "BLACK", "MOVE", "RED", "MOVE"]
}

FIRE = {
    "BLACK": ["LEFT", "RED", "MOVE"],
    "WHITE": ["RIGHT", "RED", "MOVE"],
    "RED": ["LEFT", "RED", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE"]
}

RAINBOW = {
    "BLACK": ["LEFT", "WHITE", "MOVE"],
    "WHITE": ["RIGHT", "RED", "MOVE"],
    "RED": ["LEFT", "GREEN", "MOVE"],
    "GREEN": ["RIGHT", "BLUE", "MOVE"],
    "BLUE": ["LEFT", "YELLOW", "MOVE"],
    "YELLOW": ["RIGHT", "MAGENTA", "MOVE"],
    "MAGENTA": ["LEFT", "CYAN", "MOVE"],
    "CYAN": ["RIGHT", "BLACK", "MOVE"]
}

BLUE_GREEN = {
    "BLACK": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "WHITE": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "YELLOW": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "GREEN": ["LEFT", "BLUE", "MOVE", "RIGHT", "BLUE", "MOVE"],
    "BLUE": ["LEFT", "GREEN", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "RED": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "CYAN": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"],
    "MAGENTA": ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
}

class Ant(object):
    MOVEMENTS = [(0, -1), (-1, 0), (0, 1), (1, 0)] #LEFT UP RIGHT DOWN
    COLORS = ["BLACK", "WHITE", "RED", "GREEN", "BLUE", "CYAN", "MAGENTA", "YELLOW"]
    
    def __init__(self, row, col, dir_index, grid, rules, default_rules=["MOVE"]):
        self.row = row
        self.col = col
        self.orientation = dir_index
        self.grid = grid
        self.rules = rules
        self.default_rules = default_rules
    
    def turn(self, amount):
        self.orientation = (self.orientation + amount) % len(self.MOVEMENTS)
    
    def left(self):
        self.turn(-1)
    
    def right(self):
        self.turn(1)

    def get_color(self):
        return self.grid[self.row][self.col]
    
    def set_color(self, color):
        self.grid[self.row][self.col] = color
    
    def move(self):
        row_delta, col_delta = self.MOVEMENTS[self.orientation]
        self.row = (self.row + row_delta) % ROWS
        self.col = (self.col + col_delta) % COLS
    
    def step(self):
        current_color = self.get_color()
        for rule in self.rules.get(current_color, self.default_rules):
            if rule == "LEFT":
                self.left()
            elif rule == "RIGHT":
                self.right()
            elif rule == "MOVE":
                self.move()
            elif rule in self.COLORS:
                self.set_color(rule)
        
def setup():
    global ants
    size(WIDTH, HEIGHT)
    #ants = [Ant(50, 50, 0, GRID, LANGTON), Ant(0, 0, 2, GRID, LANGTON), Ant(30, 60, 1, GRID, LANGTON)]
    ants = []
    noStroke()

def draw():
    global GRID, ants
    background(128)
    for x in xrange(SPEED):
        for ant in ants:
            ant.step()
    for row_num, row in enumerate(GRID):
        for col_num, cell in enumerate(row):
            if cell != 'WHITE':
                fill(COLOR_CODES[cell])
                rect(col_num * CELL_SIZE, row_num * CELL_SIZE, CELL_SIZE, CELL_SIZE)
            
    fill(255, 165, 0)
    for ant in ants:        
        rect(ant.col * CELL_SIZE, ant.row * CELL_SIZE, CELL_SIZE, CELL_SIZE)

def get_modifier():
    if keyPressed and key == CODED:
        if keyCode == SHIFT:
            return SHIFT
        elif keyCode == ALT:
            return ALT
        elif keyCode == CONTROL:
            return CONTROL
        else:
            return None
    else:
        return None

def mouseClicked(event):
    global ants
    row = mouseY / CELL_SIZE
    col = mouseX / CELL_SIZE
    dir = random.choice(range(4))
    modifier = get_modifier()
    if mouseButton == LEFT:
        if modifier == SHIFT:
            ants.append(Ant(row, col, dir, GRID, RAINBOW))
        else:
            ants.append(Ant(row, col, dir, GRID, LANGTON))
    else:
        if modifier == SHIFT:
            ants.append(Ant(row, col, dir, GRID, FIRE))
        elif modifier == CONTROL:
            ants.append(Ant(row, col, dir, GRID, BLUE_GREEN))
        else:
            ants.append(Ant(row, col, dir, GRID, FAST))