require 'gmail'
require 'dotenv'
require 'rubygems'
require 'json'
Dotenv.load

class Mailer

  def send_mail(townhalls, city) #méthode pour envoyer les mails à chaque ville et inclure dans le corps du message le nom de cette dernière
    gmail = Gmail.connect(ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"]) # Saisir vos identifiants de connexion
    email = gmail.compose do #envoie de mails

      to "townhalls[2]"
      subject "The Hacking Project !"
      body "Bonjour

      Nous sommes élèves à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique.

      La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code.

      Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'elles nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

      Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{townhalls} veut changer le monde avec nous ?

      Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
    end
    gmail.deliver(email)
  end

  def app_mail #méthode pour récuperer les mails et le nom des villes du fichier JSON
    json = File.read('db/townhalls.JSON') #chemin pour accéder au fichier JSON
      obj = JSON.parse(json)
      obj.each do |townhalls| #création de mails
        Mailer.new.send_mail(townhalls[0], townhalls[2])
        break
      end
  end
end
