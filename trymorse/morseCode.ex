defmodule MorseCode do

  # The codes that you should decode:

  def base, do: '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ...'

  def rolled, do: '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .----'

  # The decoding tree.
  #
  # The tree has the structure  {:node, char, long, short} | :nil
  #

  def text do
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et leo duis ut diam. Nam libero justo laoreet sit amet cursus sit. Consectetur libero id faucibus nisl tincidunt eget nullam. Commodo odio aenean sed adipiscing. Ultrices eros in cursus turpis massa. Tellus at urna condimentum mattis pellentesque id. Quis hendrerit dolor magna eget est lorem. Nunc congue nisi vitae suscipit tellus. Aliquam ut porttitor leo a diam sollicitudin tempor id. Fusce id velit ut tortor pretium viverra suspendisse potenti nullam. Fringilla urna porttitor rhoncus dolor purus non enim. Suscipit tellus mauris a diam maecenas. Sed sed risus pretium quam vulputate dignissim suspendisse in. Auctor augue mauris augue neque gravida in fermentum et. Odio aenean sed adipiscing diam donec adipiscing. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Faucibus in ornare quam viverra orci. Vestibulum morbi blandit cursus risus at ultrices mi tempus imperdiet. Proin sagittis nisl rhoncus mattis rhoncus urna neque. Amet dictum sit amet justo donec enim diam vulputate ut. Tempor orci eu lobortis elementum nibh. Varius sit amet mattis vulputate enim nulla aliquet. Non diam phasellus vestibulum lorem sed risus ultricies. Velit dignissim sodales ut eu sem integer vitae. Bibendum enim facilisis gravida neque convallis. Quisque sagittis purus sit amet volutpat consequat. Molestie nunc non blandit massa. Ac placerat vestibulum lectus mauris ultrices eros in cursus turpis. Sed risus ultricies tristique nulla. Aliquet nec ullamcorper sit amet risus nullam eget felis eget. Viverra nibh cras pulvinar mattis nunc. Vivamus arcu felis bibendum ut tristique et egestas. Lobortis feugiat vivamus at augue eget arcu dictum varius duis. Nulla pellentesque dignissim enim sit amet venenatis. Rhoncus aenean vel elit scelerisque mauris. Convallis posuere morbi leo urna molestie at elementum eu. Sagittis nisl rhoncus mattis rhoncus urna neque. Ut faucibus pulvinar elementum integer enim neque volutpat ac. Cursus mattis molestie a iaculis at. Non blandit massa enim nec dui. Nulla facilisi nullam vehicula ipsum a arcu. Diam in arcu cursus euismod quis. Diam quam nulla porttitor massa id neque aliquam vestibulum morbi. Cras pulvinar mattis nunc sed blandit libero. Lacinia at quis risus sed vulputate. Scelerisque viverra mauris in aliquam sem fringilla. Vulputate sapien nec sagittis aliquam malesuada. Nunc lobortis mattis aliquam faucibus purus in massa tempor. Vulputate odio ut enim blandit. Erat velit scelerisque in dictum non consectetur. Elementum curabitur vitae nunc sed velit dignissim. Pulvinar etiam non quam lacus suspendisse faucibus interdum posuere lorem. Aliquam id diam maecenas ultricies. Ut porttitor leo a diam sollicitudin tempor id eu nisl. Interdum velit euismod in pellentesque massa. Et pharetra pharetra massa massa. Lorem dolor sed viverra ipsum nunc. Id cursus metus aliquam eleifend mi in nulla posuere. Duis at consectetur lorem donec massa sapien faucibus. Ultricies tristique nulla aliquet enim tortor at auctor urna. Sit amet venenatis urna cursus eget nunc scelerisque. Eget magna fermentum iaculis eu non. Parturient montes nascetur ridiculus mus mauris vitae ultricies. Aliquam eleifend mi in nulla posuere sollicitudin aliquam. Facilisis volutpat est velit egestas dui. Commodo quis imperdiet massa tincidunt nunc pulvinar sapien. In fermentum et sollicitudin ac orci phasellus egestas tellus. Morbi tristique senectus et netus et malesuada. Ut pharetra sit amet aliquam id. Risus at ultrices mi tempus imperdiet nulla. Ornare arcu dui vivamus arcu felis bibendum. Tellus in hac habitasse platea. Eu scelerisque felis imperdiet proin fermentum. Neque gravida in fermentum et sollicitudin ac orci phasellus egestas. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Viverra adipiscing at in tellus. Risus pretium quam vulputate dignissim suspendisse in. Ut enim blandit volutpat maecenas volutpat blandit aliquam etiam erat. Ac turpis egestas maecenas pharetra convallis posuere morbi. Morbi tempus iaculis urna id. Id nibh tortor id aliquet lectus proin nibh nisl condimentum. Nisi scelerisque eu ultrices vitae auctor eu. Ac feugiat sed lectus vestibulum mattis ullamcorper. Sit amet venenatis urna cursus. Vel elit scelerisque mauris pellentesque pulvinar. Justo nec ultrices dui sapien. In eu mi bibendum neque egestas congue quisque. Viverra nibh cras pulvinar mattis nunc sed. Tellus in metus vulputate eu scelerisque felis. Quis vel eros donec ac odio tempor orci. Ullamcorper dignissim cras tincidunt lobortis. Nunc non blandit massa enim nec dui nunc mattis enim. Odio tempor orci dapibus ultrices in iaculis nunc sed. Mauris pellentesque pulvinar pellentesque habitant morbi. Faucibus vitae aliquet nec ullamcorper. Nulla posuere sollicitudin aliquam ultrices. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit amet. Ultrices vitae auctor eu augue ut lectus arcu. Montes nascetur ridiculus mus mauris vitae ultricies. Facilisi cras fermentum odio eu feugiat. Pretium viverra suspendisse potenti nullam ac tortor. Facilisi nullam vehicula ipsum a. Et netus et malesuada fames ac turpis egestas sed. Justo donec enim diam vulputate ut pharetra sit amet. Nam at lectus urna duis convallis convallis tellus id interdum. Leo vel orci porta non pulvinar neque laoreet. Risus feugiat in ante metus dictum at tempor commodo ullamcorper. Eu volutpat odio facilisis mauris sit. Commodo quis imperdiet massa tincidunt nunc. Congue nisi vitae suscipit tellus mauris a diam maecenas sed. Risus quis varius quam quisque id. Massa vitae tortor condimentum lacinia quis vel eros donec. Faucibus interdum posuere lorem ipsum dolor sit amet consectetur adipiscing. Nisl rhoncus mattis rhoncus urna neque viverra justo. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae. Curabitur vitae nunc sed velit dignissim sodales. Vel turpis nunc eget lorem. Nullam eget felis eget nunc lobortis mattis aliquam faucibus. Sed lectus vestibulum mattis ullamcorper velit sed. In tellus integer feugiat scelerisque. Non enim praesent elementum facilisis leo vel fringilla est. Ut etiam sit amet nisl purus in mollis nunc. Malesuada fames ac turpis egestas maecenas. Pellentesque adipiscing commodo elit at. Vivamus at augue eget arcu dictum varius duis at. Eros in cursus turpis massa tincidunt dui ut. Mauris sit amet massa vitae. Egestas sed tempus urna et pharetra pharetra massa. Tortor dignissim convallis aenean et tortor at risus viverra. Adipiscing enim eu turpis egestas pretium aenean pharetra. Gravida cum sociis natoque penatibus et magnis dis parturient montes. Odio eu feugiat pretium nibh ipsum. Elementum eu facilisis sed odio morbi quis commodo odio. Mattis pellentesque id nibh tortor id. Nec feugiat nisl pretium fusce id velit. Neque volutpat ac tincidunt vitae semper. Interdum consectetur libero id faucibus nisl tincidunt. Diam donec adipiscing tristique risus nec feugiat. Pharetra vel turpis nunc eget lorem dolor sed viverra. Turpis massa sed elementum tempus egestas sed. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam."
    String.downcase(text)
    |> String.to_charlist()
  end

  def tree do
    {:node, :na,
      {:node, 116,
        {:node, 109,
          {:node, 111,
            {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
            {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
          {:node, 103,
            {:node, 113, nil, nil},
            {:node, 122,
              {:node, :na, {:node, 44, nil, nil}, nil},
              {:node, 55, nil, nil}}}},
        {:node, 110,
          {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
          {:node, 100,
            {:node, 120, nil, nil},
            {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
      {:node, 101,
        {:node, 97,
          {:node, 119,
            {:node, 106,
              {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
              nil},
            {:node, 112,
              {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
              nil}},
          {:node, 114,
            {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
            {:node, 108, nil, nil}}},
        {:node, 105,
          {:node, 117,
            {:node, 32,
              {:node, 50, nil, nil},
              {:node, :na, nil, {:node, 63, nil, nil}}},
            {:node, 102, nil, nil}},
          {:node, 115,
            {:node, 118, {:node, 51, nil, nil}, nil},
            {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
  end

  end
