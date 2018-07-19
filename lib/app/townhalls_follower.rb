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
      config.consumer_key        = ENV["TWITTER_API_KEY"] # Renseigner votre consumer_key
      config.consumer_secret     = ENV["TWITTER_API_SECRET"] # Renseigner votre consumer_secret
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"] # Renseigner votre access_token
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"] # Renseigner votre access_token_secret
    end
  end

  # Méthode pour rechercher les handles et follow
  def search_handle_and_follow
    file = File.read('db/townhalls.JSON') # Récupère le fichier JSON pour accéder à son contenu
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
