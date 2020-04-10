# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

def title(value)
  puts "---===#{value}===---"
end

def separator
  puts '----------------------'
end

title('Создание команд')
2.times { Command.create(title: Faker::Sports::Football.team) }
title('Успешно')
title('Создание игроков')
Command.all.each { |command| 5.times { command.players.create(name: Faker::Sports::Football.player, number: Faker::Number.digit) } }
title('Успешно')
title('Создание целевых индикаторов')
Indicator.create(kind: 'target', title: 'Забито голов', value: '1' )
Indicator.create(kind: 'target', title: 'Отдано пасов', value: '1' )
title('Успешно')
title('Создание матчей')
3.times { Game.create(commands: [Command.first, Command.last]) }
title('Успешно')

command1 = Command.first
command2 = Command.last

player1_1 = command1.players.first
player1_2 = command1.players.second

player2_1 = command2.players.first
player2_2 = command2.players.second

[player1_1, player1_2].each do |p|
  p.gain_indicator(Game.first, Indicator.first)
  p.gain_indicator(Game.first, Indicator.last)
  p.gain_indicator(Game.second, Indicator.first)
  p.gain_indicator(Game.last, Indicator.last)
end

[player2_1, player2_2].each do |p|
  p.gain_indicator(Game.last, Indicator.last)
  p.gain_indicator(Game.second, Indicator.first)
end
separator
separator
title('Статистика')
puts '* По игрокам'
separator

Player.all.each do |player|
  Indicator.target.each do |indicator|
    puts "Игрок #{player.name}, номер #{player.number} достигал целевых показателей #{indicator.title} - #{indicator.value} за последние 5 игр? #{player.gain_indicator? indicator}"
    separator
  end
end
separator
puts '* По индикаторам'
Indicator.target.each do |indicator|
  separator
  puts "Топ 5 игроков индикатора #{indicator.title} - #{indicator.value}"
  puts "Командный зачёт."
  Command.all.each do |command|
    puts
    puts "Команда #{command.title}"
    separator
    top = indicator.top_players(scope: command)
    top.each{|p| puts "#{p.name} #{p.indicators.count}"}
  end
  separator
  puts "Общий зачёт."
  separator
  top = indicator.top_players
  top.each{|p| puts "#{p.name} #{p.indicators.count}"}
end


