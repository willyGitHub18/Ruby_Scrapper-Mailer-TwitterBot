# Initialise avec les "require"
require 'nokogiri'
require 'open-uri'
require 'json'
require 'pp'

# Création d'une classe Townhall (soit les "plans" d'une mairie)
class Townhall
  attr_accessor :town, :contact, :url, :dep

  def initialize(town, url) # Une mairie (instance) se compose d'un nom de ville et d'une adresse internet
    @town = town
    @url = url
  end
end

# Création d'une classe Scrapper (soit les plans de notre app de scrapping des mairies)
class Scrapper
  include Enumerable
  attr_accessor :towns, :city, :dep, :info

  def initialize
    @towns = []
    @city = []
    @dep = []
    @info = []
  end

  # Méthode pour récupérer les urls des villes en fonction du département
  def get_the_urls
    zipcode = ["rhone", "rhone-2", "herault", "herault-2", "bas-rhin", "bas-rhin-2"] # Création d'un array des département (et des éventuelles pages multiples) à aller chercher
    zipcode.each do |zip| # On boucle sur l'array afin de scrapper sur tous nos département
      page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/#{zip}.html"))
        links = page.css("a.lientxt")
        links.each do |url| # On boucle de nouveau pour chaque balise lien aller chercher l'url de la ville
          @towns.push(Townhall.new(url.text, url['href'].sub("./", "http://annuaire-des-mairies.com/"))) # on va alimenter l'array avec des objets (des mairies qui sont composées d'un nom de ville et d'une adresse internet)
        end
    end
    return @towns # On renvoie le résultat pour avoir une base sur laquelle travailler
  end

  # Méthode pour récupérer les emails en fonction de l'url
  def get_the_email
    get_the_urls.each do |townhall| # Pour chaque élément mairie
      page = Nokogiri::HTML(open(townhall.url)) rescue false # on utilise le paramètre url (une mairie se compose d'un nom et d'une url) et on rescue si une page est en ERREUR 404
        if page != false
          townhall.contact = page.css('html > body > div > main > section[2] > div > table > tbody > tr[4] > td[2]').text # On crée un autre paramètre pour notre objet : le contact
          townhall.dep = page.xpath('/html/body/div/main/section[4]/div/table/tbody/tr[1]/td[2]').text # On crée un quatrième paramètre pour notre object : le département
        else
          townhall.contact = "Page web introuvable"
          townhall.dep = "Page web introuvable"
        end
    end
    @towns.each do |building|
      @city.push(building.town)
      @dep.push(building.dep)
      @info.push(building.contact)
    end
    return hash = @city.zip(@dep, @info)# Pour chaque élément de notre array on lui demande de ressortir le nom, le département et le contact
  end

  # Méthode pour conversion vers JSON
  def store_json
    File.open("../../db/townhalls.JSON", "w") do |x| # ouvre fichier emails.json en mode write only
      x.write(JSON.pretty_generate(get_the_email)) # Crée notre fichier JSON
    end
    file = File.read('../../db/townhalls.JSON') # Récupère le fichier JSON pour accéder à son contenu
      v = JSON.parse(file) # Lis le fichier
  end
end

scrapper = Scrapper.new
scrapper.store_json
