namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://assets.chinatechnews.com/wp-content/uploads/bitcoin-logo.jpg",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },
                {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZCRfwkqpPvFb3QmmwGONG2i6PsgnqZ3L7dRzCNlaSTB1-ruu5",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://ih1.redbubble.net/image.406055498.8711/ap,550x550,12x12,1,transparent,t.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://www.cryptocompare.com/media/351360/zec.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Nathan",
                  acronym: "NATH",
                  url_image: "data:image/jpeg;base64,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",
                  mining_type: MiningType.all.sample
                }
              ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end

    end
  end


  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
