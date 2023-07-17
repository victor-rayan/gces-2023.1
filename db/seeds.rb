# db/seeds.rb

# Criação do administrador Decidim::System::Admin com os atributos fornecidos
Decidim::System::Admin.new(email: 'ajuda@gmail.com', password: 'teste123', password_confirmation: 'teste123').save!(validate: false)
