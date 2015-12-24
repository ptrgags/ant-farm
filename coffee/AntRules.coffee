invert_obj = (obj) ->
    inv = {}
    for key, value of obj
        inv[value] = key
    inv

class @AntRules
    @OP_CODES:
        move: 0
        turn: 2
        set_color: 1
        on_color: 3
    @OP_CODES_INV: invert_obj(AntRules.OP_CODES)
    @COLOR_CODES:
        black: 0
        white: 1
        red: 2
        green: 3
        blue: 4
        cyan: 5
        yellow: 6
        magenta: 7
        default: 8
    @COLOR_CODES_INV: invert_obj(AntRules.COLOR_CODES)
    @TURN_CODES:
        left: 0
        right: 1
    @TURN_CODES_INV: invert_obj(AntRules.TURN_CODES)
    @MOVE_CODES:
        forward: 0
        backward: 1
    @MOVE_CODES_INV: invert_obj(AntRules.MOVE_CODES)

    constructor: ->
        for color of AntRules.COLOR_CODES
            @[color] = []
        @default = ["forward"]

    load_obj: (obj) ->
        for color of AntRules.COLOR_CODES
            @[color] = []
        for key, value of obj
            @[key] = value.slice()
        this

    encode: ->
        COLOR_CODES = AntRules.COLOR_CODES
        OP_CODES = AntRules.OP_CODES
        MOVE_CODES = AntRules.MOVE_CODES
        TURN_CODES = AntRules.TURN_CODES
        code = ""
        for color of COLOR_CODES
            rules = @[color]
            if rules.length > 0
                code += OP_CODES.on_color
                code += COLOR_CODES[color]
                for rule in rules
                    if rule of COLOR_CODES
                        code += OP_CODES.set_color
                        code += COLOR_CODES[rule]
                    else if rule of TURN_CODES
                        code += OP_CODES.turn
                        code += TURN_CODES[rule]
                    else if rule of MOVE_CODES
                        code += OP_CODES.move
                        code += MOVE_CODES[rule]
                    else
                        console.error "Invalid rule: #{rule}"
        code

    decode: (code) ->
        OP_CODES = AntRules.OP_CODES
        COLOR_CODES_INV = AntRules.COLOR_CODES_INV
        OP_CODES_INV = AntRules.OP_CODES_INV
        MOVE_CODES_INV = AntRules.MOVE_CODES_INV
        TURN_CODES_INV = AntRules.TURN_CODES_INV
        for color of AntRules.COLOR_CODES
            @[color] = []
        color_key = null
        for i in [0...code.length // 2]
            op_code = parseInt(code[2 * i])
            arg = parseInt(code[2 * i + 1])
            switch op_code
                when OP_CODES.on_color
                    color_key = COLOR_CODES_INV[arg]
                when OP_CODES.set_color
                    @[color_key].push COLOR_CODES_INV[arg]
                when OP_CODES.turn
                    @[color_key].push TURN_CODES_INV[arg]
                when OP_CODES.move
                    @[color_key].push MOVE_CODES_INV[arg]
        this
