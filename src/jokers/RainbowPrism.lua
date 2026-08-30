SMODS.Joker {
    key = "Rainbow_Prism",
    atlas = 'placeholders',
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    pos = { x = 2, y = 0 },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            if G.GAME.blind.name == "The Club" or G.GAME.blind.name == "The Window" or G.GAME.blind.name == "The Goad" or G.GAME.blind.name == "The Head"then
                G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            if G.GAME.blind.name == "The Club" or G.GAME.blind.name == "The Window" or G.GAME.blind.name == "The Goad" or G.GAME.blind.name == "The Head"then
                G.GAME.blind:disable()
                play_sound('timpani')
                SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
            end
        end
    end
}