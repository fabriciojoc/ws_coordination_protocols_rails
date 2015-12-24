require 'open-uri'

namespace :store do

    task :setup do
        Rake::Task['store:setup_store'].invoke
    end

    task :setup_store => :environment do
        puts "Adicionando administrador..."
        User.new do |u|
            u.name = "User"
            u.email = "user@gmail.com"
            u.password = "123456"
            u.password_confirmation = "123456"
            u.role = "admin"
            u.save!
        end
        puts "Adicionando fornecedor..."
        Provider.new do |p|
            p.name = "Games Provider"
            p.description = "Fornecedora de Jogos"
            p.percentage = 1.2
            p.wsdl_location = "http://localhost:3001/provider/wsdl"
            p.save!
        end
        puts "Adicionando banco..."
        Bank.new do |b|
            b.name = "Banco do Brasil"
            b.wsdl_location = "http://localhost:3002/bank/wsdl"
            b.save!
        end
    end
end