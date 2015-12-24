WIDTH = 640
HEIGHT = 480
SPEED = 8
CELL_SIZE = 4
ROWS = Math.floor(HEIGHT / CELL_SIZE)
COLS = Math.floor(WIDTH / CELL_SIZE)

type = 'langton_ant'

@ANT_CODES =
    langton_ant: "30201100312110003800"
    blue_green_ant: "30201400211300312014002113003220140021130033201400211400342013002113003520140021130036201400211300372014002113003800"
    rainbow_ant: "30201100312112003220130033211400342016003521100036211700372015003800"
    fire_ant: "30201200312112003220120021000000003800"
    fast_ant: "3020110011003121100010003220100012003800"
    box_ant: "300031001500150015210015001500152100150015001521001500150015213500102100102100102100103800"
    bee_ant: "3021160031201000362011003800"
    green_ant: "31201300332111003713003800"
    anti_green_ant: "31201700331700372111003800"
    line_ant: "30210000311333003521210036200000372020003800"
    custom_ant: "3800"

grid = (('white' for col in [1..COLS]) for row in [1..ROWS])
ants = [new Ant 50, 50, 0, grid, ANT_CODES.langton_ant]

custom_color = "white"
custom_rules = new AntRules()

@update_rules = (type) ->
    $('td[id|=action]').html ""
    for key of AntRules.COLOR_CODES
        $('#action-' + key).html(custom_rules[key]?.join ",")

@update_selected_code = ->
    ANT_CODES.custom_ant = custom_rules.encode()
    $('#selected-ant').html ANT_CODES[type]

@onload = ->
    update_rules()
    update_selected_code()

    $('input[name=anttype]').change (e) ->
        type = e.target.value
        update_rules()
        update_selected_code()
    $('input[name=input-color]').change (e) ->
        custom_color = e.target.value
    $('#clear').click ->
        ants = []
        grid = (('white' for col in [1..COLS]) for row in [1..ROWS])

    append_rule = (rule) ->
        return ->
            custom_rules[custom_color].push rule
            update_rules()
            update_selected_code()

    for color of AntRules.COLOR_CODES
        $("#command-#{color}").click append_rule(color)

    $('#command-forward').click append_rule("forward")
    $('#command-left').click append_rule("left")
    $('#command-right').click append_rule("right")
    $('#command-clear').click ->
        custom_rules[custom_color].length = 0
        update_rules()
        update_selected_code()
    $('#command-clear-last').click ->
        custom_rules[custom_color].pop()
        update_rules()
        update_selected_code()
    $('#command-load').click ->
        custom_rules.decode(prompt("Enter an ant code:", "3800"))
        update_rules()
        update_selected_code()
@setup = ->
    createCanvas WIDTH, HEIGHT
    noStroke()

@draw = ->
    background '#B58558'
    for x in [1..SPEED]
        for ant in ants
            ant.step()

    for row, i in grid
        for cell, j in row
            if cell != 'white'
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
    if type is "custom_ant"
        ANT_CODES[type] = custom_rules.encode()

    ants.push(new Ant(row, col, dir, grid, ANT_CODES[type]))
    false
