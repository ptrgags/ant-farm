WIDTH = 640
HEIGHT = 480
SPEED = 8
CELL_SIZE = 4
ROWS = Math.floor(HEIGHT / CELL_SIZE)
COLS = Math.floor(WIDTH / CELL_SIZE)

type = 'langton'

@LANGTON =
    BLACK: ["LEFT", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "BLACK", "MOVE"]
    RED: []
    GREEN: []
    BLUE: []
    CYAN: []
    YELLOW: []
    MAGENTA: []

@FAST =
    BLACK: ["LEFT", "WHITE", "MOVE", "WHITE", "MOVE"]
    WHITE: ["RIGHT", "BLACK", "MOVE", "BLACK", "MOVE"]
    RED: ["LEFT", "BLACK", "MOVE", "RED", "MOVE"]
    GREEN: []
    BLUE: []
    CYAN: []
    YELLOW: []
    MAGENTA: []

@FIRE =
    BLACK: ["LEFT", "RED", "MOVE"]
    WHITE: ["RIGHT", "RED", "MOVE"]
    RED: ["LEFT", "RED", "MOVE", "RIGHT", "MOVE", "MOVE", "MOVE", "MOVE"]
    GREEN: []
    BLUE: []
    CYAN: []
    YELLOW: []
    MAGENTA: []

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

@BOX =
    WHITE: [
        "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT",
        "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT",
        "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT",
        "MOVE", "CYAN", "MOVE", "CYAN", "MOVE", "CYAN", "RIGHT"
    ]
    BLACK: ["MOVE"]
    RED: []
    GREEN: []
    BLUE: []
    CYAN: [
        "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK", "RIGHT",
        "MOVE", "BLACK", "RIGHT", "MOVE", "BLACK"
    ]
    MAGENTA: []
    YELLOW: []

@BEE =
    WHITE: ["LEFT", "BLACK", "MOVE"]
    BLACK: ["RIGHT", "YELLOW", "MOVE"]
    RED: []
    GREEN: []
    BLUE: []
    YELLOW: ["LEFT", "WHITE", "MOVE"]
    CYAN: []
    MAGENTA: []

@GREEN =
    WHITE: ["LEFT", "GREEN", "MOVE"]
    BLACK: []
    RED: []
    GREEN: []
    GREEN: ["RIGHT", "WHITE", "MOVE"]
    BLUE: []
    MAGENTA: ["GREEN", "MOVE"]
    YELLOW: []

@ANTI_GREEN =
    WHITE: ["LEFT", "MAGENTA", "MOVE"]
    BLACK: []
    RED: []
    GREEN: ["MAGENTA", "MOVE"]
    BLUE: []
    MAGENTA: ["RIGHT", "WHITE", "MOVE"]
    YELLOW: []
    CYAN: []

@LINE =
    WHITE: ["GREEN"]
    BLACK: ["RIGHT", "MOVE", "MOVE"]
    RED: []
    GREEN: ["MOVE"]
    BLUE: []
    YELLOW: ["LEFT", "MOVE", "MOVE"]
    MAGENTA: ["LEFT", "LEFT", "MOVE"]
    CYAN: ["RIGHT", "RIGHT", "MOVE"]

@custom_rules = {}

@RULES =
    langton: LANGTON
    blue_green: BLUE_GREEN
    rainbow: RAINBOW
    fire: FIRE
    fast: FAST
    box: BOX
    bee: BEE
    green: GREEN
    anti_green: ANTI_GREEN
    line: LINE
    custom: custom_rules

@DEFAULT_RULES = ['MOVE']

grid = (('WHITE' for col in [1..COLS]) for row in [1..ROWS])
ants = [new Ant 50, 50, 0, grid, LANGTON, ["MOVE"]]

custom_color = "WHITE"

@update_rules = (type) ->
    $('td[id|=action]').html ""
    $('#action-white').html(RULES[type].WHITE?.join ",")
    $('#action-black').html(RULES[type].BLACK?.join ",")
    $('#action-red').html(RULES[type].RED?.join ",")
    $('#action-green').html(RULES[type].GREEN?.join ",")
    $('#action-blue').html(RULES[type].BLUE?.join ",")
    $('#action-yellow').html(RULES[type].YELLOW?.join ",")
    $('#action-cyan').html(RULES[type].CYAN?.join ",")
    $('#action-magenta').html(RULES[type].MAGENTA?.join ",")
    $('#action-default').html(DEFAULT_RULES.join ",")

@onload = ->
    update_rules type
    $('input[name=anttype]').change (e) ->
        type = e.target.value
        update_rules type
    $('input[name=input-color]').change (e) ->
        custom_color = e.target.value
    $('#clear').click ->
        ants = []
        grid = (('WHITE' for col in [1..COLS]) for row in [1..ROWS])
    $('#command-white').click ->
        RULES[type][custom_color].push "WHITE"
        update_rules type
    $('#command-black').click ->
        RULES[type][custom_color].push "BLACK"
        update_rules type
    $('#command-red').click ->
        RULES[type][custom_color].push "RED"
        update_rules type
    $('#command-green').click ->
        RULES[type][custom_color].push "GREEN"
        update_rules type
    $('#command-blue').click ->
        RULES[type][custom_color].push "BLUE"
        update_rules type
    $('#command-yellow').click ->
        RULES[type][custom_color].push "YELLOW"
        update_rules type
    $('#command-cyan').click ->
        RULES[type][custom_color].push "CYAN"
        update_rules type
    $('#command-magenta').click ->
        RULES[type][custom_color].push "MAGENTA"
        update_rules type
    $('#command-forward').click ->
        RULES[type][custom_color].push "MOVE"
        update_rules type
    $('#command-left').click ->
        RULES[type][custom_color].push "LEFT"
        update_rules type
    $('#command-right').click ->
        RULES[type][custom_color].push "RIGHT"
        update_rules type
    $('#command-clear').click ->
        RULES[type][custom_color].length = 0
        update_rules type
    $('#command-clear-last').click ->
        RULES[type][custom_color].pop()
        update_rules type

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
