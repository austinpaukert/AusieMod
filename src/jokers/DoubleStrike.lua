SMODS.Joker {
    key = "double_strike",
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    config = { extra = { dollars = 2} },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.vremade_double_strike or {}).suit or 'Spades'
        return { vars = { card.ability.extra.dollars, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.vremade_double_strike.suit) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}


-- For syncing puposes
local function reset_vremade_double_strike()
    G.GAME.current_round.vremade_double_strike = G.GAME.current_round.vremade_double_strike or { suit = 'Spades' }
    local ancient_suits = {}
    for _, suit_key in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if suit_key ~= G.GAME.current_round.vremade_double_strike.suit then ancient_suits[#ancient_suits + 1] = suit_key end
    end
    local double_strike = pseudorandom_element(ancient_suits, 'vremade_ancient' .. G.GAME.round_resets.ante)
    G.GAME.current_round.vremade_double_strike.suit = double_strike
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_vremade_double_strike()
end