module Coords
  def coords_between(coord_1, coord_2)
    n1 = coord_1[1]
    l1 = coord_1[0]
    n2 = coord_2[1]
    l2 = coord_2[0]

    result = []

    if n1 == n2
      if l2 < l1
        (l2..l1).to_a.each do |x|
          result << "#{x}#{n1}"
        end
      else
        (l1..l2).to_a.each do |x|
          result << "#{x}#{n1}"
        end
      end
    elsif l1 == l2
      if n2 < n1
        (n2..n1).to_a.each do |x|
          result << "#{l1}#{x}"
        end
      else
        (n1..n2).to_a.each do |x|
          result << "#{l1}#{x}"
        end
      end
    end

    result
  end

  def coord_distance(coord_1, coord_2)
    n1 = coord_1[1]
    l1 = coord_1[0]
    n2 = coord_2[1]
    l2 = coord_2[0]

    distance = 0

    if n1 == n2
      inverted = alpha_hash.invert
      distance = (inverted[l1] - inverted[l2]).abs
    elsif l1 == l2
      distance = (n1.to_i - n2.to_i).abs
    end

    distance + 1
  end

  def is_coord_valid?(coord)
    let = coord[0]
    num = coord[1].to_i

    return false if num > size || num < 0
    return false unless @allowed_letters.include?(let)

    true
  end

  def is_placement_valid?(coord_1, coord_2, ship_size)
    return false if !is_coord_valid?(coord_1) || !is_coord_valid?(coord_2) # If either coord isn't valid, return fail

    distance = coord_distance(coord_1, coord_2)

    return false if distance == 0

    return false if distance != ship_size

    all_cells_empty = true

    coords_between(coord_1, coord_2).each do |coord|
      all_cells_empty = false unless is_cell_empty?(coord)
    end

    return false unless all_cells_empty

    true
  end

  def alpha_hash
    alpha_hash = {}
    counter = 1
    ('A'..'Z').each do |x|
      alpha_hash[counter] = x
      counter += 1
    end
    alpha_hash
  end
end
