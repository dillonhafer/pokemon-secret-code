class CharacterTable
  CHARACTER_TABLE = {
    " " => 127,
    "A" => 128,
    "B" => 129,
    "C" => 130,
    "D" => 131,
    "E" => 132,
    "F" => 133,
    "G" => 134,
    "H" => 135,
    "I" => 136,
    "J" => 137,
    "K" => 138,
    "L" => 139,
    "M" => 140,
    "N" => 141,
    "O" => 142,
    "P" => 143,
    "Q" => 144,
    "R" => 145,
    "S" => 146,
    "T" => 147,
    "U" => 148,
    "V" => 149,
    "W" => 150,
    "X" => 151,
    "Y" => 152,
    "Z" => 153,
    "(" => 154,
    ")" => 154,
    ":" => 156,
    ";" => 157,
    "[" => 158,
    "]" => 159,
    "a" => 160,
    "b" => 161,
    "c" => 162,
    "d" => 163,
    "e" => 164,
    "f" => 165,
    "g" => 166,
    "h" => 167,
    "i" => 168,
    "j" => 169,
    "k" => 170,
    "l" => 171,
    "m" => 172,
    "n" => 173,
    "o" => 174,
    "p" => 175,
    "q" => 176,
    "r" => 177,
    "s" => 178,
    "t" => 179,
    "u" => 180,
    "v" => 181,
    "w" => 182,
    "x" => 183,
    "y" => 184,
    "z" => 185,
    "<" => 225,
    ">" => 226,
    "-" => 227,
    "?" => 230,
    "!" => 231,
    "." => 232,
    "×" => 241,
    "*" => 241,
    "/" => 243,
    "," => 244
  }

  def self.find(v)
    CHARACTER_TABLE.fetch(v, 0)
  end
end

class SecretGenerator
  MAX_16_NUMBER = 65535
  attr_reader :trainer_id, :cash, :name

  def initialize(trainer_id:, cash:, name:)
    @trainer_id = trainer_id
    @cash = cash
    @name = name
  end

  def secret_code
    [
      name_value,
      cash_value,
      id_value
    ].sum.to_s.rjust(5, "0")
  end

  private

  def mod_256(value)
    bits = 256
    (value / bits).truncate + value % bits
  end

  def name_value
    name[0...5].chars.map { CharacterTable.find(_1) }.sum
  end

  def cash_value
    if cash > MAX_16_NUMBER
      mod_256(cash % MAX_16_NUMBER)
    else
      mod_256(cash)
    end
  end

  def id_value
    id_safe_16 = trainer_id
    while id_safe_16 > MAX_16_NUMBER
      id_safe_16 -= [cash, 1].max
    end

    mod_256(id_safe_16)
  end
end
