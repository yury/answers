module Finder

  START_ELEM = 1

  def find_missing sequence
    len = sequence.length
    if len == 0 || sequence[0] == START_ELEM + 2
      return [START_ELEM, START_ELEM + 1]
    elsif len == 1
      return (START_ELEM..START_ELEM+2).to_a - sequence
    elsif sequence[-1] - START_ELEM == len - 1
      return [len + START_ELEM, len + START_ELEM + 1]  
    end

    res =  []
    res += [START_ELEM] if sequence[0] == START_ELEM + 1
    res += _find_missing sequence, 0, len - 1
    res += [len + START_ELEM + 1] if sequence[-1] - START_ELEM == len
    res
  end

  private

  def _find_missing sequence, si0, si1
    res = []
    mi = (si1 - si0) / 2 + si0
    [[si0, mi], [mi, si1]].each do |i0, i1|
      di = i1 - i0 # delta index
      v0 = sequence[i0]
      dv = sequence[i1] - v0 # delta value
      if (d = dv - di) > 0
        if di == 1 # we got pair
          res += (v0+1..v0+d).to_a
        else
          res += _find_missing sequence, i0, i1
        end
      end
    end
    res
  end
end