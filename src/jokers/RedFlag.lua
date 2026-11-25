SMODS.Joker {
    key = "red_flag",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = .05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.mult * math.max(0, (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
            }
        end
    end,
}