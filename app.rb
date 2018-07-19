# projet mairies - on lie tous les fichiers au fichier app
require 'bundler'
require 'pp'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__) # On ajoute directement au PATH les fichiers présents au dossier app
require 'townhalls_scrapper'
#require 'townhalls_mailer'
#require 'townhalls_adder_to_db'
require 'townhalls_follower'

Scrapper.new.store_json
#Mailer.new.app_mail
BotTwitter.new.search_handle_and_follow
