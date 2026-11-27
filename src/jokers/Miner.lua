SMODS.Joker {
    key = "miner",
    atlas = 'placeholders',
    pos = { x = 4, y = 1},
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { s_mult = 10}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.s_mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone')then
            return {
                mult = card.ability.extra.s_mult
            }
        end
    end
}
