class Ohm::Model::Set
  def intersect(other_set)
    key.sinter(other_set.key).map(&model)
  end
end