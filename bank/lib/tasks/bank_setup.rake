require 'open-uri'

namespace :bank do

    task :setup do
        Rake::Task['bank:setup_accounts'].invoke
    end

    task :setup_accounts => :environment do
        puts "Adicionando titular..."
        Holder.new do |h|
            h.name = "Fabrício Ceschin"
            h.cpf = "087.461.979-31"
            h.save!
            @holder = h
        end
        puts "Adicionando conta..."
        Account.new do |a|
            a.holder = @holder
            a.agency = "1234-5"
            a.account = "12345-6"
            a.password = "123456"
            a.balance = 500.0
            a.transaction_balance = 500.0
            a.save!
            @account = a
        end
        puts "Adicionando cartão..."
        Card.new do |c|
            c.account = @account
            c.number = "1234567890123456"
            c.expiration_date = Time.now + 4.year
            c.security_code = "123"
            c.password = "123456"
            c.save!
        end
    end
end