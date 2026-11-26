SMODS.Joker {
    key = "shrodingers_cat",
    atlas = 'placeholders',
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 2, Xmult = 4} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bves_shrodingers_cat')
        return { vars = {numerator, denominator, card.ability.extra.Xmult} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'bves_shrodingers_cat', 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}