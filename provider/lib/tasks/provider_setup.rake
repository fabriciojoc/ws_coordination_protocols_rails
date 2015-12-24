require 'open-uri'

namespace :provider do

    task :setup do
        Rake::Task['provider:setup_products'].invoke
    end

    task :setup_products => :environment do
        photos = Rails.root.join('lib/tasks/images/')
        puts "Adicionando produtos..."

        Category.new do |c|
            c.name = "Corrida"
            c.description = "Jogos de Corrida"
            c.save!
            Product.new do |p|
                p.name = "Project CARS"
                p.description = "<p>Project CARS é a jornada suprema do motorista! Guiado, testado e aprovado por uma comunidade de fãs apaixonada por corrida e motoristas reais, Project CARS representa a próxima geração de simuladores de corrida, combinando os desejos dos fãs e o conhecimento do produtor. </p>
                                 <p>Desfrute de uma imersão incomparável abastecida com gráficos de alta qualidade e um controle que permitira que você sinta a pista de verdade. Crie um motorista, faça sua escolha a partir de uma variedade de esportes automobilísticos num modo de carreira dinâmico e escreva sua própria história num intenso jogo online de multi-jogadores.</p>"
                p.photo = open(photos + "pcars.jpg")
                p.video = "pPnPJXE2fhw"
                p.price = 129.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end

            Product.new do |p|
                p.name = "F1 2015"
                p.description = "<p>Pilote como um campeão no F1 2015; viva a experiência de pilotar no esporte motorizado mais glamoroso, emocionante e prestigiado do mundo. F1 2015 coloca você no centro da ação, graças a um novo mecanismo incrível que recria a velocidade alucinante e a altíssima capacidade de resposta dos carros de FÓRMULA 1™, incluindo uma nova transmissão televisiva que mergulha você na atmosfera única das corridas. Pilote na pele da sua estrela favorita da FÓRMULA 1 no novo Championship Season e ultrapasse seus limites no desafiante modo Pro Season. </p>"
                p.photo = open(photos + "f12015.jpg")
                p.video = "_HCwHyp1mKc"
                p.price = 97.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end
        end

        Category.new do |c|
            c.name = "Ação"
            c.description = "Jogos de Ação"
            c.save!
            Product.new do |p|
                p.name = "Grand Theft Auto V"
                p.description = "<p>Quando um malandro de rua, um ladrão de bancos aposentado e um psicopata aterrorizante se envolvem com alguns dos criminosos mais assustadores e loucos do submundo, o governo dos EUA e a indústria do entretenimento, eles devem realizar golpes ousados para sobreviver nessa cidade implacável onde não podem confiar em ninguém, nem mesmo um no outro.</p> 
                                 <p>Grand Theft Auto V para PC oferece aos jogadores a opção de explorar o gigantesco e premiado mundo de Los Santos e Blaine County em resoluções de até 4K e além, assim como a chance de experimentar o jogo rodando a 60 FPS (quadros por segundo).</p> "
                p.photo = open(photos + "gtav.jpg")
                p.video = "kFhkHFSytVU"
                p.price = 99.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end

            Product.new do |p|
                p.name = "Max Payne 3"
                p.description = "<p>Ainda sendo caçado pelas memórias de seu passado traumatizante, Max começa uma nova vida trabalhando como segurança privado para uma rica família em São Paulo, Brasil. Até que uma gangue marca a família que ele protegia, forçando Max a lutar para salvar seus clientes e limpar seu nome, e assim também, se ver livre de uma vez por todas de seus demônios que o torturam desde muito tempo atrás.</p>"
                p.photo = open(photos + "maxpayne3.jpg")
                p.video = "4Uc_dbG7MR8"
                p.price = 59.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end

            Product.new do |p|
                p.name = "ARK: Survival Evolved"
                p.description = "<p>Survival Evolved é um game de mundo aberto no qual os jogadores precisam sobreviver em uma ilha. Entretanto, nada como o que foi visto em “Náufrago” ou algo do gênero: aqui, os seus algozes serão dinossauros (e até mesmo um dragão, como é possível ver no final do vídeo que abre esta notícia).</p>
                                 <p>Para sobreviver nesse mundo, os jogadores terão que caçar recursos para construir armas capazes de ferir as criaturas e até mesmo construir um abrigo que seja seguro durante a sua estada nesse mundo. Além disso, também há a possibilidade de domesticar mais de 60 tipos de dinossauros e usar suas forças e habilidades enquanto explora esse universo.</p>"
                p.photo = open(photos + "ark.jpg")
                p.video = "FW9vsrPWujI"
                p.price = 44.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end

            Product.new do |p|
                p.name = "Counter-Strike: GO"
                p.description = "<p>Counter-Strike: Global Offensive (CS: GO) expandirá na jogabilidade de ação baseada em equipes na qual foi pioneiro quando foi lançado há 12 anos.
                                    CS: GO contém novos mapas, personagens e armas, além de conter versões atualizadas de conteúdos do CS clássico (como de_dust). Além disso, CS: GO introduzirá novos modos de jogo, criação de partidas (matchmaking), placares de líderes e mais.</p>"
                p.photo = open(photos + "csgo.jpg")
                p.video = "RzZ2bWZ_8Ho"
                p.price = 24.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end

            Product.new do |p|
                p.name = "H1Z1"
                p.description = "<p>H1Z1 é um MMO free-to-play no estilo sandbox, ou seja, em mundo aberto que ocorre 15 anos após um vírus quase devastar toda humanidade. Os jogadores lutam pela sobrevivência em um mundo onde a morte é a única coisa certa. </p>
                                 <p>O vírus H1Z1 devastou a humanidade deixando um rastro de morte e destruição em seu caminho, e um mundo praticamente vazio de vida onde os remanescentes da humanidade estão em uma luta constante contra a extinção, e contra os animais e pessoas que foram infectadas pelo vírus.</p>"
                p.photo = open(photos + "h1z1.jpg")
                p.video = "_Ko5AXctkIE"
                p.price = 36.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end
        end

        Category.new do |c|
            c.name = "Esportes"
            c.description = "Jogos de Esportes"
            c.save!
            Product.new do |p|
                p.name = "Rocket League"
                p.description = "<p>Rocket League é a sequência de um game para PS3, que retorna com a mesma proposta: ser um futebol de carros. Disponível para PC e PS4, o título tem mecânica divertida e controles simples, mas sem deixar de lado elementos de simulação.</p>"
                p.photo = open(photos + "rocketleague.jpg")
                p.video = "Vawwy2eu5sA"
                p.price = 36.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end
        end

        Category.new do |c|
            c.name = "Estratégia"
            c.description = "Jogos de Estratégia"
            c.save!
            Product.new do |p|
                p.name = "Age of Empires 2 HD"
                p.description = "<p>O Age of Empires 2: HD Edition é um clássico jogo de estratégia para Windows que ganha um relançamento em alta definição e outras novidades. O título, lançado originalmente em 1999, retorna com todos os elementos que fizeram sua fama. Não deixe de baixar Age of Empires 2: HD Edition e confira!</p>
                                 <p>Os fãs do game original podem curtir todo o seu conteúdo da forma que o conheciam, como as facções originais e também da expansão, Conquerors, que está dentro do pacote comercializado no Steam. O relançamento foi realizado pela própria Microsoft, também responsável pela primeira versão.</p>"
                p.photo = open(photos + "age2.jpg")
                p.video = "q_MEFt7KrxQ"
                p.price = 36.99
                p.amount = 50
                p.transaction_amount = 50
                p.category = c
                p.save!
                c.save!
            end
        end
    end
end