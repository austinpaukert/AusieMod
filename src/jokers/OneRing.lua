SMODS.Joker {
    key = "one_ring",
    blueprint_compat = false,
    rarity = 3,
    cost = 6,
    pos = { x = 0, y = 0 },
    config = { extra = { dollars = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        return -(card.ability.extra.dollars)
    end
}