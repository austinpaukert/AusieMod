SMODS.Joker {
    key = "red_flag",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pos = { x = 0, y = 0 },
    config = { extra = { xmult  = 0.05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult , 1.0 + (card.ability.extra.xmult  * math.max(0, (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0))) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 1.0 + (card.ability.extra.xmult  * math.max(0, (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)))
            }
        end
    end,
}