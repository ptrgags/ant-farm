WIDTH = 640
HEIGHT = 480
SPEED = 4
CELL_SIZE = 4
ROWS = Math.floor(HEIGHT / CELL_SIZE)
COLS = Math.floor(WIDTH / CELL_SIZE)

type = 'langton'

@LANGTON =
    BLACK: ["LEFT", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "BLACK", "MOVE"]

@FAST =
    BLACK: ["LEFT", "WHITE", "MOVE", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "BLACK", "MOVE", "BLACK", "MOVE"]
    RED: ["LEFT", "BLACK", "MOVE", "RED", "MOVE"]

@FIRE =
    BLACK: ["LEFT", "RED", "MOVE"]
    WHITE: ["RIGHT", "RED", "MOVE"]
    RED: ["LEFT", "RED", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE"]

@RAINBOW =
    BLACK: ["LEFT", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "RED", "MOVE"]
    RED: ["LEFT", "GREEN", "MOVE"]
    GREEN: ["RIGHT", "BLUE", "MOVE"]
    BLUE: ["LEFT", "YELLOW", "MOVE"]
    YELLOW: ["RIGHT", "MAGENTA", "MOVE"]
    MAGENTA: ["LEFT", "CYAN", "MOVE"]
    CYAN: ["RIGHT", "BLACK", "MOVE"]

@BLUE_GREEN =
    BLACK: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
    WHITE: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
    YELLOW: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
    GREEN: ["LEFT", "BLUE", "MOVE", "RIGHT", "BLUE", "MOVE"]
    BLUE: ["LEFT", "GREEN", "MOVE", "RIGHT", "GREEN", "MOVE"]
    RED: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
    CYAN: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]
    MAGENTA: ["LEFT", "BLUE", "MOVE", "RIGHT", "GREEN", "MOVE"]

@RULES =
    langton: LANGTON
    blue_green: BLUE_GREEN
    rainbow: RAINBOW
    fire: FIRE
    fast: FAST

@DEFAULT_RULES = ['MOVE']

grid = (('WHITE' for col in [1..COLS]) for row in [1..ROWS])
ants = [new Ant 50, 50, 0, grid, LANGTON, ["MOVE"]]


@onload = ->
    $('#action-white').html LANGTON.WHITE.join ", "
    $('#action-black').html LANGTON.BLACK.join ", "
    $('input[name=anttype]').change (e) ->
        type = e.target.value
    $('#clear').click ->
        ants = []
        grid = (('WHITE' for col in [1..COLS]) for row in [1..ROWS])

@setup = ->
    createCanvas WIDTH, HEIGHT
    noStroke()

@draw = ->
    background '#AAAAAA'
    for x in [1..SPEED]
        for ant in ants
            ant.step()

    for row, i in grid
        for cell, j in row
            if cell != 'WHITE'
                fill Ant.COLOR_CODES[cell]
                rect j * CELL_SIZE, i * CELL_SIZE, CELL_SIZE, CELL_SIZE

    fill '#FFAA00'
    for ant in ants
        rect ant.col * CELL_SIZE, ant.row * CELL_SIZE, CELL_SIZE, CELL_SIZE

@get_modifier = ->
    if keyIsPressed and key is CODED
        if keyCode is SHIFT
            return SHIFT
        else if keyCode is ALT
            return ALT
        else if keyCode is CONTROL
            return CONTROL
        else
            return null
    else
        return null

@mouseClicked = ->
    if mouseX > WIDTH
        return
    if mouseY > HEIGHT
        return
    row = Math.floor(mouseY / CELL_SIZE)
    col = Math.floor(mouseX / CELL_SIZE)
    dir = 0
    ants.push(new Ant(row, col, dir, grid, RULES[type], DEFAULT_RULES))
    false
