class @Ant
    #Row, Col
    @MOVEMENTS: [
        [0, -1],    #LEFT
        [-1, 0],    #UP
        [0, 1],     #RIGHT
        [1, 0]      #DOWN
    ]
    @COLOR_CODES:
        WHITE: '#FFFFFF'
        BLACK: '#000000'
        RED: '#FF0000'
        GREEN: '#00FF00'
        BLUE: '#0000FF'
        CYAN: '#00FFFF'
        YELLOW: '#FFFF00'
        MAGENTA: '#FF00FF'

    constructor: (@row, @col, @orientation, @grid, @rules, @default_rules=[]) ->

    turn: (amount) ->
        @orientation += amount
        @orientation %= Ant.MOVEMENTS.length
        while @orientation < 0
            @orientation += Ant.MOVEMENTS.length

    left: ->
        @turn -1

    right: ->
        @turn 1

    get_color: ->
        @grid[@row][@col]

    set_color: (color) ->
        @grid[@row][@col] = color

    move: ->
        [row_delta, col_delta] = Ant.MOVEMENTS[@orientation]
        @row += row_delta
        @row %= @grid.length
        while @row < 0
            @row += @grid.length

        @col += col_delta
        @col %= @grid[0].length
        while @col < 0
            @col += @grid[0].length

    step: ->
        current_color = @get_color()
        for rule in @rules[current_color] ? @default_rules
            if rule is "LEFT"
                @left()
            else if rule is "RIGHT"
                @right()
            else if rule is "MOVE"
                @move()
            else if rule of Ant.COLOR_CODES
                @set_color(rule)
