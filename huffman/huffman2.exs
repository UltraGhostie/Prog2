defmodule Huffman2 do
  import Toolbox
  import Encode
  import Decode
  import Tree
  def sample do
    'FÃ¶rsta kapitlet
    Den bok jag nu sÃ¤tter mig ner att skriva mÃ¥ste verka meningslÃ¶s pÃ¥ mÃ¥nga - om jag alls vÃ¥gar tÃ¤nka mig, att "mÃ¥nga" fÃ¥r lÃ¤sa den - eftersom jag alldeles sjÃ¤lvmant, utan nÃ¥gons order, bÃ¶rjar ett sÃ¥dant arbete och Ã¤ndÃ¥ inte sjÃ¤lv Ã¤r riktigt pÃ¥ det klara med vad avsikten Ã¤r. Jag vill och mÃ¥ste, det Ã¤r alltsammans. Allt mer och mer obÃ¶nhÃ¶rligt frÃ¥gar man efter avsikten och planmÃ¤ssigheten i vad som gÃ¶res och sÃ¤ges, sÃ¥ att helst inte ett ord ska falla pÃ¥ mÃ¥fÃ¥ - det Ã¤r bara fÃ¶rfattaren till den hÃ¤r boken som har tvingats gÃ¥ motsatta vÃ¤gen, ut i det Ã¤ndamÃ¥lslÃ¶sa. Ty fast mina Ã¥r hÃ¤r som fÃ¥nge och kemist - de mÃ¥ste vara Ã¶ver tjugu, tÃ¤nker jag mig - har varit fulla nog Ã¤ndÃ¥ av arbete och brÃ¥dska, mÃ¥ste det finnas nÃ¥got som inte tycker det Ã¤r tillrÃ¤ckligt och som har lett och Ã¶verblickat ett annat arbete inom mig, ett som jag sjÃ¤lv inte hade nÃ¥gon mÃ¶jlighet att Ã¶verblicka och dÃ¤r jag Ã¤ndÃ¥ har varit djupt och nÃ¤stan plÃ¥gsamt medintresserad. Det arbetet kommer att vara slutfÃ¶rt, nÃ¤r jag vÃ¤l har skrivit ner min bok. Jag inser alltsÃ¥, hur fÃ¶rnuftsvidriga mina skriverier mÃ¥ste te sig infÃ¶r allt rationellt och praktiskt tÃ¤nkande, men jag skriver Ã¤ndÃ¥.abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ!?'
  end

  def text do
    'test'
  end

  def test do
    text = read("text.txt")
    IO.puts("Sampling")
    tree = text |> tree()
    IO.puts("Calculating encoding")
    encode = encode_table(tree)
    # decode = decode_table(tree)
    IO.puts("Encoding")
    num = encode(text, encode)
    IO.puts("Decoding")
    text = decode(num, encode) |> List.flatten()
    IO.puts("Writing")
    text = List.to_string(text)
    File.write("test.txt", text)
  end
end
