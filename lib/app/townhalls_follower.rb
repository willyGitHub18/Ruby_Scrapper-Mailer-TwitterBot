require 'rubygems'
require 'twitter'
require 'dotenv/load'
require 'json'
require 'pp'

class BotTwitter
  attr_accessor :client

  def initialize
    # lignes qui enregistrent les clés d'APIs
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def search_handle_and_follow
    file = File.read('../../db/townhalls.JSON') # Récupère le fichier JSON pour accéder à son contenu
    v = JSON.parse(file)          # Lis le fichier
    v.each do |e|                 # récupère le nom de la commune dans le fichier JSON
      b = "Mairie " + "#{e[0]}"   # fait une recherche au format Mairie Commune (et pas juste Commune)
      @townhalls_list = []        # créé un array
      @townhalls_list << b        # range les noms "Mairie Commune" dans l'array
    end

    @townhalls_list.each do |townhall|                  # pour chaque mairie dans le tableau
      @search_id_result = @client.user_search(townhall) # renvoie un array des résultats d'id user twitter

        @search_id_result.each do |id|                  # pour chaque id user twitter
          @client.follow(id)                            # follow le user en question
        end 
    end 
  end


end

bot1 = BotTwitter.new
bot1.search_handle_and_follow

