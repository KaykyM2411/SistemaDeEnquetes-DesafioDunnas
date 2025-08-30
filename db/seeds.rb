puts "Criando usuarios..."
# Verifique se os usuários já existem para evitar duplicatas
admin = User.find_or_create_by(email: "admin123@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 1
end

kayky = User.find_or_create_by(email: "kaykymarcelo@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 0
end

joao = User.find_or_create_by(email: "joao@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 0
end

maria = User.find_or_create_by(email: "maria@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 0
end

camille = User.find_or_create_by(email: "camille@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 0
end

andre = User.find_or_create_by(email: "andre@gmail.com") do |user|
  user.password = "123456"
  user.user_type = 0
end

puts "Usuarios criados com sucesso!"

# ---

puts "Criando enquetes..."

# Enquete do Kayky
poll1 = Poll.create!(
  user: kayky,
  user_email: kayky.email,
  question: "Qual sua linguagem de programação favorita?",
  poll_type: "single",
  status: "open"
)
poll1.options.create!([{ content: "Ruby" }, { content: "JavaScript" }, { content: "Python" }])

# Enquete do João
poll2 = Poll.create!(
  user: joao,
  user_email: joao.email,
  question: "Qual o melhor sistema operacional para desenvolvedores?",
  poll_type: "single",
  status: "open"
)
poll2.options.create!([{ content: "Linux" }, { content: "macOS" }, { content: "Windows" }])

# Enquete da Maria (fechada)
poll3 = Poll.create!(
  user: maria,
  user_email: maria.email,
  question: "Qual framework web você prefere para back-end?",
  poll_type: "single",
  status: "closed"
)
poll3.options.create!([{ content: "Ruby on Rails" }, { content: "Django" }, { content: "Express.js" }])

# Enquete do André (múltipla escolha)
poll4 = Poll.create!(
  user: andre,
  user_email: andre.email,
  question: "Quais destas tecnologias você usa no seu dia a dia?",
  poll_type: "multiple",
  status: "open"
)
poll4.options.create!([{ content: "React" }, { content: "Angular" }, { content: "Vue.js" }, { content: "Svelte" }])

puts "Enquetes criadas com sucesso!"
