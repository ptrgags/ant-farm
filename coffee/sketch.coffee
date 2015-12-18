WIDTH = 640
HEIGHT = 480
SPEED = 4
CELL_SIZE = 8

@LANGTON =
    BLACK: ["LEFT", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "BLACK", "MOVE"]

#grid = (('WHITE' for col in [1..COLS]) for row in [1..ROWS])


@setup = ->
    #createCanvas WIDTH, HEIGHT
    createCanvas(windowWidth, windowHeight)
    rows = Math.floor(windowHeight / CELL_SIZE)
    cols = Math.floor(windowWidth / CELL_SIZE)
    window.grid = (('WHITE' for col in [1..cols]) for row in [1..rows])
    window.ants = [new Ant 50, 50, 0, window.grid, LANGTON, ["MOVE"]]
    noStroke()

@draw = ->
    background '#FFFFFF'
    for x in [1..SPEED]
        for ant in window.ants
            ant.step()

    for row, i in window.grid
        for cell, j in row
            if cell != 'WHITE'
                fill Ant.COLOR_CODES[cell]
                rect j * CELL_SIZE, i * CELL_SIZE, CELL_SIZE, CELL_SIZE

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
    row = Math.floor(mouseY / CELL_SIZE)
    col = Math.floor(mouseX / CELL_SIZE)
    dir = 0
    #modifier = get_modifier()
    if mouseButton is LEFT
        window.ants.push(new Ant(row, col, dir, window.grid, LANGTON))
    false
