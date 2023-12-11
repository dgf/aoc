image = map(first, split.(stdin |> readlines, "") |> stack |> permutedims)
galaxies = findall(isequal('#'), image)
spaceRows = findall([all(image[r, :] .== '.') for r in axes(image, 1)])
spaceCols = findall([all(image[:, c] .== '.') for c in axes(image, 2)])

function sumDistances(expansion)
  distance = 0
  for (s, source) in enumerate(galaxies)
    for (_, target) in enumerate(Iterators.drop(galaxies, s))
      rowMin, rowMax = minmax(source[1], target[1])
      colMin, colMax = minmax(source[2], target[2])
      spaceRowCount = count(rowMin <= r <= rowMax for r in spaceRows)
      spaceColCount = count(colMin <= c <= colMax for c in spaceCols)
      distance += (rowMax - rowMin + (spaceRowCount * (expansion - 1))) +
                  (colMax - colMin + (spaceColCount * (expansion - 1)))
    end
  end
  println("distances (", expansion, "): ", distance)
end

sumDistances(2)
sumDistances(10)
sumDistances(100)
sumDistances(1000000)

