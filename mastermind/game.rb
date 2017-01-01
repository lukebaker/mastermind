module Mastermind
  module Game
    def Game.evaluate(guess, secret)
      correct_attack = 0
      guess.each_index do |index|
        correct_attack += 1 if guess[index] == secret[index]
      end
      correct_weapon = secret.size - (secret - guess).count
      [correct_weapon, correct_attack]
    end
  end
end
