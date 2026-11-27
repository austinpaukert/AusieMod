SMODS.Joker {
    key = "one_ring",
    blueprint_compat = false,
    rarity = 3,
    cost = 6,
    pos = { x = 3, y = 1 },
    config = { extra = { dollars = 4, creates = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars,card.ability.extra.creates} }
    end,
    calc_dollar_bonus = function(self, card)
        return -(card.ability.extra.dollars)
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Rare',
                            key_append = 'vremade_riff_raff'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,
}