defmodule Morse do
  def test do
    base = MorseCode.base()
    rolled = MorseCode.rolled()
    IO.puts(decode(base))
    IO.puts(decode(rolled))
    IO.puts(decode(encode(MorseCode.text())))
    name = encode('theodor bjoerkman')
    IO.inspect(name)
    IO.puts(decode(name))
  end

  def encode text do
    encode(text, encode_table(MorseCode.tree()))
  end
  def encode text, table do
    encode(text, table, '')
  end
  def encode [], _, code do # End of char array
    Enum.reduce(code, '', fn x, y -> x++' '++y end)
  end
  def encode [head|tail], table, code do
    encode(tail, table, [encode_char(head,table)]++code)
  end

  def encode_char char, table do
    {_, code} = List.keyfind(table, char, 0)
    code
  end

  def encode_table {_,_,dash,dot} do
    encode_table(dash, '-')++encode_table(dot, '.')
  end
  def encode_table nil, code do # Leaf
    []
  end
  def encode_table {_,char,dash,dot}, code do # Traverses all branches at once, eats the stack but small tree so its ok
    [{char, code}]++encode_table(dash, code++'-')++encode_table(dot, code++'.')
  end

  def decode signal do
    decode(signal, MorseCode.tree())
  end
  def decode signal, tree do
    decode(signal, tree, "")
  end
  def decode [], _, message do # Nothing more to decode
    String.reverse(message)
  end
  def decode signal, tree, message do # Decode each char by itself
    {char, rest} = decode_char(signal, tree)
    decode(rest, tree, <<char>><>message)
  end



  def decode_char [], {_,char,dash,dot} do # If no space at end
    {char,[]}
  end
  def decode_char [head|tail], {_,char,dash,dot} do
    case head do
      46 -> # dot
        decode_char(tail, dot)
      45 -> # dash
        decode_char(tail, dash)
      32 -> # space
        {char, tail}
    end
  end
end
