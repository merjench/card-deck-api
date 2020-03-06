class Api::V1::DecksController < ApplicationController

    SUITS = ["hearts", "spades", "clubs", "diamonds"]
    VALUES = [*2..10, "jack", "queen", "king", "ace"]
    
    
    # gets all decks 
    def index 
        @decks = Deck.all

        render json: @decks 
    end 

    # new deck of cards
    def create
        deck_name = params[:name]
        @deck = Deck.create(:name => deck_name)

        SUITS.each do |suit| 
            VALUES.each do |value| 
                Card.create(:deck_id => @deck.id, :suit => suit, :value => value)
            end
        end

        render json: [@deck, @deck.cards]   
    end 


    # show a deck
    def show 
        @deck = Deck.find(params[:id])
        render json: [@deck, @deck.cards]
    end 

    # delete a deck
    def destroy
        deck_id = params[:id]
        deck = Deck.find(deck_id)
    end
end
