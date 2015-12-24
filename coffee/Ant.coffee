class @Ant
    #Row, Col
    @MOVEMENTS: [
        [0, -1],    #LEFT
        [-1, 0],    #UP
        [0, 1],     #RIGHT
        [1, 0]      #DOWN
    ]
    @COLOR_CODES:
        white: '#FFFFFF'
        black: '#16001E'
        red: '#C40B37'
        green: '#286639'
        blue: '#275DAD'
        cyan: '#34D1BF'
        yellow: '#FABC3C'
        magenta: '#C34397'

    constructor: (@row, @col, @orientation, @grid, code) ->
        @rules = new AntRules()
        @rules.decode(code)

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
        rule_list = @rules[current_color]
        if rule_list.length is 0
            rule_list = @rules.default
        for rule in rule_list
            if rule is "left"
                @left()
            else if rule is "right"
                @right()
            else if rule is "forward"
                @move()
            else if rule of Ant.COLOR_CODES
                @set_color(rule)
